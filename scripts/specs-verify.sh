#!/bin/bash

DBHOST=$1
DBUSER=$2
DBPASSWORD=$3
CLIENTID=$4
CLIENTSECRET=$5

PARAMS="{ \
  \"deleteIndividualRecords\": false, \
  \"poolConfig\": { \
    \"host\": \"${DBHOST}\", \
    \"user\": \"${DBUSER}\", \
    \"password\": \"${DBPASSWORD}\" \
  }, \
  \"client\": { \
    \"clientId\": \"${CLIENTID}\", \
    \"clientSecret\": \"${CLIENTSECRET}\" \
  }\
}"

mkdir -p docs/features

npx cucumber-js -f json:docs/features/test-result-autorisatie-gba.json \
                -f summary:docs/features/test-result-autorisatie-gba-summary.txt \
                features \
                --tags "not @skip-verify" --tags "@autorisatie" \
                --world-parameters "$PARAMS"

npx cucumber-js -f json:docs/features/test-result-protocollering-gba.json \
                -f summary:docs/features/test-result-protocollering-gba-summary.txt \
                features \
                --tags "not @skip-verify" --tags "@protocollering" \
                --world-parameters "$PARAMS"

npx cucumber-js -f json:docs/features/test-result-raadpleeg-verblijfplaatshistorie-op-peildatum-gba.json \
                -f summary:docs/features/test-result-raadpleeg-verblijfplaatshistorie-op-peildatum-gba-summary.txt \
                features/raadpleeg-verblijfplaats-op-peildatum \
                fout-cases-gba.feature \
                --tags "not @skip-verify" --tags "@gba" --tags "not @autorisatie" --tags "not @protocollering" \
                --world-parameters "$PARAMS"

npx cucumber-js -f json:docs/features/test-result-raadpleeg-verblijfplaatshistorie-met-periode-gba.json \
                -f summary:docs/features/test-result-raadpleeg-verblijfplaatshistorie-met-periode-gba-summary.txt \
                features/raadpleeg-verblijfplaats-met-periode \
                --tags "not @skip-verify" --tags "@gba" --tags "not @autorisatie" --tags "not @protocollering" \
                --world-parameters "$PARAMS"

npx cucumber-js -f json:docs/features/test-result-raadpleeg-verblijfplaatshistorie-op-peildatum.json \
                -f summary:docs/features/test-result-raadpleeg-verblijfplaatshistorie-op-peildatum-summary.txt \
                features/raadpleeg-verblijfplaats-op-peildatum \
                fout-cases.feature \
                --tags "not @skip-verify" --tags "not @gba" \
                --world-parameters "$PARAMS"

npx cucumber-js -f json:docs/features/test-result-raadpleeg-verblijfplaatshistorie-met-periode.json \
                -f summary:docs/features/test-result-raadpleeg-verblijfplaatshistorie-met-periode-summary.txt \
                features/raadpleeg-verblijfplaats-met-periode \
                --tags "not @skip-verify" --tags "not @gba" \
                --world-parameters "$PARAMS"
