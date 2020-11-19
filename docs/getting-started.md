---
layout: page-with-side-nav
title: Getting Started
---
# Getting Started

De 'BRP-historie bevragen' Web API is gespecificeerd in OpenAPI specifications (OAS).

Wil je de API gebruiken? Dit kun je doen:

1. Bekijk de functionaliteit en specificaties
2. Implementeer de API
3. Probeer en test de API

## Functionaliteit en specificaties
De historie kan op drie manieren worden gebruikt:
1. Met een peildatum. Je krijgt dan de situatie op de opgegeven datum.
2. Met een periode (datumVan en datumTotEnMet). Je krijgt dan de historie
over de opgegeven periode.
3. Zonder peildatum of periode. Je krijgt dan de gehele historie zoals die
bekend is in de registratie.

Je kunt een visuele weergave van de specificatie inzien met [Swagger UI](https://vng-realisatie.github.io/Haal-Centraal-BRP-historie-bevragen/swagger-ui) of [Redoc](https://vng-realisatie.github.io/Haal-Centraal-BRP-historie-bevragen/redoc).

De [functionele documentatie](https://vng-realisatie.github.io/Haal-Centraal-BRP-historie-bevragen/features) is beschreven in [features](https://vng-realisatie.github.io/Haal-Centraal-BRP-historie-bevragen/features).

## Implementeer de API

Je kunt code genereren op basis van de [genereervariant van de specificaties](https://github.com/VNG-Realisatie/Haal-Centraal-BRP-historie-bevragen/blob/master/specificatie/genereervariant/openapi.yaml){:target="_blank" rel="noopener"}.
Voor enkele ontwikkelomgevingen is al [client code](https://github.com/VNG-Realisatie/Haal-Centraal-BRP-historie-bevragen/tree/master/code){:target="_blank" rel="noopener"} gegenereerd.

## Probeer en test

Wil je de 'BRP-historie bevragen' Web API proberen en testen? Kijk op: `https://www.haalcentraal.nl/haalcentraal/api/brphistorie`

Om de web api te gebruiken heb je een apikey nodig. Deze voeg je aan een request toe als header "X-API-KEY". Een API-key vraag je aan bij de product owner [cathy.dingemanse@denhaag.nl](mailto:cathy.dingemanse@denhaag.nl).

__De Haal Centraal probeeromgeving gebruikt GBA-V op basis van de gemeentelijke autorisatie "Algemene gemeentetaken" voor buitengemeentelijke personen. Dit betekent dat de GBA-V niet alle gegevens teruggeeft die in de response zijn gedefinieerd. Het endpoint nationaliteithistorie werkt niet in de probeeromgeving, omdat de GBA-V autorisatie daarvoor niet voldoende gegevens bevat. In de [API mapping](https://github.com/VNG-Realisatie/Haal-Centraal-BRP-bevragen/blob/master/docs/BRP-LO%20GBA%20mapping.xlsx?raw=true){:target="_blank" rel="noopener"} kun je zien welke gegevens wel of niet onder deze autorisatie vallen.__

__Je kan de Haal Centraal probeeromgeving niet gebruiken vanuit de browser, dus ook niet vanuit de browserversie van Postman. Gebruik dus de desktopversie van een testtool (zoals Postman) om berichten te sturen.__

### Importeer de specificaties in Postman

De werking van de API is het makkelijkst te testen met behulp van [Postman](https://www.getpostman.com/){:target="_blank" rel="noopener"}. We hebben al een [Postman collection](https://github.com/VNG-Realisatie/Haal-Centraal-BRP-historie-bevragen/blob/master/test/BRP-Historie-Bevragen-postman-collection.json){:target="_blank" rel="noopener"} voor je klaargezet. Deze kun je importeren in Postman. 

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

Onderstaande tabel bevat de burgerservicenummers van testpersonen voor specifieke situaties waarmee de 'BRP historie bevragen' Web API kan worden getest.

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
Een vertaling van GBA-V (LO GBA) attributen naar BRP API properties staat beschreven in de [BRP-LO GBA mapping](https://github.com/VNG-Realisatie/Haal-Centraal-BRP-bevragen/blob/master/docs/BRP-LO%20GBA%20mapping.xlsx?raw=true){:target="_blank" rel="noopener"}.
