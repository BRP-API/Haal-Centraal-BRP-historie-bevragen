# language: nl

Functionaliteit: Lever de juiste nationaliteit na verlies Nederlanderschap

  Als consumer van de BRP
  Wil ik de nationaliteiten van een persoon

  Een vreemde nationaliteit wordt alleen geregistreerd voor een persoon die niet de Nederlandse nationaliteit heeft. 
  In het verleden gebeurde dat wel, waarna deze registratie is beëindigd met reden 404 "Beëindiging registratie (niet-Nederlandse) nationaliteit".

  Wanneer een persoon de Nederlandse nationaliteit verliest, wordt de registratie van de vreemde (niet-Nederlandse) nationaliteit hersteld. 
  Dit kan op verschillende manieren zijn doorgevoerd in de registratie.

  1. In dezelfde "stapel" wordt de nationaliteit opnieuw opgevoerd, met als datum ingang geldigheid de datum van verlies Nederlandse nationaliteit.
  2. In dezelfde "stapel" wordt de nationaliteit opnieuw opgevoerd, en krijgt de beëindiging indicatie onjuist.

  In het eerste geval is de beëindiging niet vastgelegd als onjuist en geldt deze dus. 
  Is de datum ingang geldigheid van de nationaliteit in de actuele nationaliteit anders dan van de nationaliteit direct voor de beëindiging, 
  is hier sprake van een andere periode van geldigheid van de nationaliteit. Dit moet dan als twee nationaliteiten worden opgenomen.
  
  In het tweede geval is de beëindiging onjuist en kan deze volledig genegeerd worden, als was de vreemde nationaliteit is nooit beëindigd geweest.

  Daar waar in onderstaande scenario's in de Gegeven stap de tabel meer dan 1 rij waarden bevat, staat de meest actuele bovenaan en de oudste status onderaan.

  Rule: Wanneer (registratie van) een nationaliteit is beëindigd en daarna weer wordt opgenomen, worden beide periodes dat de nationaliteit geldig was opgenomen.

    Scenario: verlies Nederlanderschap verwerkt als actualisering vreemde nationaliteit met een nieuwe datum geldigheid
      Gegeven de persoon met burgerservicenummer '000000334' heeft een 'nationaliteit' met de volgende gegevens
      | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
      | 0131                  | 301                   | 20010319                        |
      En de 'nationaliteit' is gewijzigd met de volgende gegevens
      | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | datum ingang geldigheid (85.10) |
      |                       |                       | 404                      | 20190516                        |
      En de 'nationaliteit' is vervolgens gewijzigd met de volgende gegevens
      | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | datum ingang geldigheid (85.10) |
      | 0131                  | 301                   |                          | 20210604                        |
      En de persoon met burgerservicenummer '000000334' heeft een 'nationaliteit' met de volgende gegevens
      | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | datum ingang geldigheid (85.10) |
      | 0001                  | 017                   |                          | 20190516                        |
      En de 'nationaliteit' is gewijzigd met de volgende gegevens
      | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | datum ingang geldigheid (85.10) |
      |                       |                       | 192                      | 20210604                        |
      Als nationaliteithistorie wordt geraadpleegd met de volgende parameters
      | naam                | waarde                                                                                                                                                                   |
      | type                | RaadpleegMetPeriode                                                                                                                                                      |
      | burgerservicenummer | 000000334                                                                                                                                                                |
      | datumVan            | 2019-01-01                                                                                                                                                               |
      | datumTot            | 2022-01-01                                                                                                                                                               |
      | fields              | nationaliteiten.nationaliteit.code, nationaliteiten.redenOpname.code,nationaliteiten.redenBeeindigen.code,nationaliteiten.datumIngangGeldigheid,nationaliteiten.datumTot |
      Dan heeft de response de volgende 'nationaliteiten'
      | type          | nationaliteit.code | redenOpname.code | redenBeeindigen.code | datumIngangGeldigheid.type | datumIngangGeldigheid.datum | datumIngangGeldigheid.langFormaat | datumTot.type | datumTot.datum | datumTot.langFormaat |
      | Nationaliteit | 0131               | 301              |                      | Datum                      | 2021-06-04                  | 4 juni 2021                       |               |                |                      |
      | Nationaliteit | 0001               | 017              | 192                  | Datum                      | 2019-05-16                  | 16 mei 2019                       | Datum         | 2021-06-04     | 4 juni 2021          |
      | Nationaliteit | 0131               | 301              | 404                  | Datum                      | 2001-03-19                  | 19 maart 2001                     | Datum         | 2019-05-16     | 16 mei 2019          |

    Scenario: verlies Nederlanderschap verwerkt als correctieprocedure
      Gegeven de persoon met burgerservicenummer '000000346' heeft een 'nationaliteit' met de volgende gegevens
      | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
      | 0131                  | 301                   | 20010319                        |
      En de 'nationaliteit' is gewijzigd met de volgende gegevens
      | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | datum ingang geldigheid (85.10) |
      |                       |                       | 404                      | 20190516                        |
      En de vorige wijziging  van 'nationaliteit' is onjuist en gecorrigeerd met de volgende gegevens
      | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | datum ingang geldigheid (85.10) |
      | 0131                  | 301                   |                          | 20010319                        |
      En de persoon met burgerservicenummer '000000346' heeft een 'nationaliteit' met de volgende gegevens
      | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
      | 0001                  | 017                   | 20190516                        |
      En de 'nationaliteit' is gewijzigd met de volgende gegevens
      | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | datum ingang geldigheid (85.10) |
      |                       |                       | 192                      | 20210604                        |
      Als nationaliteithistorie wordt geraadpleegd met de volgende parameters
      | naam                | waarde                                                                                             |
      | type                | RaadpleegMetPeriode                                                                                |
      | burgerservicenummer | 000000346                                                                                          |
      | datumVan            | 2021-01-01                                                                                         |
      | datumTot            | 2022-01-01                                                                                         |
      | fields              | nationaliteiten.nationaliteit.code, nationaliteiten.datumIngangGeldigheid,nationaliteiten.datumTot |
      Dan heeft de response de volgende 'nationaliteiten'
      | type          | nationaliteit.code | datumIngangGeldigheid.type | datumIngangGeldigheid.datum | datumIngangGeldigheid.langFormaat | datumTot.type | datumTot.datum | datumTot.langFormaat |
      | Nationaliteit | 0131               | Datum                      | 2001-03-19                  | 19 maart 2001                     |               |                |                      |
      | Nationaliteit | 0001               | Datum                      | 2019-05-16                  | 16 mei 2019                       | Datum         | 2021-06-04     | 4 juni 2021          |

    Scenario: correctie van ingangsdatum van nationaliteit levert niet twee nationaliteiten op in het antwoord
      Gegeven de persoon met burgerservicenummer '000000358' heeft een 'nationaliteit' met de volgende gegevens
      | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
      | 0131                  | 301                   | 20210301                        |
      En de vorige wijziging  van 'nationaliteit' is onjuist en gecorrigeerd met de volgende gegevens
      | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
      | 0131                  | 301                   | 20210319                        |
      Als nationaliteithistorie wordt geraadpleegd met de volgende parameters
      | naam                | waarde                                                                                             |
      | type                | RaadpleegMetPeriode                                                                                |
      | burgerservicenummer | 000000358                                                                                          |
      | datumVan            | 2019-01-01                                                                                         |
      | datumTot            | 2022-01-01                                                                                         |
      | fields              | nationaliteiten.nationaliteit.code, nationaliteiten.datumIngangGeldigheid,nationaliteiten.datumTot |
      Dan heeft de response de volgende 'nationaliteiten'
      | type          | nationaliteit.code | datumIngangGeldigheid.type | datumIngangGeldigheid.datum | datumIngangGeldigheid.langFormaat |
      | Nationaliteit | 0131               | Datum                      | 2021-03-19                  | 19 maart 2021                     |
