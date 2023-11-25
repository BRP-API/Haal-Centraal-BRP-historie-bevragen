---
layout: page-with-side-nav
title: Haal-Centraal-BRP-historie-bevragen
---

# Haal Centraal BRP historie bevragen

![lint oas](https://github.com/BRP-API/Haal-Centraal-BRP-historie-bevragen/workflows/lint-oas/badge.svg)
![generate postman collection](https://github.com/BRP-API/Haal-Centraal-BRP-historie-bevragen/workflows/generate-postman-collection/badge.svg)

API voor het raadplegen van historische gegevens over personen. Met deze API kun je de verblijfplaats(en) van een persoon opvragen in een periode of op een peildatum. 

## Planning en Roadmap
De BRP Historie API voor verblijfplaatshistorie wordt tweede kwartaal van 2024 verwacht. 

## Aansluiten en voorwaarden
De BRP Historie API is beschikbaar voor gemeenten en andere afnemers van de BRP met een passend autorisatiebesluit voor verstrekking van een zoekvraag die deelnemen aan het [Experiment Dataminimalisatie]. Iedere deelnemer sluit aan met een API Gateway voor een veilige verbinding met RvIG, en sluit een convenant met RvIG waarin de afspraken voor deelname zijn vastgelegd. De aansluiting verloopt via Diginetwerk, vereist een TLS verbinding (PKIO certificaat) en een OAuth 2.0 token (OAuth 2.0 client credentials flow). 

Stuur een mail naar info@RvIG voor een kennismakingmakingsgesprek en onboarding.

## Direct uitproberen?
* Bekijk de specificaties met [Swagger UI](swagger-ui) of [Redoc](redoc)
* Lees de [Getting started](./getting-started)
* Download de [technische specificaties](https://github.com/BRP-API/Haal-Centraal-BRP-historie-bevragen/blob/master/specificatie/genereervariant/openapi.yaml){:target="_blank" rel="noopener"}
* Vraag een API-key voor toegang tot de Haal Centraal probeeromgeving aan bij de product owner [cathy.dingemanse@denhaag.nl](mailto:cathy.dingemanse@denhaag.nl)

## Heb je meer nodig? 
Gebruik de BRP historie bevragen API in combinatie met (een van de) andere BRP API’s:

* [Actuele BRP-gegevens bevragen](https://BRP-API.github.io/Haal-Centraal-BRP-bevragen){:target="_blank" rel="noopener"}
* [Reisdocumenten bevragen](https://BRP-API.github.io/Haal-Centraal-Reisdocumenten-bevragen){:target="_blank" rel="noopener"}
* [Bewoning en medebewoners bevragen](https://BRP-API.github.io/Haal-Centraal-BRP-bewoning){:target="_blank" rel="noopener"}
* [Landelijke tabellen bevragen](https://BRP-API.github.io/Haal-Centraal-BRP-tabellen-bevragen){:target="_blank" rel="noopener"}

## Bronnen
* [API Design Visie](https://github.com/Geonovum/KP-APIs/blob/master/overleggen/Werkgroep%20API%20design%20visie/API%20Design%20Visie.md){:target="_blank" rel="noopener"}
* [REST API Design Rules](https://docs.geostandaarden.nl/api/API-Designrules/){:target="_blank" rel="noopener"}
* [Landelijke API strategie voor de overheid](https://geonovum.github.io/KP-APIs/){:target="_blank" rel="noopener"}

## Contact

* Bug Melden
  [Maak een bug issue aan >>](https://github.com/BRP-API/Haal-Centraal-BRP-historie-bevragen/issues/new?assignees=&labels=bug&template=bug_report.md&title=)
* Verbeteringen doorgeven
  [Maak een verbeter issue aan >>](https://github.com/BRP-API/Haal-Centraal-BRP-historie-bevragen/issues/new?assignees=&labels=enhancement&template=enhancement.md&title=)

* Product Owner: Cathy Dingemanse, [c.dingemanse@comites.nl](mailto:c.dingemanse@comites.nl)
* Designer: Johan Boer, [johan.boer@vng.nl](mailto:johan.boer@vng.nl)
* Designer: Robert Melskens, [robert.melskens@vng.nl](mailto:robert.melskens@vng.nl)
* Customer zero: Melvin Lee, [melvin.lee@iswish.nl](mailto:melvin.lee@iswish.nl)
* Tester: Frank Samwel, [frank.samwel@denhaag.nl](mailto:frank.samwel@rvig.nl)

## Licentie

Copyright&copy; VNG Realisatie 2020
Licensed under the [EUPL](https://github.com/BRP-API/Haal-Centraal-BRP-historie-bevragen/blob/master/LICENCE.md){:target="_blank" rel="noopener"}
