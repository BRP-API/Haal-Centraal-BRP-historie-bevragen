# language: nl

Functionaliteit: Lever de juiste datum ingang geldigheid van een nationaliteit

  Als consumer van de BRP
  Wil ik de nationaliteiten van een persoon met alle geldige gegevens

  In de bron worden gegevens over een nationaliteit of bijzonder Nederlanderschap opgeslagen in één categorievoorkomen met de actuele gegevens (categorie 4) en optioneel in een of meerdere categorievoorkomens met "historische" gegevens (categorie 54).

  Voor een nationaliteit die is beëindigd, is de "actuele" situatie dat er geen nationaliteit meer is, waardoor de gegevens over die (beëindigde) nationaliteit niet "actueel" zijn en dus in historische categorievoorkomen(s) staan.
  Alleen gegevens over het beëindigen van de nationaliteit staan dan in het "actuele" categorievoorkomen.

  Rule: Voor een niet-beëindigde nationaliteit of bijzonder Nederlanderschap wordt de datumIngangGeldigheid gevuld met de datum geldigheid (85.10) in de actuele categorie (04).
    - een nationaliteit of bijzonder Nederlanderschap is niet beëindigd wanneer reden beëindigen (64.10) leeg is of geen waarde heeft.

    Scenario: persoon heeft een niet-beëindigde nationaliteit
      Gegeven de persoon met burgerservicenummer '000009830' heeft een 'nationaliteit' met de volgende gegevens
      | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
      | 0001                  | 001                   | 19750707                        |
      Als nationaliteithistorie wordt geraadpleegd met de volgende parameters
      | naam                | waarde                                |
      | type                | RaadpleegMetPeildatum                 |
      | burgerservicenummer | 000009830                             |
      | peildatum           | 2022-08-16                            |
      | fields              | nationaliteiten.datumIngangGeldigheid |
      Dan heeft de response de volgende 'nationaliteiten'
      | type          | datumIngangGeldigheid.type | datumIngangGeldigheid.datum | datumIngangGeldigheid.langFormaat |
      | Nationaliteit | Datum                      | 1975-07-07                  | 7 juli 1975                       |


  Rule: Voor een beëindigde nationaliteit of beëindigd bijzonder Nederlanderschap wordt datumIngangGeldigheid overgenomen uit de jongste bijbehorende historische categorie (54) waarin deze voorkomt en die niet onjuist is.
    
    Scenario: persoon heeft een beëindigde nationaliteit
      Gegeven de persoon met burgerservicenummer '999993008' heeft een 'nationaliteit' met de volgende gegevens
      | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | datum ingang geldigheid (85.10) |
      |                       |                       | 404                      | 20050131                        |
      | 0131                  | 301                   |                          | 19750501                        |
      Als nationaliteithistorie wordt geraadpleegd met de volgende parameters
      | naam                | waarde                                |
      | type                | RaadpleegMetPeriode                   |
      | burgerservicenummer | 999993008                             |
      | peildatum           | 2000-01-01                            |
      | fields              | nationaliteiten.datumIngangGeldigheid |
      Dan heeft de response de volgende 'nationaliteiten'
      | type          | datumIngangGeldigheid.type | datumIngangGeldigheid.datum | datumIngangGeldigheid.langFormaat |
      | Nationaliteit | Datum                      | 1975-05-01                  | 1 mei 1975                        |

    Scenario: verlies bijzonder Nederlanderschap
      Gegeven de persoon met burgerservicenummer '555550001' heeft een 'nationaliteit' met de volgende gegevens
      | bijzonder Nederlanderschap (65.10) | reden opnemen (63.10) | reden beëindigen (64.10) | datum ingang geldigheid (85.10) |
      |                                    |                       | 410                      | 20190604                        |
      | B                                  | 310                   |                          | 20010319                        |
      Als nationaliteithistorie wordt geraadpleegd met de volgende parameters
      | naam                | waarde                                |
      | type                | RaadpleegMetPeriode                   |
      | burgerservicenummer | 555550001                             |
      | peildatum           | 2018-01-01                            |
      | fields              | nationaliteiten.datumIngangGeldigheid |
      Dan heeft de response de volgende 'nationaliteiten'
      | type                    | datumIngangGeldigheid.type | datumIngangGeldigheid.datum | datumIngangGeldigheid.langFormaat |
      | BehandeldAlsNederlander | Datum                      | 2001-03-19                  | 19 maart 2001                     |

    Scenario: persoon heeft een beëindigde nationaliteit met gecorrigeerde reden beëindigen
      Gegeven de persoon met burgerservicenummer '999994657' heeft een 'nationaliteit' met de volgende gegevens
      | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | datum ingang geldigheid (85.10) |
      |                       |                       | 404                      | 20140601                        |
      |                       |                       | 401                      | 19940601                        |
      | 0100                  | 301                   |                          | 19890301                        |
      Als nationaliteithistorie wordt geraadpleegd met de volgende parameters
      | naam                | waarde                                |
      | type                | RaadpleegMetPeriode                   |
      | burgerservicenummer | 999994657                             |
      | peildatum           | 2000-01-01                            |
      | fields              | nationaliteiten.datumIngangGeldigheid |
      Dan heeft de response de volgende 'nationaliteiten'
      | type          | datumIngangGeldigheid.type | datumIngangGeldigheid.datum | datumIngangGeldigheid.langFormaat |
      | Nationaliteit | Datum                      | 1975-05-01                  | 1 mei 1975                        |

    Scenario: persoon heeft een beëindigde nationaliteit met gecorrigeerde ingangsdatum geldigheid
      Gegeven de persoon met burgerservicenummer '555550002' heeft een 'nationaliteit' met de volgende gegevens
      | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | datum ingang geldigheid (85.10) |
      |                       |                       | 404                      | 20200305                        |
      | 0400                  | 301                   |                          | 20170415                        |
      | 0400                  | 301                   |                          | 20170401                        |
      Als nationaliteithistorie wordt geraadpleegd met de volgende parameters
      | naam                | waarde                                |
      | type                | RaadpleegMetPeriode                   |
      | burgerservicenummer | 555550002                             |
      | peildatum           | 2000-01-01                            |
      | fields              | nationaliteiten.datumIngangGeldigheid |
      Dan heeft de response de volgende 'nationaliteiten'
      | type          | datumIngangGeldigheid.type | datumIngangGeldigheid.datum | datumIngangGeldigheid.langFormaat |
      | Nationaliteit | Datum                      | 2017-04-15                  | 15 april 2017                     |
