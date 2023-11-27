const { readdirSync, readFileSync, createWriteStream } = require('fs');

const gbaFeatures = [
    'Raadpleeg verblijfplaatshistorie op peildatum',
    'Raadpleeg verblijfplaatshistorie met periode',
    'Autorisatie',
    'Protocollering'
];

const proxyFeatures = [
    'Raadpleeg verblijfplaatshistorie op peildatum',
    'Raadpleeg verblijfplaatshistorie met periode'
];

function getSummaryFiles(src) {
    let files = [];

    const items = readdirSync(src, {withFileTypes: true});
    for(const item of items) {
        if(item.isDirectory()) {
            files = [...files, ...getSummaryFiles(`${src}/${item.name}`)];
        }
        else if(RegExp(/.*-summary.txt/).exec(item.name)) {
            files.push(`${src}/${item.name}`);
        }
    }

    return files;
}

function getSummaryLine(file) {
    const lines = readFileSync(file, { encoding: 'utf8' }).split(/\r?\n/);
    return lines.find(line => RegExp(/^\d+ scenarios (\(\d+ passed\)|\(\d+ failed, \d+ passed\)|\(\d+ failed\))$/).exec(line));
}

function parseSummaries(source) {
    const summaryFiles = getSummaryFiles(source);
    let scenarioSummary = {
        total: 0,
        failed: 0,
        passed: 0,
        gba: [],
        proxy: []
    }
    summaryFiles.forEach(file => {
        const line = getSummaryLine(file);

        let match = RegExp(/^(?<total>\d+) scenarios \((?<passed>\d+) passed\)$/).exec(line);
        if(match) {
            scenarioSummary.total += Number(match.groups['total']);
            scenarioSummary.passed += Number(match.groups['passed']);
        }
        match = RegExp(/^(?<total>\d+) scenarios \((?<failed>\d+) failed, (?<passed>\d+) passed\)$/).exec(line);
        if(match) {
            scenarioSummary.total += Number(match.groups['total']);
            scenarioSummary.failed += Number(match.groups['failed']);
            scenarioSummary.passed += Number(match.groups['passed']);
        }
        match = RegExp(/^(?<total>\d+) scenarios \((?<failed>\d+) failed\)$/).exec(line);
        if(match) {
            scenarioSummary.total += Number(match.groups['total']);
            scenarioSummary.failed += Number(match.groups['failed']);
        }

        match = file.match(/.*\/test-result-(?<report>[\w-]+)-summary.txt/);
        if(match) {
            const report = match.groups['report'];
            if(report.includes('-gba')) {
                scenarioSummary.gba.push({
                    'name': report.replace('-gba', ''),
                    'summary': line,
                    'failedScenarios': parseFailedScenariosFromSummaryFile(file)
                });
            }
            else {
                scenarioSummary.proxy.push({
                    'name': report,
                    'summary': line,
                    'failedScenarios': parseFailedScenariosFromSummaryFile(file)

                });
            }
        }
    });

    return(scenarioSummary);
}

function writeFeatureSummary(features, type, summary, file) {
    const suffix = type === 'gba' ? '-gba' : '';

    features.forEach(feature => {
        const featureName = feature.toLowerCase().replaceAll(' ', '-');
        const featureSummary = summary[type].find(s => s.name == featureName);

        const match = feature.match(/^Persoon .*$/);
        let line = match && feature !== 'Persoon beperkt'
            ? `  - [${feature.replace('Persoon ', '')}]`
            : `- [${feature}]`;
        line += `(./test-report-${featureName}${suffix}.html){:target="_blank" rel="noopener"}`;

        if(featureSummary !== undefined) {
            line += `: ${featureSummary.summary}`;
        }
        line += '\n';

        file.write(line);

        if(featureSummary !== undefined) {
            featureSummary.failedScenarios.forEach(l => {
                file.write(`    - ${l}\n`);
            });
        }
    });
}

function writeSummaryToMarkdown(source, target, gbaVersion, proxyVersion) {
    const summary = parseSummaries(source);
    const file = createWriteStream(target, { encoding: 'utf8' });

    try {
        file.write('---\n');
        file.write('layout: page-with-side-nav\n');
        file.write('title: Features test overzicht\n');
        file.write('---\n');
        file.write(`# Features test overzicht\n\n`);
        file.write(`Totaal: ${summary.total} scenarios (${summary.failed} failed, ${summary.passed} passed)\n\n`);
    
        file.write(`## GBA v${gbaVersion}\n\n`);
        writeFeatureSummary(gbaFeatures, 'gba', summary, file);
    
        file.write('\n\n');
    
        file.write(`## Proxy v${proxyVersion}\n\n`);
        writeFeatureSummary(proxyFeatures, 'proxy', summary, file);
    }
    finally {
        file.close();
    }
}

function parseFailedScenariosFromSummaryFile(file) {
    const lines = readFileSync(file, { encoding: 'utf8' }).split(/\r?\n/);
    let retval = [];
    lines.forEach(function(line) {
        if(RegExp(/^\d*\) /).exec(line)) {
            retval.push(line.replace(/^\d*\) Scenario: .* # /, ''));
        } 
    })
    return retval;
}

writeSummaryToMarkdown('./docs/features', './docs/features/index.md', process.argv[2], process.argv[3]);
