---
layout: page-with-side-nav
title: Getting Started
---
# Getting Started

De 'BRP-historie bevragen' Web API is gespecificeerd in OpenAPI specifications (OAS).

Wil je de API gebruiken? Dit kun je doen:

1. Bekijk de [functionaliteit en specificaties](#functionaliteit-en-specificaties)
2. [Implementeer de API Client](#implementeer-de-api-client)
3. [Probeer en test de API](#probeer-en-test-de-api)

## Functionaliteit en specificaties
Je kunt historie op drie manieren opzoeken:
1. Met een peildatum. Je krijgt dan de situatie op de opgegeven datum.
2. Met een periode (datumVan en datumTotEnMet). Je krijgt dan de historie binnen de opgegeven periode.
3. Zonder peildatum of periode. Je krijgt dan alle historie die de registratie heeft.

Je kunt een visuele weergave van de specificatie bekijken met [Swagger UI](swagger-ui) of [Redoc](redoc).

Je kunt de [functionele documentatie](./features) vinden in de [features](./features).

## Implementeer de API client
Client code kun je genereren met de "[genereervariant](https://github.com/BRP-API/Haal-Centraal-BRP-historie-bevragen/blob/master/specificatie/genereervariant/openapi.yaml){:target="_blank" rel="noopener"}" van de API-specificaties en een code generator. Een overzicht met codegeneratoren kun je vinden op [OpenAPI.Tools](https://openapi.tools/#sdk){:target="_blank" rel="noopener"}.

Deze repo bevat scripts waarmee je met [OpenAPI Generator](https://openapi-generator.tech/){:target="_blank" rel="noopener"} client code kunt genereren in JAVA, .NET (Full Framework & Core) en Python. De makkelijkste manier om de code generatie scripts te gebruiken, is door deze repo te clonen. Na het clonen kun je met `npm install` de benodigde packages installeren en kun je met npm run <script naam> één van de volgende scripts uitvoeren:
- oas:generate-java-client (voor JAVA client code)
- oas:generate-netcore-client (voor .NET Core client code)
- oas:generate-net-client (voor .NET Full Framework client code)
- oas:generate-python-client (voor Python client code)

Een lijst met andere ondersteunde generator opties kun je vinden in de [Generators List](https://openapi-generator.tech/docs/generators){:target="_blank" rel="noopener"} van OpenAPI Generator.

Note. De prerequisite van OpenAPI Generator is JAVA. Je moet een JAVA runtime installeren voordat je OpenAPI Generator kunt gebruiken
  
## Probeer en test de API

Je kunt de {{ site.apiname }} uitproberen op de demo omgeving met de volgende url: [{{ site.proefProxyUrl }}]. Hiervoor heb je een apikey nodig.

Om de web api te gebruiken heb je een apikey nodig. Deze voeg je aan een request toe als header "X-API-KEY". Een API-key vraag je aan bij de product owner [cathy.dingemanse@rvig.nl](mailto:cathy.dingemanse@rvig).



### Importeer de specificaties in Postman

De werking van de API is het makkelijkst te testen met behulp van [Postman](https://www.getpostman.com/){:target="_blank" rel="noopener"}. We hebben al een [Postman collection](https://github.com/BRP-API/Haal-Centraal-BRP-historie-bevragen/blob/master/test/BRP-Historie-Bevragen-postman-collection.json){:target="_blank" rel="noopener"} voor je klaargezet. Deze kun je importeren in Postman. 

### Configureer de url en api key

1. Klik bij "BRP historie bevragen" op de drie bolletjes.
2. Klik vervolgens op Edit
3. Selecteer tabblad "Authorization"
4. Kies TYPE "API Key"
5. Vul in Key: "x-api-key", Value: de API key die je van Cathy hebt ontvangen, Add to: "Header"
6. Selecteer tabblad "Variables"
7. Vul bij baseUrl INITIAL VALUE en bij CURRENT VALUE: `https://www.haalcentraal.nl/haalcentraal/api/brphistorie`
8. Klik op de knop Update

### Testpersonen

Deze tabel bevat de burgerservicenummers van testpersonen voor specifieke situaties waarmee de 'BRP historie bevragen' Web API kan worden getest.

burgerservicenummer | situatie
---------------- | :-------  
999993847 | verblijfplaats in onderzoek
999993483 | uitgebreide verblijfplaatshistorie
999990482 | niet-BAG adres
000009921 | locatiebeschrijving
999993653 | niet-Nederlandse nationaliteit
999995017 | actuele en historische verblijfstitel
999994669 | verblijfplaatshistorie met verblijf buitenland en locatiebeschrijving en adrescorrectie
999992806 | uitgebreide verblijfstitelhistorie
999993926 | actuele en meerdere ex-partners
999991905 | twee beëindigde relaties
999993550 | partner niet ingeschreven

De API gebruikt de GBA-V proefomgeving. Alle testpersonen die daarin voorkomen kun je ook in de API gebruiken. De volledige set testpersonen kan worden gedownload bij de [RvIG](https://www.rvig.nl/documenten/richtlijnen/2018/09/20/testdataset-persoonslijsten-proefomgevingen-gba-v){:target="_blank"}.
Een vertaling van GBA-V (LO GBA) attributen naar BRP API properties staat beschreven in de [BRP-LO GBA mapping](https://github.com/BRP-API/Haal-Centraal-BRP-bevragen/blob/master/docs/BRP-LO%20GBA%20mapping.xlsx?raw=true){:target="_blank" rel="noopener"}.
