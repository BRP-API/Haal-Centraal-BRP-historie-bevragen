const { createCollectieDataFromArray, createArrayFrom, createVoorkomenDataFromArray } = require('./dataTable2Array.js');
const { columnNameMap } = require('./gba.js');

function createPersoon(context, burgerservicenummer, gegevensgroep, dataTable) {
    if(context.sqlData === undefined) {
        context.sqlData = [{}];
    }
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

    switch(gegevensgroep) {
        case 'inschrijving':
            createInschrijving(context, dataTable);
            break;
        case 'kiesrecht':
            createInschrijving(context, dataTable, true);
            break;
        default:
            createInschrijving(context, undefined, true);
            sqlData[gegevensgroep] = [ createVoorkomenDataFromArray(dataTable, columnNameMap) ];
            break;
    }
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

module.exports = { createPersoon, createInschrijving }
