# language: nl

Functionaliteit: Lever de juiste datumTot van een beëindigde nationaliteit

  Als consumer van de BRP
  Wil ik de nationaliteiten van een persoon met alle geldige gegevens

  In de bron worden gegevens over een nationaliteit of bijzonder Nederlanderschap opgeslagen in één categorievoorkomen met de actuele gegevens (categorie 4) en optioneel in een of meerdere categorievoorkomens met "historische" gegevens (categorie 54).

  Voor een nationaliteit die is beëindigd, is de "actuele" situatie dat er geen nationaliteit meer is, waardoor de gegevens over die (beëindigde) nationaliteit niet "actueel" zijn en dus in historische categorievoorkomen(s) staan.
  Alleen gegevens over het beëindigen van de nationaliteit staan dan in het "actuele" categorievoorkomen.

 
  Rule: Voor een niet-beëindigde nationaliteit of bijzonder Nederlanderschap wordt de datumTot niet opgenomen in het antwoord.
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
      | fields              | nationaliteiten.datumTot |
      Dan heeft de response de volgende 'nationaliteiten'
      | type          |
      | Nationaliteit |


  Rule: Voor een beëindigde nationaliteit wordt datumTot gevuld met de datum geldigheid (85.10) uit de actuele categorie (04).
    - een nationaliteit of bijzonder Nederlanderschap is beëindigd wanneer reden beëindigen (64.10) een waarde heeft.

    Scenario: persoon heeft een beëindigde nationaliteit met gecorrigeerde reden beëindigen
      Gegeven de persoon met burgerservicenummer '999994657' heeft een 'nationaliteit' met de volgende gegevens
      | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | datum ingang geldigheid (85.10) |
      |                       |                       | 404                      | 20140601                        |
      |                       |                       | 401                      | 19940601                        |
      | 0100                  | 301                   |                          | 19890301                        |
      Als nationaliteithistorie wordt geraadpleegd met de volgende parameters
      | naam                | waarde                                                      |
      | type                | RaadpleegMetPeriode                                         |
      | burgerservicenummer | 999994657                                                   |
      | peildatum           | 2000-01-01                                                  |
      | fields              | nationaliteiten.nationaliteit.code,nationaliteiten.datumTot |
      Dan heeft de response de volgende 'nationaliteiten'
      | type          | nationaliteit.code | datumTot.type | datumTot.datum | datumTot.langFormaat |
      | Nationaliteit | 0100               | Datum         | 2014-06-01     | 1 juni 2014          |
