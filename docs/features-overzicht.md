---
layout: page-with-side-nav
title: Features
---

# {{ site.apiname }} Web API Features

Met de {{ site.apiname }} Web API kun je de verblijfplaats(en) van een persoon opvragen in een periode of op een peildatum.

In de BRP worden personen uniek geïdentificeerd met behulp van hun burgerservicenummer. Dit 9-cijferige nummer gebruik je om aan te geven van welke persoon je de verblijfplaatsgegevens wilt opvragen.

## Algemene Verordening Gegevensbescherming (AVG)

De BRP bevragen API is ontworpen conform de REST principes. Om ook aan de AVG te conformeren zijn concessies gedaan aan het toepassen van de REST principes. De belangrijkste concessie is dat de POST methode en niet de GET methode wordt gebruikt om verblijfplaatsen van personen te bevragen. Dit zorgt er voor dat er geen [persoonlijk identificeerbare informatie (PII)](https://piwikpro.nl/blog/pii-niet-pii-en-persoonsgegevens/) terecht komen in de url van een request en daardoor ook niet in server logs.

## Raadplegen van de verblijfplaats op een datum

Raadpleeg op welke verblijfplaats een persoon verbleef op een specifieke datum door de operatie "RaadpleegMetPeildatum" en de parameter "peildatum" te gebruiken.

Als je bijvoorbeeld wilt weten waar de persoon verbleef op 3 juli 2021 stuur je als request body:
```
{
  "burgerservicenummer": "999994669",
  "type": "RaadpleegMetPeildatum",
  "peildatum": "2021-07-03"
}
```
## Raadplegen van de verblijfplaatsen gedurende een periode

Raadpleeg op welke verblijfplaats(en) een persoon verbleef tijdens een periode door de operatie "RaadpleegMetPeriode" en parameters *"datumVan"* en *"datumTot"* te gebruiken.

Als je bijvoorbeeld wilt weten waar de persoon verbleef tussen 3 juli 2021 en 8 oktober 2022 stuur je als request body:
```
{
  "burgerservicenummer": "999994669",
  "type": "RaadpleegMetPeriode",
  "datumVan": "2021-07-03",
  "datumTot": "2022-10-08"
}
```

De regels voor het opnemen van verblijfplaatsen op basis van opgegeven "datumVan" en "datumTot" zijn beschreven in de volgende featurebestanden:
- [periode-filtering.feature](https://github.com/BRP-API/historie-data-service/blob/main/features/raadpleeg-verblijfplaats-met-periode/periode-filtering.feature)
- [periode-filtering-onbekende-aanvang.feature](https://github.com/BRP-API/historie-data-service/blob/main/features/raadpleeg-verblijfplaats-met-periode/periode-filtering-onbekende-aanvang.feature)
- [periode-filtering-onbekende-aanvang-volgende.feature](https://github.com/BRP-API/historie-data-service/blob/main/features/raadpleeg-verblijfplaats-met-periode/periode-filtering-onbekende-aanvang-volgende.feature)

Verblijfplaatsen worden *gesorteerd* geleverd, zodat de meest actuele verblijfplaats de eerste is in de lijst. Zie het [historie volgorde featurebestand](https://github.com/BRP-API/historie-data-service/blob/main/features/raadpleeg-verblijfplaats-met-periode/historie-volgorde.feature) .

Het resultaat van deze vraag bevat alle verblijfplaatsen waar de persoon tijdens de periode minimaal 1 dag stond ingeschreven. Bij elke verblijfplaats is "datumVan" (de begindatum van het verblijf) in het antwoord opgenomen, en wanneer de persoon er nu niet meer verblijft is "datumTot" opgenomen als de datum dat de persoon er niet meer verblijft. In het [datum van en tot featurebestand](https://github.com/BRP-API/historie-informatie-service/blob/main/features/raadpleeg-verblijfplaats-met-periode/datum-van-en-tot.feature) zijn de regels beschreven voor het leveren van datumVan en datumTot.

## Eén of meer gevraagde velden zijn in onderzoek

Om een afnemer te informeren dat één of meer gevraagde velden in onderzoek zijn, worden de bijbehorende inOnderzoek en datumIngangOnderzoek velden ook geleverd.
Wanneer één of meer velden waaruit een andere veld wordt afgeleid (bijv. de adressering velden) in onderzoek zijn, dan is het afgeleide veld ook in onderzoek en wordt het inOnderzoek veld van het afgeleide veld ook geleverd.
In het [in onderzoek featurebestand](https://github.com/BRP-API/historie-informatie-service/blob/main/features/raadpleeg-verblijfplaats-met-periode/in-onderzoek.feature) zijn de regels beschreven wanneer welke inOnderzoek velden worden geleverd.

### Vastgesteld verblijft niet op adres

Als je verblijfplaatsgegevens en/of adresregels vraagt van persoon die niet meer verblijft op het geregistreerde adres, dan wordt het **indicatieVastgesteldVerblijftNietOpAdres** veld met waarde true meegeleverd. Dit betekent dat tijdens een onderzoek naar de verblijfplaats van de persoon is gebleken dat de persoon niet op dit adres woont. De functionaliteit van het **indicatieVastgesteldVerblijftNietOpAdres** veld is beschreven in het [vastgesteld verblijft niet op adres featurebestand](https://github.com/BRP-API/historie-informatie-service/blob/main/features/raadpleeg-verblijfplaats-met-periode/vastgesteld-verblijft-niet-op-adres.feature).
