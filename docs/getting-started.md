# Getting Started

_**Deze Getting started is in concept. Pas als de er een test-implementatie beschikbaar is wordt deze aangepast.**_

De 'BRP-historie-bevragen' Web API is gespecificeerd met behulp van de OpenAPI specifications (OAS).

Om de API te gebruiken kun je de volgende stappen doorlopen:

1. Bekijk de [functionaliteit en specificaties](#Functionaliteit-en-specificaties)
2. [Implementeer](#Implementeer-de-API) de API
3. [Probeer en test](#Probeer-en-test) de API

## Functionaliteit en specificaties

Een visuele representatie van de specificatie kan worden gegenereerd met [Swagger UI](https://vng-realisatie.github.io/Haal-Centraal-BRP-historie-bevragen/swagger-ui/) of [Redoc](https://vng-realisatie.github.io/Haal-Centraal-BRP-historie-bevragen/redoc/).

De [functionele documentatie](../../../features) van de 'Bevraging Ingeschreven Persoon' Web API is ook te vinden in de github repository.

## Implementeer de API

Je kunt code genereren op basis van de [genereervariant van de specificaties](../specificatie/genereervariant/openapi.yaml).
We hebben al voor enkele ontwikkelomgevingen [client code](../code) gegenereerd.

## Probeer en test

De 'BRP historie bevragen' Web API is voor proberen en testen nog niet te benaderen


### Importeer de specificaties in Postman

De werking van de 'BRP historie bevragen' Web API is het makkelijkst te testen met behulp van [Postman](https://www.getpostman.com/). We hebben al een [Postman collection](../test/BRP-historie-bevragen-postman-collection.json) klaargezet. Deze kun je importeren in Postman.

In Postman kan de 'BRP historie bevragen' OpenAPI specificatie worden geïmporteerd en kan vervolgens visueel de verschillende endpoints worden aangeroepen. Volg onderstaande stappen om de OpenAPI specificatie bestand te importeren:
![Import](./img/1-click-import-button.jpg)  
1.Klik op de Import button om de Import dialog box te openen

!['Import From Link'](./img/2-select-import-from-link-tab.jpg)  
2.Selecteer 'Import From Link' tab, plak de volgende url in de 'Enter a URL and press Import' textbox en klik op de Import button

``` url
https://raw.githubusercontent.com/VNG-Realisatie/Haal-Centraal-BRP-historie-bevragen/master/specificatie/genereervariant/openapi.yaml
```

![Generate Postman collection](./img/3-generate-postman-collection.jpg)  
3.Klik op de Next button om een Postman collectie te genereren uit OpenAPI specificatie bestand

![Postman collection overview](./img/4-postman-collection-overview.jpg)  
4.Import overzicht

### Configureer de url en api key

1. Klik bij "BRP historie bevragen" op de drie bolletjes.
![Generate Postman collection](./img/edit-collection.png)
2. Klik vervolgens op Edit
3. Selecteer tabblad "Authorization"
4. Kies TYPE "API Key"
5. Vul in Key: "x-api-key", Value: de API key die je van Cathy hebt ontvangen, Add to: "Header"
6. Selecteer tabblad "Variables"
7. Vul bij baseUrl INITIAL VALUE en bij CURRENT VALUE: `https://www.haalcentraal.nl/haalcentraal/api/brp`
8. Klik op de knop Update
