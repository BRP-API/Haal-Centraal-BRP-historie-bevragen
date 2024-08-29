const reporter = require('cucumber-html-reporter');
const { existsSync} = require('fs');
const apiName = 'Haal Centraal BRP Historie Bevragen API';
const gbaVersion = `GBA ${process.argv[2]}`
const proxyVersion = `Proxy ${process.argv[3]}`

const features = new Map([
    ['autorisatie', 'autorisatie'],
    ['protocollering', 'protocollering'],
    ['raadpleeg-verblijfplaatshistorie-op-peildatum', 'raadpleeg verblijfplaatshistorie op peildatum'],
    ['raadpleeg-verblijfplaatshistorie-met-periode', 'raadpleeg verblijfplaatshistorie met periode']
]);

features.forEach((value, key) => {
    if(existsSync(`docs/features/test-result-${key}-gba.json`)) {
        reporter.generate({
            theme: 'bootstrap',
            jsonFile: `docs/features/test-result-${key}-gba.json`,
            output: `docs/features/test-report-${key}-gba.html`,
            noInlineScreenshots: true,
            reportSuiteAsScenarios: true,
            scenarioTimestamp: true,
            launchReport: false,
            name:`${value} features`,
            brandTitle: `${apiName} - ${gbaVersion}`
        });
    }

    if(existsSync(`docs/features/test-result-${key}.json`)) {
        reporter.generate({
            theme: 'bootstrap',
            jsonFile: `docs/features/test-result-${key}.json`,
            output: `docs/features/test-report-${key}.html`,
            noInlineScreenshots: true,
            reportSuiteAsScenarios: true,
            scenarioTimestamp: true,
            launchReport: false,
            name: `${value} features`,
            brandTitle: `${apiName} - ${proxyVersion}`
        });
    }
});
