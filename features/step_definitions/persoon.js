const { createCollectieDataFromArray, createArrayFrom, createVoorkomenDataFromArray } = require('./dataTable2Array.js');
const { columnNameMap } = require('./gba.js');

function getNextStapelNr(sqlData, relatie) {
    let stapelNr = 0;

    Object.keys(sqlData).forEach(function(key) {
        if(key.startsWith(relatie)){
            stapelNr = Number(key.replace(`${relatie}-`, ''));
        }
    });

    return stapelNr+1;
}

function createPersoonExtraGegevens(context, sqlData, gegevensgroep, dataTable) {
    switch(gegevensgroep) {
        case 'inschrijving':
            createInschrijving(context, dataTable);
            break;
        case 'kiesrecht':
            createInschrijving(context, dataTable, true);
            break;
        case 'kind':
        case 'partner':
            createInschrijving(context, undefined, true);
            sqlData[`${gegevensgroep}-${getNextStapelNr(sqlData, gegevensgroep)}`] = [
                createCollectieDataFromArray(gegevensgroep, createArrayFrom(dataTable, columnNameMap))
            ];
            break;
        case 'ouder-1':
            createInschrijving(context, undefined, true);
            sqlData[gegevensgroep] = [
                createCollectieDataFromArray('1', createArrayFrom(dataTable, columnNameMap))
            ];
            break;
        case 'ouder-2':
            createInschrijving(context, undefined, true);
            sqlData[gegevensgroep] = [
                createCollectieDataFromArray('2', createArrayFrom(dataTable, columnNameMap))
            ];
            break;
        default:
            createInschrijving(context, undefined, true);
            sqlData[gegevensgroep] = [ createVoorkomenDataFromArray(dataTable, columnNameMap) ];
            break;
    }
}

function createPersoon(context, burgerservicenummer, gegevensgroep, dataTable) {
    if(context.sqlData === undefined) {
        context.sqlData = [];
    }
    context.sqlData.push({});

    let sqlData = context.sqlData.at(-1);

    if(gegevensgroep === undefined) {
        sqlData["persoon"] = [
            createCollectieDataFromArray("persoon", [
                ['burger_service_nr', burgerservicenummer]
            ]).concat(createArrayFrom(dataTable, columnNameMap))
        ];
    }
    else {
        sqlData["persoon"] = [
            createCollectieDataFromArray("persoon", [
                ['burger_service_nr', burgerservicenummer]
            ])
        ];
    }

    createPersoonExtraGegevens(context, sqlData, gegevensgroep, dataTable);
}

function createKindOfPartner(context, relatie, dataTable) {
    let sqlData = context.sqlData.at(-1);

    const stapelNr = getNextStapelNr(sqlData, relatie);
    sqlData[`${relatie}-${stapelNr}`] = [
        createCollectieDataFromArray(relatie, createArrayFrom(dataTable, columnNameMap), stapelNr-1)
    ];
}

function createOuder(context, ouderType, dataTable) {
    let sqlData = context.sqlData.at(-1);

    sqlData[`ouder-${ouderType}`] = [
        createCollectieDataFromArray(ouderType, createArrayFrom(dataTable, columnNameMap))
    ];
}

function createInschrijving(context, dataTable, defaultGeheim = false) {
    let sqlData = context.sqlData.at(-1);

    let data = [];

    if(defaultGeheim) {
        data.push([ 'geheim_ind', '0' ]);
    }
    if(dataTable !== undefined) {
        data = data.concat(createArrayFrom(dataTable, columnNameMap));
    }

    sqlData['inschrijving'] = [data];
}

module.exports = { createPersoon, createInschrijving, createOuder, createKindOfPartner }
