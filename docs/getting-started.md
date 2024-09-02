---
layout: page-with-side-nav
title: Getting Started
---
# Getting Started

Gemeenten en andere organisaties met een autorisatiebesluit kunnen zich aanmelden voor deelname aan het Experiment dataminimalisatie.

1. Bekijk de [functionaliteit en specificaties](#functionaliteit-en-specificaties)
2. Probeer en test de {{ site.apiname }} [lokaal](#probeer-en-test-de-api-lokaal) of in de [demo omgeving](#probeer-en-test-de-api-in-de-demo-omgeving)
3. [Download]({{ site.onboardingUrl }}){:target="_blank" rel="noopener"} en lees het onboardingproces

## Functionaliteit en specificaties

De {{ site.apiname }} is gespecificeerd met behulp van de [OpenAPI Specification v3.0.3](https://spec.openapis.org/oas/v3.0.3).

De OAS3 specificatie van de {{ site.apiname }} kan worden bekeken met behulp van [Redoc](./redoc).

Download de [OAS3 specificatie]({{ site.mainBranchUrl }}/specificatie/genereervariant/openapi.yaml){:target="_blank" rel="noopener"} van de '{{ site.apiname }}' om hiermee consumer code te genereren.

De [functionele documentatie](./features-overzicht) van de {{ site.apiname }} vind je in het [features overzicht](./features-overzicht).

## Probeer en test de API in de demo omgeving

Je kunt de {{ site.apiname }} uitproberen op de demo omgeving met de volgende url: [{{ site.proefProxyUrl }}]. Hiervoor heb je een apikey nodig.

- Vraag een apikey aan bij de product owner [{{ site.PO-email }}](mailto:{{ site.PO-email }}). 
- Voeg de apikey toe aan een request met de __X-API-KEY__ header.

Bijvoorbeeld met de volgende aanroep, waarbij je de waarde "••••••" bij header x-api-key vervangt met de api key die je ontvangen hebt:
```
curl --location 'https://demo-omgeving.haalcentraal.nl/haalcentraal/api/brphistorie/verblijfplaatshistorie' \
--header 'Content-Type: application/json' \
--header 'Accept: application/json' \
--header 'x-api-key: ••••••' \
--data '{
  "burgerservicenummer": "999994669",
  "type": "RaadpleegMetPeildatum",
  "peildatum": "2020-07-01"
}
```

### Prerequisites

- [Docker Desktop](https://www.docker.com/products/docker-desktop) voor het hosten van containers
- Je kunt Docker Desktop ook gebruiken om de containers te hosten met behulp van de Kubernetes engine. Hiervoor moet je in Docker Desktop Kubernetes ondersteuning aanzetten in het Settings/Kubernetes configuratie scherm ![Enable Kubernetes](../img/docker-desktop-enable-k8s.png)

Optioneel kun je de volgende tools ook op de lokale machine installeren:

- [git](https://git-scm.com/downloads) voor het clonen van git repositories
- [Postman](https://www.postman.com/downloads/) voor het aanroepen van {{ site.apiname }}


### Gebruik Docker als container engine

- Download het [docker compose bestand]({{ site.mainBranchUrl }}/docker-compose.yml){:target="_blank" rel="noopener"}
- Start een command prompt window voor de map met het docker-compose.yaml bestand
- Start de {{ site.apiname }} en de mock met behulp van de volgende statement:
  ```sh

  docker compose -f docker-compose.yml up -d

  ```
  De {{ site.apiname }} mock is nu te benaderen via de url: *http://localhost:5000/haalcentraal/api/brp/verblijfplaatshistorie*
- Valideer dat de {{ site.apiname }} mock draait met behulp van de volgende curl statement:
  ```sh

  curl --location --request POST 'http://localhost:5000/haalcentraal/api/brp/verblijfplaatshistorie' \
  --header 'Content-Type: application/json' \
  --data-raw '{
      "burgerservicenummer": "999994669",
      "type": "RaadpleegMetPeildatum",
      "peildatum": "2020-07-01"
  }'
  ```
- Om de {{ site.apiname }} mock container te stoppen voer je het volgende statement uit:
  ```sh

  docker compose -f docker-compose.yml down

  ```
  
