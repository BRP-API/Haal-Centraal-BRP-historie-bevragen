function noSqlData(sqlData) {
    return sqlData === undefined ||
           (sqlData.length === 1 && Object.keys(sqlData[0]).length === 0);
}

function getAdresId(sqlData, adresIndex) {
    const adressenData = sqlData.find(e => Object.keys(e).includes('adres'));

    for(const key of Object.keys(adressenData.adres)) {
        if(adressenData.adres[key].index === adresIndex) {
            return adressenData.adres[key].data?.find(elem => elem[0] === 'adres_id')[1];
        }
    }
    return undefined;
}

function setAdresIdForVerblijfplaatsen(sqlDataElement, sqlData) {
    if(sqlDataElement['verblijfplaats'] === undefined) {
        return;
    }

    for(const verblijfplaatsElem of sqlDataElement['verblijfplaats']) {
        let adresIdElem = verblijfplaatsElem.find(elem => elem[0] === 'adres_id');
        if(adresIdElem !== undefined) {
            adresIdElem[1] = getAdresId(sqlData, Number(adresIdElem[1])) + '';
        }
    }
}

async function executeSqlStatements(sqlData, pool, tableNameMap, logSqlStatements) {
    if (pool === undefined || noSqlData(sqlData)) {
        return;
    }

    const client = await pool.connect();
    try {
        await client.query('BEGIN');

        for(const sqlDataElement of sqlData) {
            setAdresIdForVerblijfplaatsen(sqlDataElement, sqlData);

            await executeSql(client, sqlDataElement, tableNameMap, logSqlStatements);
        }

        await client.query('COMMIT');
    }
    catch(ex) {
        console.log(ex);
        await client.query('ROLLBACK');
    }
    finally {
        if(client !== undefined){
            client.release();
        }
    }
}

async function rollbackSqlStatements(sqlData, pool, tableNameMap, logSqlStatements, deleteIndividualRecords) {

    const client = await pool.connect();
    try {
        let adresData = [];

        for(const sqlDataElement of sqlData) {
            if (sqlDataElement['adres'] !== undefined) {
                adresData.push(sqlDataElement);
            }
            else {
                await deleteRecords(client, sqlDataElement, tableNameMap, logSqlStatements, deleteIndividualRecords);
            }
        }

        for(const adrData of adresData) {
            await deleteAdresRecord(client, adrData, tableNameMap, logSqlStatements);
        }
        await deleteGemeenteRecords(client, sqlData.find(el => el['gemeente'] !== undefined), tableNameMap, logSqlStatements);
        await deleteAutorisatieRecords(client, tableNameMap, logSqlStatements);
        await deleteProtocolleringRecords(client, tableNameMap, logSqlStatements);
    }
    catch(ex) {
        console.log(ex.stack);
    }
    finally {
        if(client !== undefined) {
            client.release();
        }
    }
}

function logIf(sqlStatement, logSqlStatements) {
    if(logSqlStatements) {
        console.log(sqlStatement);
    }
}

async function executeSql(client, sqlData, tableNameMap, logSqlStatements) {
    let plId = undefined;

    if(sqlData['autorisatie'] !== undefined) {
        for(const rowData of sqlData['autorisatie']) {
            const sqlStatement = insertIntoAutorisatieStatement(rowData);

            logIf(sqlStatement, logSqlStatements);
    
            const res = await client.query(sqlStatement);
    
            rowData.push(['autorisatie_id', res.rows[0]['autorisatie_id']]);
        }
    }
    if(sqlData['gemeente'] !== undefined) {
        for(const key of Object.keys(sqlData['gemeente'])) {
            const sqlStatement = insertIntoStatement('gemeente', sqlData['gemeente'][key].data, tableNameMap);

            logIf(sqlStatement, logSqlStatements);

            await client.query(sqlStatement);
        }
    }
    if(sqlData['adres'] !== undefined) {
        for(const key of Object.keys(sqlData['adres'])) {
            const sqlStatement = insertIntoAdresStatement(sqlData['adres'][key].data);

            logIf(sqlStatement, logSqlStatements);

            const res = await client.query(sqlStatement);

            sqlData['adres'][key].data.push(['adres_id', res.rows[0]['adres_id']]);
        }
    }
    if(sqlData['inschrijving'] !== undefined) {
        for(const rowData of sqlData['inschrijving']) {
            const sqlStatement = insertIntoPersoonlijstStatement(rowData);

            logIf(sqlStatement, logSqlStatements);

            const res = await client.query(sqlStatement);

            plId = res.rows[0]['pl_id'];
            rowData.push(['pl_id', res.rows[0]['pl_id']]);
        }
    }

    for(const key of Object.keys(sqlData)) {
        if (['inschrijving', 'gemeente', 'adres', 'ids', 'autorisatie'].includes(key)) {
            continue;
        }

        for(const rowData of sqlData[key]) {
            const data = createStatementData(key, plId, rowData);

            const name = key.replace(/-\d$/, "");
            const sqlStatement = insertIntoStatement(name, data, tableNameMap);
            logIf(sqlStatement, logSqlStatements);
            await client.query(sqlStatement);
        }
    }

}

function createStatementData(key, plId, rowData) {
    return [
        [ 'pl_id', plId ]
    ].concat(rowData);
}

function insertIntoAutorisatieStatement(data) {
    let statement = {
        text: 'INSERT INTO public.lo3_autorisatie(autorisatie_id',
        values: []
    };

    data.forEach(function(row) {
        statement.text += `,${row[0]}`;
        statement.values.push(row[1]);
    });

    statement.text += ') VALUES((SELECT COALESCE(MAX(autorisatie_id), 0)+1 FROM public.lo3_autorisatie)';
    statement.values.forEach(function(_value, index) {
        statement.text += `,$${index+1}`;
    });
    statement.text += ') RETURNING *';

    return statement;
}

function insertIntoAdresStatement(data) {
    let statement = {
        text: 'INSERT INTO public.lo3_adres(adres_id',
        values: []
    };

    data.forEach(function(row) {
        statement.text += `,${row[0]}`;
        statement.values.push(row[1]);
    });

    statement.text += ') VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres)';
    statement.values.forEach(function(_value, index) {
        statement.text += `,$${index+1}`;
    });
    statement.text += ') RETURNING *';

    return statement;
}

function insertIntoPersoonlijstStatement(data) {
    let statement = {
        text: 'INSERT INTO public.lo3_pl(pl_id,mutatie_dt',
        values: []
    };

    data.forEach(function(row) {
        statement.text += `,${row[0]}`;
        statement.values.push(row[1]);
    });

    statement.text += ') VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp';
    statement.values.forEach(function(_value, index) {
        statement.text += `,$${index+1}`;
    });
    statement.text += ') RETURNING *';

    return statement;
}

function insertIntoStatement(tabelNaam, data, tableNameMap) {
    let tableName = tableNameMap.get(tabelNaam);
    if(tableName === undefined) {
        tableName = tabelNaam;
    }
    let statement = {
        text: `INSERT INTO public.${tableName}(`,
        values: []
    };

    data.forEach(function(row, index) {
        statement.text += index === 0
            ? `${row[0]}`
            : `,${row[0]}`;
        statement.values.push(row[1]);
    });

    statement.text += ') VALUES(';
    statement.values.forEach(function(_value, index) {
        statement.text += index === 0
            ? `$${index+1}`
            : `,$${index+1}`;
    });
    statement.text += ')';

    return statement;
}

function equals(sqlData, adresData) {
    return Object.keys(sqlData).length === adresData.length &&
           Object.keys(sqlData).every((v, i) => v === adresData[i])
}

async function deleteRecords(client, sqlData, tableNameMap, logSqlStatements, deleteIndividualRecords = true) {
    if(sqlData['inschrijving'] === undefined) {
        return;
    }

    const plIdElem = sqlData['inschrijving'][0].find(e => e[0] === 'pl_id');
    if(plIdElem === undefined) {
        return;
    }

    const id = deleteIndividualRecords
        ? Number(plIdElem[1])
        : undefined;

    for(const key of Object.keys(sqlData)) {
        if(tableNameMap.has(key)) {
            const sqlStatement = createDeleteStatement(key, id, tableNameMap);

            logIf(sqlStatement, logSqlStatements);

            await client.query(sqlStatement);
        }
    }
}

function createDeleteStatement(tabelNaam, id, tableNameMap) {
    let naamId;
    
    switch(tabelNaam) {
        case 'adres':
            naamId = 'adres_id';
            break;
        case 'autorisatie':
            naamId = 'autorisatie_id';
            break;
        case 'gemeente':
            naamId = 'gemeente_code';
            break;
        default:
            naamId = 'pl_id';
            break;
    }

    const statement = {
        text: id !== undefined
            ? `DELETE FROM public.${tableNameMap.get(tabelNaam)} WHERE ${naamId}=$1`
            : `DELETE FROM public.${tableNameMap.get(tabelNaam)}`,
        values: id !== undefined
            ? [id]
            : []
    };

    return statement;
}

async function deleteAdresRecord(client, sqlData, tableNameMap, logSqlStatements) {
    if(sqlData['adres'] === undefined) {
        return;
    }

    for(const key of Object.keys(sqlData['adres'])) {
        const adresIdElem = sqlData['adres'][key].data.find(e => e[0] === 'adres_id');
        if(adresIdElem === undefined) {
            continue;
        }

        const id = Number(adresIdElem[1]);

        const sqlStatement = createDeleteStatement('adres', id, tableNameMap);

        logIf(sqlStatement, logSqlStatements);

        await client.query(sqlStatement);
    }
}

async function deleteAutorisatieRecords(client, tableNameMap, logSqlStatements) {
    const statement = {
        text: `DELETE FROM public.${tableNameMap.get('autorisatie')} WHERE afnemer_code=$1`,
        values: [8]
    };

    logIf(statement, logSqlStatements);

    await client.query(statement);
}

async function deleteGemeenteRecords(client, sqlData, tableNameMap, logSqlStatements) {
    if(sqlData?.gemeente === undefined) {
        return;
    }

    for(const key of Object.keys(sqlData['gemeente'])) {
        const gemeenteCodeElem = sqlData['gemeente'][key].data.find(e => e[0] === 'gemeente_code');
        if(gemeenteCodeElem === undefined) {
            continue;
        }

        const id = Number(gemeenteCodeElem[1]);

        const sqlStatement = createDeleteStatement('gemeente', id, tableNameMap);

        logIf(sqlStatement, logSqlStatements);

        await client.query(sqlStatement);
    }
}

async function deleteProtocolleringRecords(client, tableNameMap, logSqlStatements) {
    const statement = {
        text: `DELETE FROM public.${tableNameMap.get('protocollering')}`,
        values: []
    };

    logIf(statement, logSqlStatements);

    await client.query(statement);
}

module.exports = {
    noSqlData,
    executeSqlStatements,
    rollbackSqlStatements,
    insertIntoPersoonlijstStatement,
    insertIntoAdresStatement,
    insertIntoStatement
}
