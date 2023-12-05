const { World } = require('./world');
const { Given, When, Then, setWorldConstructor, Before, After, setDefaultTimeout } = require('@cucumber/cucumber');
const { createVoorkomenDataFromArray } = require('./dataTable2Array.js')
const { createObjectFrom, createObjectArrayFrom, setObjectPropertiesFrom } = require('./dataTable2Object.js');
const { tableNameMap, columnNameMap, createAutorisatieSettingsFor, createRequestBody, createBasicAuthorizationHeader, createAdresseringBinnenlandAutorisatieSettingsFor, createVerblijfplaatsBinnenlandAutorisatieSettingsFor } = require('./gba.js');
const { postBevragenRequestWithBasicAuth, handleOAuthRequest, handleOAuthCustomRequest, handleCustomBevragenRequest } = require('./handleRequest.js');
const deepEqualInAnyOrder = require('deep-equal-in-any-order');
const should = require('chai').use(deepEqualInAnyOrder).should();
const { Pool } = require('pg');
const { noSqlData, executeSqlStatements, rollbackSqlStatements, insertIntoPersoonlijstStatement, insertIntoAdresStatement, insertIntoStatement } = require('./postgresqlHelpers.js');
const { stringifyValues } = require('./stringify.js');
const { createAdres, infrastructureelWijzigenAdres, actualiseerAdres, adressenSamenvoegen, splitsAdres } = require('./adres.js');
const { createPersoonMetVerblijfplaats, createVerblijfplaats, createVerblijfplaatsBuitenland, corrigeerVerblijfplaats } = require('./verblijfplaats.js');
const { createPersoon, createInschrijving, createOuder, createKindOfPartner } = require('./persoon.js');
const { createGemeente, samenvoegenGemeente } = require('./gemeente.js');

setWorldConstructor(World);

// voor het aanpassen van de default timeout waarde (5s) van cucumber-js
// de default timeout waarde van axios is 0 (geen timeout)
// https://github.com/cucumber/cucumber-js/blob/main/docs/support_files/timeouts.md
setDefaultTimeout(15000);

let pool;
let logSqlStatements = false;
let accessToken;

Given(/^adres '(.*)' heeft de volgende gegevens$/, function (adresId, dataTable) {
    createAdres(this.context, adresId, dataTable);
});

Given(/^adres '(.*)' is op '(.*)' infrastructureel gewijzigd naar adres '(.*)' met de volgende gegevens$/, function(sourceAdresId, ingangsdatum, targetAdresId, dataTable) {
    infrastructureelWijzigenAdres(this.context, sourceAdresId, ingangsdatum, targetAdresId, dataTable);
});

Given(/^adres '(.*)' is op '(.*)' infrastructureel gewijzigd met de volgende gegevens$/, function (adresId, ingangsdatum, dataTable) {
    let sqlData = this.context.sqlData.find(el => el['adres'] !== undefined);

    const nieuwAdresIndex = Object.keys(sqlData['adres']).length;
    infrastructureelWijzigenAdres(this.context, adresId, ingangsdatum, nieuwAdresIndex + 1 + '', dataTable);
});

Given(/^adres '(.*)' is op '(.*)' geactualiseerd met de volgende gegevens$/, function (adresId, ingangsdatum, dataTable) {
    actualiseerAdres(this.context, adresId, ingangsdatum, dataTable);
});

Given(/^(?:adres|de adressen) '(.*)' (?:is|zijn) op '(.*)' samengevoegd tot adres '(.*)' met de volgende gegevens$/, function (sourceAdresIds, ingangsdatum, targetAdresId, dataTable) {
    adressenSamenvoegen(this.context, sourceAdresIds, ingangsdatum, targetAdresId, dataTable);
});

Given(/^adres '(.*)' is gesplitst in adressen met de volgende gegevens$/, function (_, dataTable) {
    splitsAdres(this.context, dataTable);
});

Given(/^gemeente '(.*)' heeft de volgende gegevens$/, function (gemeenteId, dataTable) {
    createGemeente(this.context, gemeenteId, dataTable);
});

Given(/^gemeente '(.*)' is samengevoegd met de volgende gegevens$/, function (gemeenteId, dataTable) {
    samenvoegenGemeente(this.context, gemeenteId, dataTable);
});

Given(/^de inschrijving is vervolgens gecorrigeerd als een inschrijving op adres '(.*)' met de volgende gegevens$/, function (adresId, dataTable) {
    corrigeerVerblijfplaats(this.context, adresId, dataTable);
});

Given(/^de persoon met burgerservicenummer '(\d*)' is ingeschreven op adres '(.*)' met de volgende gegevens$/, function (burgerservicenummer, adresId, dataTable) {
    createPersoonMetVerblijfplaats(this.context, burgerservicenummer, adresId, dataTable);
});

Given(/^de persoon is ?(?:vervolgens )?ingeschreven op adres '(.*)' met de volgende gegevens$/, function (adresId, dataTable) {
    createVerblijfplaats(this.context, adresId, dataTable);
});

Given(/^de persoon is vervolgens ingeschreven op een buitenlands adres met de volgende gegevens$/, function (dataTable) {
    createVerblijfplaatsBuitenland(this.context, dataTable);
});

Given(/^er zijn (\d*) personen ingeschreven op adres '(.*)' met de volgende gegevens$/, function (aantal, adresId, dataTable) {
    const adressenData = this.context.sqlData.find(e => Object.keys(e).includes('adres'));
    should.exist(adressenData, 'geen adressen gevonden');
    const adresIndex = adressenData.adres[adresId]?.index;
    should.exist(adresIndex, `geen adres gevonden met id '${adresId}'`);

    let i = 0;
    while(i < Number(aantal)) {
        i++;

        const burgerservicenummer = (i + '').padStart(9, '0');

        createPersoonMetVerblijfplaats(this.context, burgerservicenummer, adresId, dataTable);
    }
});

Given(/^de persoon met burgerservicenummer '(\d*)' heeft de volgende gegevens$/, function (burgerservicenummer, dataTable) {
    createPersoon(this.context, burgerservicenummer, undefined, dataTable);
});

Given(/^de persoon met burgerservicenummer '(\d*)' heeft de volgende '(\w*)' gegevens$/, function (burgerservicenummer, gegevensgroep, dataTable) {
    createPersoon(this.context, burgerservicenummer, gegevensgroep, dataTable);
});

Given(/^de persoon heeft de volgende '(.*)' gegevens$/, function (gegevensgroep, dataTable) {
    if(gegevensgroep === 'inschrijving') {
        createInschrijving(this.context, dataTable)
    }
    else {
        let sqlData = this.context.sqlData.at(-1);
        sqlData[gegevensgroep] = [
            createVoorkomenDataFromArray(dataTable, columnNameMap) 
        ];
    }
});

Given(/^(?:de|het) '(.*)' is gecorrigeerd naar de volgende gegevens$/, function (relatie, dataTable) {
    if(relatie === 'verblijfplaats') {
        corrigeerVerblijfplaats(this.context, undefined, dataTable);
    }
});

Given(/^de persoon met burgerservicenummer '(\d*)' heeft een '(\w*)' met de volgende gegevens$/, function (burgerservicenummer, collectieGegevensgroep, dataTable) {
    createPersoon(this.context, burgerservicenummer, collectieGegevensgroep, dataTable);
});

Given(/^de persoon heeft ?(?:nog)? een '?(?:ex-)?(\w*)' met ?(?:alleen)? de volgende gegevens$/, async function (relatie, dataTable) {
    createKindOfPartner(this.context, relatie, dataTable);
});

// Ouder stap definities

Given(/^de persoon met burgerservicenummer '(\d*)' heeft een ouder '(\d)' met de volgende gegevens$/, function (burgerservicenummer, ouderType, dataTable) {
    createPersoon(this.context, burgerservicenummer, `ouder-${ouderType}`, dataTable);
});

Given(/^de persoon heeft een ouder '(\d)' met de volgende gegevens$/, function (ouderType, dataTable) {
    createOuder(this.context, ouderType, dataTable);
});

function createAutorisatieSettings(context, afnemerId) {
    const heeftAutorisatieSettings = context.sqlData.filter(s => s['autorisatie'] !== undefined).length > 0;
    if (!heeftAutorisatieSettings &&
        (context.createDefaultAutorisation === undefined || context.createDefaultAutorisation)
       ) {
        let sqlData = context.sqlData.at(-1);
        sqlData['autorisatie'] = createAutorisatieSettingsFor(afnemerId);
    }
}

async function handleRequest(context, endpoint, dataTable) {
    if(context.sqlData === undefined) {
        context.sqlData = [{}];
    }

    const afnemerId = context.afnemerId ?? context.oAuth?.clients[0].afnemerID;
    const gemeenteCode = context.gemeenteCode ?? "800";
    const url = context.proxyAanroep ? context.proxyUrl : context.apiUrl;

    createAutorisatieSettings(context, afnemerId);

    await executeSqlStatements(context.sqlData, pool, tableNameMap, logSqlStatements);

    if(context.oAuth.enable){
        const result = await handleOAuthRequest(accessToken, context.oAuth, afnemerId, url, dataTable);
        context.response = result.response;
        accessToken = result.accessToken;
    }
    else {
        context.response = await postBevragenRequestWithBasicAuth(url, endpoint, createBasicAuthorizationHeader(afnemerId, gemeenteCode), dataTable);
    }
}

When(/^gba ([a-z]*) wordt gezocht met de volgende parameters$/, async function (endpoint, dataTable) {
    this.context.proxyAanroep = false;

    await handleRequest(this.context, endpoint, dataTable);
});

When(/^([a-z]*) wordt gezocht met de volgende parameters$/, async function (endpoint, dataTable) {
    this.context.proxyAanroep = true;

    await handleRequest(this.context, endpoint, dataTable);
});

async function handleCustomRequest(context, endpoint, verb) {
    if(context.sqlData === undefined) {
        context.sqlData = [{}];
    }

    const afnemerId = context.afnemerId ?? context.oAuth.clients[0].afnemerID;
    const gemeenteCode = context.gemeenteCode ?? "800";
    const url = context.proxyAanroep ? context.proxyUrl : context.apiUrl;

    createAutorisatieSettings(context, afnemerId);

    await executeSqlStatements(context.sqlData, pool, tableNameMap, logSqlStatements);

    if(context.oAuth.enable){
        const result = await handleOAuthCustomRequest(accessToken, context.oAuth, afnemerId, url, verb, '{}');
        context.response = result.response;
        accessToken = result.accessToken;
    }
    else {
        context.response = await handleCustomBevragenRequest(url, endpoint, verb, undefined, createBasicAuthorizationHeader(afnemerId, gemeenteCode), '{}');
    }
}

When(/^(.*) wordt gezocht met een '(.*)' aanroep$/, async function(endpoint, verb){
    this.context.proxyAanroep = true;

    await handleCustomRequest(this.context, endpoint, verb);
});

Then(/^heeft de response de volgende gegevens$/, function (dataTable) {
    this.context.verifyResponse = true;

    if(this.context.expected === undefined) {
        this.context.expected = {};
    }

    let expected = this.context.expected;
    setObjectPropertiesFrom(expected, dataTable);
});

Then(/^heeft de response de volgende '(.*)' gegevens$/, function (gegevensgroep, dataTable) {      
    this.context.verifyResponse = true;

    if(this.context.expected === undefined) {
        this.context.expected = {};
    }

    this.context.expected[gegevensgroep] = createObjectFrom(dataTable, this.context.proxyAanroep);
});

Then(/^heeft de response verblijfplaatsen met de volgende gegevens$/, function (dataTable) {
    this.context.verifyResponse = true;

    if(this.context.expected === undefined) {
        this.context.expected = {};
    }

    this.context.expected.verblijfplaatsen = createObjectArrayFrom(dataTable, true);
});

Then(/^heeft de response een verblijfplaats voorkomen met de volgende gegevens$/, function (dataTable) {
    this.context.verifyResponse = true;

    const expected = createObjectFrom(dataTable, this.context.proxyAanroep);

    if(this.context.expected === undefined) {
        this.context.expected = {
            'verblijfplaatsen': []
        };
    }

    this.context.expected.verblijfplaatsen.push(expected);
});

Then(/^heeft het verblijfplaats voorkomen de volgende '(.*)' gegevens$/, function (gegevensgroep, dataTable) {
    this.context.verifyResponse = true;

    let expected = this.context.expected.verblijfplaatsen.at(-1);

    expected[gegevensgroep] = createObjectFrom(dataTable, this.context.proxyAanroep);
});

Then(/^heeft de response een object met de volgende gegevens$/, function (dataTable) {
    this.context.verifyResponse = true;

    this.context.expected = createObjectFrom(dataTable, this.context.proxyAanroep);
});

Then(/^heeft het object de volgende '(.*)' gegevens$/, function (gegevensgroep, dataTable) {
    this.context.expected[gegevensgroep] = dataTable.hashes();
});

Then(/^heeft de response (\d*) (.*)$/, function (aantal, type) {
    this.context.response.status.should.equal(200, `response body: ${JSON.stringify(this.context.response.data, null, '\t')}`);

    const actual = this.context?.response?.data[type];

    should.exist(actual, `geen ${type} property gevonden`);
    actual.length.should.equal(Number(aantal), `aantal ${type} in response is ongelijk aan ${aantal}\nresponse body:${JSON.stringify(this.context.response.data, null, '\t')}`);
});

Then(/^heeft de response geen (\w*)$/, function (type) {
    if(this.context.verifyResponse === undefined || !this.context.verifyResponse) {
        this.context.response.status.should.equal(200, `response body: ${JSON.stringify(this.context.response.data, null, '\t')}`);

        const actual = this.context?.response?.data[type];
    
        should.exist(actual, `geen ${type} property gevonden`);
        actual.length.should.equal(0, `aantal ${type} in response is ongelijk aan 0\nresponse body:${JSON.stringify(this.context.response.data, null, '\t')}`);
    }
    else {

        this.context.expected[type] = [];
    }
});

Then(/^heeft de response geen 'verblijfplaatsen' gegevens$/, function() {
    this.context.verifyResponse = true;

    if(this.context.expected === undefined) {
        this.context.expected = {};
    }

    this.context.expected.verblijfplaatsen = [];
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

After({tags: '@fout-case'}, async function() {
    this.context.response.status.should.not.equal(200, `request body: ${this.context.response.config.data}\nresponse body: ${JSON.stringify(this.context.response.data, null, '\t')}`);

    const headers = this.context?.response?.headers;
    should.exist(headers, 'no response headers found');

    const header = headers["content-type"];
    should.exist(header, `no header found with name 'content-type'. Response headers: ${headers}`);
    header.should.contain('application/problem+json', "no 'content-type' header found with value: 'application/problem+json'");

    const actual = this.context?.response?.data !== undefined
        ? stringifyValues(this.context.response.data)
        : {};
    const expected = this.context.expected;

    actual.should.deep.equalInAnyOrder(expected, `request body: ${this.context.response.config.data}\nactual: ${JSON.stringify(actual, null, '\t')}\nexpected: ${JSON.stringify(expected, null, '\t')}`);
});

Before({tags: '@autorisatie'}, async function() {
    this.context.createDefaultAutorisation = false;
});

Before(function() {
    if(this.context.sql.useDb && pool === undefined && this.context.stapDocumentatie) {
        pool = new Pool(this.context.sql.poolConfig);
        logSqlStatements = this.context.sql.logStatements;
    }
});

After(async function() {
    if (pool === undefined ||
        !this.context.sql.cleanup ||
        noSqlData(this.context.sqlData)) {
        return;
    }

    let deleteIndividualRecords = this.context.sql.deleteIndividualRecords;
    if(deleteIndividualRecords === undefined) {
        deleteIndividualRecords = true;
    }

    await rollbackSqlStatements(this.context.sqlData, pool, tableNameMap, logSqlStatements, deleteIndividualRecords);
});
