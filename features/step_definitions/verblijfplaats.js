const { createCollectieDataFromArray, createArrayFrom } = require('./dataTable2Array.js');
const { columnNameMap } = require('./gba.js');
const deepEqualInAnyOrder = require('deep-equal-in-any-order');
const should = require('chai').use(deepEqualInAnyOrder).should();

function createVerblijfplaatsVoorkomen(sqlData, adresIndex, dataTable, isCorrectie = false) {
    sqlData['verblijfplaats'].forEach(function(data) {
        let volgNr = data.find(el => el[0] === 'volg_nr');
        if(isCorrectie && volgNr[1] === '0') {
            data.push(['onjuist_ind','O']);
            if(adresIndex === undefined) {
                adresIndex = data.find(el => el[0] === 'adres_id')[1];
            }
        }
        volgNr[1] = Number(volgNr[1]) + 1 + '';
    });

    let verblijfplaatsData = [
        [ 'volg_nr', '0']
    ];
    if(adresIndex !== undefined) {
        verblijfplaatsData.splice(0, 0, [ 'adres_id', adresIndex + '' ]);
    }

    sqlData['verblijfplaats'].push(verblijfplaatsData.concat(createArrayFrom(dataTable, columnNameMap)));
}

function createPersoonMetVerblijfplaats(context, burgerservicenummer, adresId, dataTable) {
    if(context.sqlData === undefined) {
        context.sqlData = [];
    }

    const adressenData = context.sqlData.find(e => Object.keys(e).includes('adres'));
    should.exist(adressenData, 'geen adressen gevonden');
    const adresIndex = adressenData.adres[adresId]?.index;
    should.exist(adresIndex, `geen adres gevonden met id '${adresId}'`);

    context.sqlData.push({});

    let sqlData = context.sqlData.at(-1);

    sqlData['persoon'] = [
        createCollectieDataFromArray('persoon', [
            ['burger_service_nr', burgerservicenummer]
        ])
    ];

    sqlData['inschrijving'] = [[[ 'geheim_ind', '0' ]]];

    sqlData['verblijfplaats'] = [];

    createVerblijfplaatsVoorkomen(sqlData, adresIndex, dataTable);
}

function createVerblijfplaats(context, adresId, dataTable) {
    const adressenData = context.sqlData.find(e => Object.keys(e).includes('adres'));
    should.exist(adressenData, 'geen adressen gevonden');
    const adresIndex = adressenData.adres[adresId]?.index;
    should.exist(adresIndex, `geen adres gevonden met id '${adresId}'`);

    let sqlData = context.sqlData.at(-1);

    if(sqlData['verblijfplaats'] === undefined) {
        sqlData['verblijfplaats'] = [];
    }

    createVerblijfplaatsVoorkomen(sqlData, adresIndex, dataTable);
}

function createVerblijfplaatsBuitenland(context, dataTable) {
    let sqlData = context.sqlData.at(-1);

    createVerblijfplaatsVoorkomen(sqlData, undefined, dataTable);
}

function corrigeerVerblijfplaats(context, adresId, dataTable) {
    const adressenData = context.sqlData.find(e => Object.keys(e).includes('adres'));
    should.exist(adressenData, 'geen adressen gevonden');
    const adresIndex = adresId !== undefined
     ? adressenData.adres[adresId]?.index
     : undefined;
    if(adresId !== undefined) {
        should.exist(adresIndex, `geen adres gevonden met id '${adresId}' in ${JSON.stringify(adressenData)}`);
    }

    let sqlData = context.sqlData.at(-1);

    createVerblijfplaatsVoorkomen(sqlData, adresIndex, dataTable, true);
}

module.exports = { createPersoonMetVerblijfplaats, createVerblijfplaats, createVerblijfplaatsBuitenland, corrigeerVerblijfplaats }
