const { World } = require('./world');
const { Given, When, Then, setWorldConstructor, Before, After } = require('@cucumber/cucumber');
const { Pool } = require('pg');

setWorldConstructor(World);

let pool = undefined;
let logSqlStatements = false;

const propertyNameMap = new Map([

    // nationaliteit
    ['nationaliteit (05.10)', 'nationaliteit.code'],
    ['reden opnemen (63.10)', 'redenOpname.code'],
    ['reden beëindigen (64.10)', 'redenBeeindigen.code'],
    ['datum ingang geldigheid (85.10)', 'datumIngangGeldigheid'],

]);

const tableNameMap = new Map([
    ['persoonlijst', 'lo3_pl'],
    ['persoon', 'lo3_pl_persoon' ],
    ['nationaliteit', 'lo3_pl_nationaliteit']
]);

const columnNameMap = new Map([
    ['nationaliteit (05.10)', 'nationaliteit_code'],
    ['reden opnemen (63.10)', 'nl_nat_verkrijg_reden'],
    ['reden beëindigen (64.10)', 'nl_nat_verlies_reden'],
    ['datum ingang geldigheid (85.10)', 'geldigheid_start_datum'],
]);

function getPropertyNames(dataTable) {
    let columns = dataTable.raw()[0];
    columns.forEach(function(column, index) {
        let propertyName = propertyNameMap.get(column);
        if(propertyName !== undefined) {
            columns[index] = propertyName;
        }
    });
    return columns;
}

function getColumnNames(dataTable) {
    let columns = dataTable.raw()[0];
    columns.forEach(function(column, index) {
        let propertyName = columnNameMap.get(column);
        if(propertyName !== undefined) {
            columns[index] = propertyName;
        }
    });
    return columns;
}

function toCollectionName(gegevensgroep) {
    switch(gegevensgroep) {
        case 'partner':
            return 'partners';
        case 'ouder':
            return 'ouders';
        case 'kind':
            return 'kinderen';
        case 'nationaliteit':
            return 'nationaliteiten';
        default:
            return undefined;
    }
}

function setProperty(obj, propertyName, propertyValue) {
    if(propertyValue === undefined || propertyValue === '') {
        return;
    }

    if(propertyName.includes('.')) {
        let propertyNames = propertyName.split('.');
        let property = obj;

        propertyNames.forEach(function(propName, index) {
            if(index === propertyNames.length-1) {
                property[propName] = propertyValue; 
            }
            else {
                if(property[propName] === undefined) {
                    property[propName] = {};
                }
                property = property[propName];
            }
        });
    }
    else {
        obj[propertyName] = propertyValue;
    }
}

function isBeeindigd(row) {
    return row['redenBeeindigen.code'] !== undefined && row['redenBeeindigen.code'] !== '';
}

function createInsertPersoonlijstStatement(geheimhouding) {
    const statement = {
        text: 'INSERT INTO public.lo3_pl(pl_id,geheim_ind,mutatie_dt) VALUES((SELECT MAX(pl_id)+1 FROM public.lo3_pl), $1, current_timestamp) RETURNING *',
        values: [ geheimhouding ]
    };

    if(logSqlStatements) {
        console.log(statement);
    }
    return statement;
}

function createInsertPersoonStatement(plId, burgerservicenummer) {
    const statement = {
        text: 'INSERT INTO public.lo3_pl_persoon(pl_id,persoon_type,stapel_nr,volg_nr,burger_service_nr) VALUES($1,$2,$3,$4,$5)',
        values: [ plId, 'P', 0, 0, burgerservicenummer]
    };

    if(logSqlStatements) {
        console.log(statement);
    }
    return statement;
}

function createInsertStatement(tabelNaam, plId, stapelNr, volgNr, dataTable) {
    let statement = {
        text: `INSERT INTO public.${tableNameMap.get(tabelNaam)}(pl_id,stapel_nr,volg_nr`,
        values: [plId, stapelNr, volgNr]
    };

    const columnNames = getColumnNames(dataTable);

    dataTable.hashes().forEach(function(row) {
        columnNames.forEach(function(columnName) {
            statement.text += `,${columnName}`;
            statement.values.push(row[columnName]);
        });
    });

    statement.text += ') VALUES(';
    statement.values.forEach(function(_value, index) {
        statement.text += index === 0
            ? `$${index+1}`
            : `,$${index+1}`;
    });
    statement.text += ')';

    if(logSqlStatements) {
        console.log(statement);
    }
    return statement;
}

function createUpdateVolgnrStatement(tabelNaam, plId, stapelNr, volgNr, nieuwVolgnr) {
    let statement = {
        text: `UPDATE public.${tableNameMap.get(tabelNaam)} SET volg_nr=$1 WHERE pl_id=$2 AND stapel_nr=$3 AND volg_nr=$4`,
        values: [nieuwVolgnr, plId, stapelNr, volgNr]
    };

    if(logSqlStatements) {
        console.log(statement);
    }
    return statement;
}

function createDeleteStatement(tabelNaam, plId) {
    let statement = {
        text: `DELETE FROM public.${tableNameMap.get(tabelNaam)} WHERE pl_id=$1`,
        values: [plId]
    };

    if(logSqlStatements) {
        console.log(statement);
    }
    return statement;
}

Before(function() {
    if(this.context.sql.useDb) {
        pool = new Pool(this.context.sql.poolConfig);
        logSqlStatements = this.context.sql.logStatements;
    }
});

After(async function() {
    if(pool !== undefined) {
        const client = await pool.connect();
        try {
            await client.query(createDeleteStatement('persoonlijst', this.context.pl_id, this.context.sql.logStatements));
            await client.query(createDeleteStatement('persoon', this.context.pl_id, this.context.sql.logStatements));
            await client.query(createDeleteStatement('nationaliteit', this.context.pl_id, this.context.sql.logStatements));
        }
        finally {
            client.release();
        }
    }
});

Given(/^de persoon met burgerservicenummer '(.*)' heeft een '(.*)' met de volgende gegevens$/, async function (burgerservicenummer, gegevensgroep, dataTable) {
    if(pool !== undefined) {
        const client = await pool.connect();
        try {
            let res = await client.query(createInsertPersoonlijstStatement(0));
            this.context.pl_id = res.rows[0]["pl_id"];

            await client.query(createInsertPersoonStatement(this.context.pl_id, burgerservicenummer));

            this.context[`${gegevensgroep}-stapelnr`] = 0;
            this.context[`${gegevensgroep}-volgnr`] = 0;
            await client.query(createInsertStatement(gegevensgroep, this.context.pl_id, this.context[`${gegevensgroep}-stapelnr`], this.context[`${gegevensgroep}-volgnr`], dataTable)); 
        }
        finally {
            client.release();
        }
    }
    else {
        let persoon = this.context.persoon;
        persoon.burgerservicenummer = burgerservicenummer;
        persoon.geheimhoudingPersoonsgegevens = 0;
        persoon[toCollectionName(gegevensgroep)] = [];
    
        let gegevensgroepObj = {};
    
        const columnNames = getPropertyNames(dataTable);
    
        dataTable.hashes().forEach(function(row) {
            columnNames.forEach(function(columnName) {
                setProperty(gegevensgroepObj, columnName, row[columnName]);
            });
        });
    
        persoon[toCollectionName(gegevensgroep)].push(gegevensgroepObj);
    }
});

Given(/^de '(.*)' is gewijzigd naar de volgende gegevens$/, async function (gegevensgroep, dataTable) {
    if(pool !== undefined) {
        const client = await pool.connect();
        try {
            const laatsteVolgnr = this.context[`${gegevensgroep}-volgnr`];
            for(let volgnr = laatsteVolgnr; volgnr >= 0; volgnr-- ) {
                await client.query(createUpdateVolgnrStatement(gegevensgroep, this.context.pl_id, this.context[`${gegevensgroep}-stapelnr`], volgnr, volgnr+1));
            }
            this.context[`${gegevensgroep}-volgnr`] += 1;

            await client.query(createInsertStatement(gegevensgroep, this.context.pl_id, this.context[`${gegevensgroep}-stapelnr`], 0, dataTable)); 
        }
        finally {
            client.release();
        }
    }
    else {
        const persoon = this.context.persoon;
        const gegevensgroepCollectie = persoon[toCollectionName(gegevensgroep)];
        let gegevensgroepObj = gegevensgroepCollectie[gegevensgroepCollectie.length - 1];
    
        const columnNames = getPropertyNames(dataTable);
    
        dataTable.hashes().forEach(function(row) {
            columnNames.forEach(function(columnName) {
                const key = columnName === 'datumIngangGeldigheid' && isBeeindigd(row)
                    ? 'datumTot'
                    : columnName;
    
                    setProperty(gegevensgroepObj, key, row[columnName]);
            });
        });
    }
});

function createRequestBody(dataTable) {
    let requestBody = {};

    dataTable.hashes()
            .forEach(function(param) {
                if(param.naam === "fields") {
                    requestBody[param.naam] = param.waarde.split(',');
                }
                else {
                    requestBody[param.naam] = param.waarde;
                }
            });

    return requestBody;
}

When(/^(.*) wordt geraadpleegd met de volgende parameters$/, function (endpoint, dataTable) {        
    const config = {
        method: 'post',
        url: `/${endpoint}`,
        baseURL: this.context.serverUrl,
        data: createRequestBody(dataTable)
    };

    if(this.context.persoon !== undefined) {
        console.log(JSON.stringify(this.context.persoon, null, '  '));
    }

    console.log(config);
});

Then(/^heeft de response de volgende '(.*)'$/, function (gegevensgroepCollectie, dataTable) {
    let expected = {};
    expected[gegevensgroepCollectie] = [];

    const columnNames = getPropertyNames(dataTable);

    dataTable.hashes().forEach(function(row) {
        let gegevensgroepObj = {};

        columnNames.forEach(function(columnName) {
            setProperty(gegevensgroepObj, columnName, row[columnName]);
        });

        expected[gegevensgroepCollectie].push(gegevensgroepObj);
    });

    console.log(JSON.stringify(expected, null, '  '));
});

Then(/^heeft de response een leeg '(.*)' array$/, function (gegevensgroepCollectie) {
});
