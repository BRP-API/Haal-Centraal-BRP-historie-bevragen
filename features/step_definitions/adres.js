const { createArrayFrom } = require('./dataTable2Array.js');
const { columnNameMap } = require('./gba.js');
const deepEqualInAnyOrder = require('deep-equal-in-any-order');
const should = require('chai').use(deepEqualInAnyOrder).should();

function createAdres(context, adresId, dataTable) {
    if(context.sqlData === undefined) {
        context.sqlData = [{ adres: {} }];
    }

    let sqlData = context.sqlData.find(e => Object.keys(e).includes('adres'));
    if(sqlData === undefined) {
        sqlData = { adres: {} };
        context.sqlData.push(sqlData);
    }

    sqlData['adres'][adresId] = {
        index: Object.keys(sqlData['adres']).length,
        data: createArrayFrom(dataTable, columnNameMap)
    };
}

function infrastructureelWijzigenAdres(context, sourceAdresId, ingangsdatum, targetAdresId, dataTable) {
    let sqlData = context.sqlData.find(el => el['adres'] !== undefined);

    const oudAdres = sqlData.adres[sourceAdresId];
    should.exist(oudAdres, `geen adres gevonden met id '${sourceAdresId}'`);
    const adresIndex = oudAdres.index;

    const nieuwAdresIndex = Object.keys(sqlData['adres']).length;
    const nieuwAdresData = JSON.parse(JSON.stringify(oudAdres.data));
    createArrayFrom(dataTable, columnNameMap).forEach(function(elem) {
        let foundElem = nieuwAdresData.find(el => el[0] === elem[0]);
        if(foundElem !== undefined) {
            foundElem[1] = elem[1];
        }
        else {
            nieuwAdresData.push(elem);
        }
    });
    sqlData['adres'][targetAdresId] = {
        index: nieuwAdresIndex,
        data: nieuwAdresData
    };

    context.sqlData.forEach(function(elem) {
        let verblijfplaats = elem['verblijfplaats']?.at(-1);
        if(verblijfplaats?.find(el => el[0] === 'adres_id' && el[1] === adresIndex + '') !== undefined) {
            elem['verblijfplaats'].forEach(function(data) {
                let volgNr = data.find(el => el[0] === 'volg_nr');
                volgNr[1] = Number(volgNr[1]) + 1 + '';
            });

            let nieuwVerblijfplaatsData = JSON.parse(JSON.stringify(elem['verblijfplaats'].at(-1)));
            nieuwVerblijfplaatsData.find(el => el[0] === 'adres_id')[1] = nieuwAdresIndex + '';
            nieuwVerblijfplaatsData.find(el => el[0] === 'volg_nr')[1] = '0';
            nieuwVerblijfplaatsData.find(el => el[0] === 'adreshouding_start_datum')[1] = ingangsdatum.replaceAll('-', '');

            const nieuwGemeenteCode = nieuwAdresData.find(el => el[0] == 'gemeente_code');
            if(nieuwGemeenteCode !== undefined) {
                nieuwVerblijfplaatsData.find(el => el[0] === 'inschrijving_gemeente_code')[1] = nieuwGemeenteCode[1];
            }

            nieuwVerblijfplaatsData.push(['aangifte_adreshouding_oms', 'W'])

            elem.verblijfplaats.push(nieuwVerblijfplaatsData);
        }
    });
}

module.exports = { createAdres, infrastructureelWijzigenAdres }