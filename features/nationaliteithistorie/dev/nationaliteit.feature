# language: nl

Functionaliteit: Lever de juiste gegevens over een nationaliteit

  Als consumer van de BRP
  Wil ik de nationaliteiten van een persoon met alle geldige gegevens

  In de bron worden gegevens over een nationaliteit of bijzonder Nederlanderschap opgeslagen in één categorievoorkomen met de actuele gegevens (categorie 4) en optioneel in een of meerdere categorievoorkomens met "historische" gegevens (categorie 54).

  Voor een nationaliteit die is beëindigd, is de "actuele" situatie dat er geen nationaliteit meer is, waardoor de gegevens over die (beëindigde) nationaliteit niet "actueel" zijn en dus in historische categorievoorkomen(s) staan.
  Alleen gegevens over het beëindigen van de nationaliteit staan dan in het "actuele" categorievoorkomen.

  Daar waar in onderstaande scenario's in de Gegeven stap de tabel meer dan 1 rij waarden bevat, staat de meest actuele bovenaan en de oudste status onderaan.

  Rule: Voor een niet-beëindigde nationaliteit wordt de nationaliteit gevuld met de nationaliteit (05.10) in de actuele categorie (04).
    - een nationaliteit is niet beëindigd wanneer reden beëindigen (64.10) leeg is of geen waarde heeft.

    Scenario: persoon heeft een niet-beëindigde nationaliteit
      Gegeven de persoon met burgerservicenummer '000000097' heeft een 'nationaliteit' met de volgende gegevens
      | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
      | 0001                  | 001                   | 19750707                        |
      Als nationaliteithistorie wordt geraadpleegd met de volgende parameters
      | naam                | waarde                                                                                                    |
      | type                | RaadpleegMetPeildatum                                                                                     |
      | burgerservicenummer | 000000097                                                                                                 |
      | peildatum           | 2022-08-16                                                                                                |
      | fields              | nationaliteiten.nationaliteit.code |
      Dan heeft de response de volgende 'nationaliteiten'
      | type          | nationaliteit.code |
      | Nationaliteit | 0001               |


  Rule: Voor een beëindigde nationaliteit wordt nationaliteit overgenomen uit de jongste bijbehorende historische categorie (54) waarin deze voorkomt en die niet onjuist is.
    
    Scenario: persoon heeft een beëindigde nationaliteit
      Gegeven de persoon met burgerservicenummer '000000103' heeft een 'nationaliteit' met de volgende gegevens
      | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
      | 0131                  | 301                   | 19750501                        |
      En de 'nationaliteit' is gewijzigd met de volgende gegevens
      | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | datum ingang geldigheid (85.10) |
      |                       |                       | 404                      | 20220131                        |
      Als nationaliteithistorie wordt geraadpleegd met de volgende parameters
      | naam                | waarde                             |
      | type                | RaadpleegMetPeriode                |
      | burgerservicenummer | 000000103                          |
      | peildatum           | 2022-01-01                         |
      | fields              | nationaliteiten.nationaliteit.code |
      Dan heeft de response de volgende 'nationaliteiten'
      | type          | nationaliteit.code |
      | Nationaliteit | 0131               |

    Scenario: persoon heeft een beëindigde nationaliteit met gecorrigeerde reden beëindigen
      Gegeven de persoon met burgerservicenummer '000000115' heeft een 'nationaliteit' met de volgende gegevens
      | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | datum ingang geldigheid (85.10) |
      | 0100                  | 301                   |                          | 19890301                        |
      En de 'nationaliteit' is gewijzigd met de volgende gegevens
      | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | datum ingang geldigheid (85.10) |
      |                       |                       | 401                      | 20220601                        |
      En de 'nationaliteit' is vervolgens gewijzigd met de volgende gegevens
      | reden beëindigen (64.10) | datum ingang geldigheid (85.10) |
      | 404                      | 20220601                        |
      Als nationaliteithistorie wordt geraadpleegd met de volgende parameters
      | naam                | waarde                             |
      | type                | RaadpleegMetPeriode                |
      | burgerservicenummer | 000000115                          |
      | peildatum           | 2022-01-01                         |
      | fields              | nationaliteiten.nationaliteit.code |
      Dan heeft de response de volgende 'nationaliteiten'
      | type          | nationaliteit.code |
      | Nationaliteit | 0100               |

    Scenario: persoon heeft een beëindigde nationaliteit met gecorrigeerde nationaliteit
      Gegeven de persoon met burgerservicenummer '000000127' heeft een 'nationaliteit' met de volgende gegevens
      | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
      | 0400                  | 301                   | 20170401                        |
      En de 'nationaliteit' is gewijzigd met de volgende gegevens
      | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
      | 0071                  | 301                   | 20170401                        |
      En de 'nationaliteit' is vervolgens gewijzigd met de volgende gegevens
      | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | datum ingang geldigheid (85.10) |
      |                       |                       | 404                      | 20200305                        |
      Als nationaliteithistorie wordt geraadpleegd met de volgende parameters
      | naam                | waarde                             |
      | type                | RaadpleegMetPeriode                |
      | burgerservicenummer | 000000127                          |
      | peildatum           | 2000-01-01                         |
      | fields              | nationaliteiten.nationaliteit.code |
      Dan heeft de response de volgende 'nationaliteiten'
      | type          | nationaliteit.code |
      | Nationaliteit | 0071               |
