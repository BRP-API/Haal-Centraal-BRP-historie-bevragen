# language: nl

Functionaliteit: Lever de juiste gegevens over een nationaliteit

  Als consumer van de BRP
  Wil ik de nationaliteiten van een persoon met alle geldige gegevens

  In de bron worden gegevens over een nationaliteit of bijzonder Nederlanderschap opgeslagen in één categorievoorkomen met de actuele gegevens (categorie 4) en optioneel in een of meerdere categorievoorkomens met "historische" gegevens (categorie 54).

  Voor een nationaliteit die is beëindigd, is de "actuele" situatie dat er geen nationaliteit meer is, waardoor de gegevens over die (beëindigde) nationaliteit niet "actueel" zijn en dus in historische categorievoorkomen(s) staan.
  Alleen gegevens over het beëindigen van de nationaliteit staan dan in het "actuele" categorievoorkomen.

  Daar waar in onderstaande scenario's in de Gegeven stap de tabel meer dan 1 rij waarden bevat, staat de meest actuele bovenaan en de oudste status onderaan.

 
  Rule: Voor een beëindigde nationaliteit of beëindigd bijzonder Nederlanderschap wordt de redenBeeindigen overgenomen uit de actuele categorie (04).

    Scenario: persoon heeft een beëindigde nationaliteit met gecorrigeerde reden beëindigen
      Gegeven de persoon met burgerservicenummer '999994657' heeft een 'nationaliteit' met de volgende gegevens
      | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | datum ingang geldigheid (85.10) |
      |                       |                       | 404                      | 20140601                        |
      |                       |                       | 401                      | 19940601                        |
      | 0100                  | 301                   |                          | 19890301                        |
      Als nationaliteithistorie wordt geraadpleegd met de volgende parameters
      | naam                | waarde                                                                  |
      | type                | RaadpleegMetPeriode                                                     |
      | burgerservicenummer | 999994657                                                               |
      | peildatum           | 2000-01-01                                                              |
      | fields              | nationaliteiten.nationaliteit.code,nationaliteiten.redenBeeindigen.code |
      Dan heeft de response de volgende 'nationaliteiten'
      | type          | nationaliteit.code | redenBeeindigen.code |
      | Nationaliteit | 0100               | 404                  |
