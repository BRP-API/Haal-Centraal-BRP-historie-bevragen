const { toDateOrString } = require('./calcDate');

const tableNameMap = new Map([

    ['adres', 'lo3_adres'],
    ['autorisatie', 'lo3_autorisatie'],
    ['gemeente', 'lo3_gemeente'],
    ['gezagsverhouding', 'lo3_pl_gezagsverhouding'],
    ['inschrijving', 'lo3_pl'],
    ['kind', 'lo3_pl_persoon'],
    ['ouder', 'lo3_pl_persoon'],
    ['partner', 'lo3_pl_persoon'],
    ['persoon', 'lo3_pl_persoon' ],
    ['protocollering', 'haalcentraal_vraag'],
    ['verblijfplaats', 'lo3_pl_verblijfplaats'],

]);

const columnNameMap = new Map([

    ['burgerservicenummer (01.20)', 'burger_service_nr' ],

    ['geslachtsnaam (02.40)', 'geslachts_naam' ],

    ['gemeente van inschrijving (09.10)', 'inschrijving_gemeente_code'],

    ['datum aanvang adreshouding (10.30)', 'adreshouding_start_datum'],

    ['straatnaam (11.10)', 'straat_naam'],
    ['identificatiecode verblijfplaats (11.80)', 'verblijf_plaats_ident_code'],
    ['identificatiecode nummeraanduiding (11.90)', 'nummer_aand_ident_code'],

    ['locatiebeschrijving (12.10)', 'locatie_beschrijving'],

    ['land (13.10)', 'vertrek_land_code'],
    ['datum aanvang adres buitenland (13.20)', 'vertrek_datum'],
    ['regel 1 adres buitenland (13.30)', 'vertrek_land_adres_1'],
    ['regel 2 adres buitenland (13.40)', 'vertrek_land_adres_2'],
    ['regel 3 adres buitenland (13.50)', 'vertrek_land_adres_3'],

    ['indicatie gezag minderjarige (32.10)', 'minderjarig_gezag_ind'],

    ['aanduiding uitgesloten kiesrecht (38.10)', 'kiesrecht_uitgesl_aand'],

    ['aanduiding naamgebruik (61.10)', 'naam_gebruik_aand'],

    ['datum opschorting bijhouding (67.10)', 'bijhouding_opschort_datum' ],
    ['reden opschorting bijhouding (67.20)', 'bijhouding_opschort_reden'],

    ['indicatie geheim (70.10)', 'geheim_ind'],

    ['aangifte adreshouding (72.10)', 'aangifte_adreshouding_oms' ],

    ['aanduiding in onderzoek (83.10)', 'onderzoek_gegevens_aand' ],
    ['datum ingang onderzoek (83.20)', 'onderzoek_start_datum' ],
    ['datum einde onderzoek (83.30)', 'onderzoek_eind_datum' ],

    ['gemeentecode (92.10)', 'gemeente_code'],
    ['gemeentenaam (92.11)', 'gemeente_naam'],
    ['nieuwe gemeentecode (92.12)', 'nieuwe_gemeente_code'],
    ['datum beëindiging (99.99)', 'tabel_regel_eind_datum'],

    ['Rubrieknummer ad hoc (35.95.60)', 'ad_hoc_rubrieken'],
    ['Medium ad hoc (35.95.67)', 'ad_hoc_medium'],
    ['Datum ingang (35.99.98)', 'tabel_regel_start_datum'],

]);

function createAutorisatieSettingsFor(afnemerId) {
    return [
        [
            ['afnemer_code', afnemerId ],
            ['geheimhouding_ind', 0],
            ['verstrekkings_beperking', 0],
            ['afnemer_naam', 'Haal Centraal'],
            ['adres_vraag_bevoegdheid', 1],
            ['ad_hoc_medium', 'N'],
            ['tabel_regel_start_datum', 20220101],
            ['ad_hoc_rubrieken', '10110 10120 10210 10220 10230 10240 10310 10320 10330 10410 123510 123520 123530 123550 123560 123570 16110 18110 18120 18210 18220 18230 18510 18610 20110 20120 20210 20220 20230 20240 20310 20320 20330 20410 26210 28110 28120 28210 28220 28230 28510 28610 30110 30120 30210 30220 30230 30240 30310 30320 30330 30410 36210 38110 38120 38210 38220 38230 38510 38610 40510 46310 46410 46510 48210 48220 48230 48510 48610 50110 50120 50210 50220 50230 50240 50310 50320 50330 50410 50610 50620 50630 50710 50720 50730 50740 51510 58110 58120 58210 58220 58230 58510 58610 60810 60820 60830 68110 68120 68210 68220 68230 68510 68610 76710 76720 76810 76910 77010 78710 80910 80920 81010 81020 81030 81110 81115 81120 81130 81140 81150 81160 81170 81180 81190 81210 81310 81320 81330 81340 81350 81410 81420 87210 87510 88510 88610 90110 90120 90210 90220 90230 90240 90310 90320 90330 98110 98120 98210 98220 98230 98510 98610 98910 103910 103920 103930 108510 108610 113210 113310 118210 118220 118230 118510 118610 123510 123520 123530 123540 123550 123560 123570 123610 128210 128220 128230 128510 128610 133110 133120 133130 133810 133820 138210 138220 138230 540510 546310 546410 546510 548210 548220 548230 548510 548610 550110 550120 550210 550220 550230 550240 550310 550320 550330 550410 550610 550620 550630 550710 550720 550730 550740 551510 558110 558120 558210 558220 558230 558510 558610 580910 580920 581010 581020 581030 581110 581115 581120 581130 581140 581150 581160 581170 581180 581190 581210 581310 581320 581330 581340 581350 581410 581420 587210 587510 588510 588610 603910 603920 603930 608510 608610']
        ]
    ];
}

function createRequestBody(dataTable) {
    let requestBody = {};
    const type = dataTable.hashes().find(param => param.naam === 'type')?.waarde;

    dataTable.hashes()
            .filter(function(param) {
                return !param.naam.startsWith("header:");
            })
            .forEach(function(param) {
                if ((type === 'RaadpleegMetBurgerservicenummer' && param.naam === 'burgerservicenummer') ||
                    param.naam === 'fields') {
                        requestBody[param.naam] = param.waarde === '' 
                            ? []
                            : param.waarde.split(',');
                }
                else if(param.naam === 'burgerservicenummer (als string)') {
                    requestBody['burgerservicenummer'] = param.waarde;
                }
                else if(param.naam === 'fields (als string)') {
                    requestBody['fields'] = param.waarde;
                }
                else if(param.waarde === '(131 maal aNummer)') {
                    requestBody[param.naam] = [];
                    for(let count=0; count<=131; count++) {
                        requestBody[param.naam].push('aNummer');
                    }
                }
                else {
                    requestBody[param.naam] = toDateOrString(param.waarde, true);
                }
            });

    return requestBody;
}

function createBasicAuthorizationHeader(afnemerId, gemeenteCode) {
    return [
        { "naam": "Authorization", "waarde": "Basic " + Buffer.from(`${afnemerId}|${gemeenteCode}:tempsolution!`).toString('base64') }
    ]
}

module.exports = {
    tableNameMap,
    columnNameMap,
    createAutorisatieSettingsFor,
    createRequestBody,
    createBasicAuthorizationHeader,
    // createAdresseringBinnenlandAutorisatieSettingsFor,
    // createVerblijfplaatsBinnenlandAutorisatieSettingsFor
}
