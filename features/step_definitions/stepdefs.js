const { World } = require('./world');
const { Given, When, Then, setWorldConstructor, Before, After, setDefaultTimeout } = require('@cucumber/cucumber');
const { createObjectFrom, createObjectArrayFrom } = require('./dataTable2Object.js');
const { createCollectieDataFromArray, createArrayFrom, createVoorkomenDataFromArray, fromHash } = require('./dataTable2Array.js');
const { tableNameMap, columnNameMap, createAutorisatieSettingsFor, createRequestBody, createBasicAuthorizationHeader, createAdresseringBinnenlandAutorisatieSettingsFor, createVerblijfplaatsBinnenlandAutorisatieSettingsFor } = require('./gba.js');
const { postBevragenRequestWithBasicAuth, handleOAuthRequest, handleOAuthCustomRequest, handleCustomBevragenRequest } = require('./handleRequest.js');
const deepEqualInAnyOrder = require('deep-equal-in-any-order');
const should = require('chai').use(deepEqualInAnyOrder).should();
const { Pool } = require('pg');
const { noSqlData, executeSqlStatements, rollbackSqlStatements, insertIntoPersoonlijstStatement, insertIntoAdresStatement, insertIntoStatement } = require('./postgresqlHelpers.js');
const { stringifyValues } = require('./stringify.js');

setWorldConstructor(World);

// voor het aanpassen van de default timeout waarde (5s) van cucumber-js
// de default timeout waarde van axios is 0 (geen timeout)
// https://github.com/cucumber/cucumber-js/blob/main/docs/support_files/timeouts.md
setDefaultTimeout(15000);

let pool;
let logSqlStatements = false;
let accessToken;

Given(/^adres '(.*)' heeft de volgende gegevens$/, function (adresId, dataTable) {
    if(this.context.sqlData === undefined) {
        this.context.sqlData = [{'adres':{}}];
    }

    let sqlData = this.context.sqlData.find(e => Object.keys(e).includes('adres'));
    if(sqlData === undefined) {
        sqlData = { adres: {} };
        this.context.sqlData.push(sqlData);
    }

    sqlData['adres'][adresId] = {
        index: Object.keys(sqlData['adres']).length,
        data: createArrayFrom(dataTable, columnNameMap)
    };
});

Given(/^de persoon met burgerservicenummer '(\d*)' is ingeschreven op adres '(.*)' met de volgende gegevens$/, function (burgerservicenummer, adresId, dataTable) {
    if(this.context.sqlData === undefined) {
        this.context.sqlData = [];
    }

    const adressenData = this.context.sqlData.find(e => Object.keys(e).includes('adres'));
    should.exist(adressenData, 'geen adressen gevonden');
    const adresIndex = adressenData.adres[adresId]?.index;
    should.exist(adresIndex, `geen adres gevonden met id '${adresId}'`);

    this.context.sqlData.push({});

    let sqlData = this.context.sqlData.at(-1);

    sqlData['persoon'] = [
        createCollectieDataFromArray('persoon', [
            ['burger_service_nr', burgerservicenummer]
        ])
    ];

    sqlData['inschrijving'] = [[[ 'geheim_ind', '0' ]]];

    sqlData['verblijfplaats'] = [
        [
            [ 'adres_id', adresIndex + '' ],
            [ 'volg_nr', '0']
        ].concat(createArrayFrom(dataTable, columnNameMap))
    ];
});

Given(/^de persoon is vervolgens ingeschreven op adres '(.*)' met de volgende gegevens$/, function (adresId, dataTable) {
    const adressenData = this.context.sqlData.find(e => Object.keys(e).includes('adres'));
    should.exist(adressenData, 'geen adressen gevonden');
    const adresIndex = adressenData.adres[adresId]?.index;
    should.exist(adresIndex, `geen adres gevonden met id '${adresId}'`);

    let sqlData = this.context.sqlData.at(-1);

    sqlData['verblijfplaats'].forEach(function(data) {
        let volgNr = data.find(el => el[0] === 'volg_nr');
        volgNr[1] = Number(volgNr[1]) + 1 + '';
    });

    sqlData['verblijfplaats'].push([
        [ 'adres_id', adresIndex + '' ],
        [ 'volg_nr', '0']
    ].concat(createArrayFrom(dataTable, columnNameMap)));
});

Given(/^de persoon is vervolgens ingeschreven op een buitenlands adres met de volgende gegevens$/, function (dataTable) {
    let sqlData = this.context.sqlData.at(-1);

    sqlData['verblijfplaats'].forEach(function(data) {
        let volgNr = data.find(el => el[0] === 'volg_nr');
        volgNr[1] = Number(volgNr[1]) + 1 + '';
    });

    sqlData['verblijfplaats'].push([
        [ 'volg_nr', '0']
    ].concat(createArrayFrom(dataTable, columnNameMap)));
});

async function handleRequest(context, dataTable) {
    if(context.sqlData === undefined) {
        context.sqlData = [{}];
    }

    const afnemerId = context.afnemerId ?? context.oAuth?.clients[0].afnemerID;
    const gemeenteCode = context.gemeenteCode ?? "800";
    const url = context.proxyAanroep ? context.proxyUrl : context.apiUrl;

    const heeftAutorisatieSettings = context.sqlData.filter(s => s['autorisatie'] !== undefined).length > 0;
    if (!heeftAutorisatieSettings &&
        (context.createDefaultAutorisation === undefined || context.createDefaultAutorisation)
       ) {
        let sqlData = context.sqlData.at(-1);
        sqlData['autorisatie'] = createAutorisatieSettingsFor(afnemerId);
    }

    await executeSqlStatements(context.sqlData, pool, tableNameMap, logSqlStatements);

    if(context.oAuth.enable){
        const result = await handleOAuthRequest(accessToken, context.oAuth, afnemerId, url, dataTable);
        context.response = result.response;
        accessToken = result.accessToken;
    }
    else {
        context.response = await postBevragenRequestWithBasicAuth(url, createBasicAuthorizationHeader(afnemerId, gemeenteCode), dataTable);
    }
}

When(/^gba ([a-z]*) wordt gezocht met de volgende parameters$/, function (endpoint, dataTable) {
    this.context.proxyAanroep = false;

    // await handleRequest(this.context, dataTable);
});

Then(/^heeft de response verblijfplaatsen met de volgende gegevens$/, function (dataTable) {
    this.context.verifyResponse = true;

    if(this.context.expected === undefined) {
        this.context.expected = {};
    }

    this.context.expected.verblijfplaatsen = createObjectArrayFrom(dataTable, true);
});

After({tags: 'not @fout-case'}, async function() {
    if (this.context.verifyResponse === undefined ||
        !this.context.verifyResponse) {
        return;
    }

    this.context.response?.status?.should.equal(200, `response body: ${JSON.stringify(this.context.response.data, null, '\t')}`);

    const actual = this.context?.response?.data !== undefined
        ? stringifyValues(this.context.response.data)
        : {};
    const expected = this.context.expected !== undefined
        ? this.context.expected
        : {};

    actual.should.deep.equalInAnyOrder(expected, `actual: ${JSON.stringify(actual, null, '\t')}\nexpected: ${JSON.stringify(expected, null, '\t')}`);
});
