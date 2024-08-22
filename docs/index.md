---
layout: page-with-side-nav
title: BRP Verblijfplaatshistorie
---

# BRP Verblijfplaatshistorie

![lint oas](https://github.com/BRP-API/Haal-Centraal-BRP-historie-bevragen/workflows/lint-oas/badge.svg)
![ci](https://github.com/BRP-API/Haal-Centraal-BRP-historie-bevragen/workflows/ci/badge.svg)

Met de BRP API Verblijfplaatshistorie kun je de verblijfplaats(en) van een persoon opvragen in een periode of op een peildatum. 

## Planning en Roadmap
De BRP API Verblijfplaatshistorie wordt rond 1 september 2024 verwacht. 

## Aansluiten en voorwaarden
Gemeenten en andere afnemers van de BRP met een autorisatiebesluit mogen deelnemen aan het experiment en de BRP API gebruiken. Iedere deelnemer sluit een convenant met RvIG waarin de afspraken voor deelname zijn vastgelegd. Voor de technische aansluiting is een API Gateway nodig. Aansluiten kan via Diginetwerk met gebruik van een TLS verbinding (PKIO certificaat) en een OAuth 2.0 token (OAuth 2.0 client credentials flow).

Stuur een mail naar [info@RvIG](mailto:info@rvig) voor een kennismakingmakingsgesprek en onboarding. [Download]({{ site.onboardingUrl }}){:target="_blank" rel="noopener"} en lees het onboardingproces.


## Direct uitproberen?
* Bekijk de specificaties met [Redoc](redoc-io)
* Lees de [Getting started](./getting-started)

## Heb je meer nodig? 
Gebruik de BRP API Verblijfplaatshistorie in combinatie met andere functies van de BRP API:

* [BRP Personen](https://BRP-API.github.io/Haal-Centraal-BRP-bevragen){:target="_blank" rel="noopener"}
* [BRP Reisdocumenten](https://BRP-API.github.io/Haal-Centraal-Reisdocumenten-bevragen){:target="_blank" rel="noopener"}
* [BRP Bewoning](https://BRP-API.github.io/Haal-Centraal-BRP-bewoning){:target="_blank" rel="noopener"}

## Bronnen
* [API Design Visie](https://github.com/Geonovum/KP-APIs/blob/master/overleggen/Werkgroep%20API%20design%20visie/API%20Design%20Visie.md){:target="_blank" rel="noopener"}
* [REST API Design Rules](https://docs.geostandaarden.nl/api/API-Designrules/){:target="_blank" rel="noopener"}
* [Landelijke API strategie voor de overheid](https://geonovum.github.io/KP-APIs/){:target="_blank" rel="noopener"}

## Contact

* Heb je een vraag? Neem contact op met Cathy Dingemanse, [{{ site.PO-email }}](mailto:{{ site.PO-email }}) 
* Bug Melden
  [Maak een bug issue aan >>](https://github.com/BRP-API/Haal-Centraal-BRP-bevragen/issues/new?assignees=&labels=bug&template=bug_report.md&title=)
* Verbeteringen doorgeven
  [Maak een verbeter issue aan >>](https://github.com/BRP-API/Haal-Centraal-BRP-bevragen/issues/new?assignees=&labels=enhancement&template=enhancement.md&title=)

* Product Owner: Cathy Dingemanse, [{{ site.PO-email }}](mailto:{{ site.PO-email }})
* Developer en customer zero: Melvin Lee, [{{ site.CZ-email }}](mailto:{{ site.CZ-email }})
* Tester: Frank Samwel, [{{ site.Tester-email }}](mailto:{{ site.Tester-email }})

## Licentie

Copyright &copy; RvIG 2022
Licensed under the [EUPL]({{ masterBranchUrl }}/LICENCE.md){:target="_blank" rel="noopener"}
