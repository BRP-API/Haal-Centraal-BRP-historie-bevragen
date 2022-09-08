# language: nl

Functionaliteit: Lever de reden dat een nationaliteit is beëindigd

  Als consumer van de BRP
  Wil ik de nationaliteiten van een persoon met alle geldige gegevens

  In de bron worden gegevens over een nationaliteit of bijzonder Nederlanderschap opgeslagen in één categorievoorkomen met de actuele gegevens (categorie 4) en optioneel in een of meerdere categorievoorkomens met "historische" gegevens (categorie 54).

  Voor een nationaliteit die is beëindigd, is de "actuele" situatie dat er geen nationaliteit meer is, waardoor de gegevens over die (beëindigde) nationaliteit niet "actueel" zijn en dus in historische categorievoorkomen(s) staan.
  Alleen gegevens over het beëindigen van de nationaliteit staan dan in het "actuele" categorievoorkomen.

  Daar waar in onderstaande scenario's in de Gegeven stap de tabel meer dan 1 rij waarden bevat, staat de meest actuele bovenaan en de oudste status onderaan.

 
  Rule: Voor een beëindigde nationaliteit of beëindigd bijzonder Nederlanderschap wordt de redenBeeindigen overgenomen uit de actuele categorie (04).

    Scenario: persoon heeft een beëindigde nationaliteit met gecorrigeerde reden beëindigen
      Gegeven de persoon met burgerservicenummer '000000139' heeft een 'nationaliteit' met de volgende gegevens
      | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
      | 0100                  | 301                   | 19890301                        |
      En de 'nationaliteit' is gewijzigd naar de volgende gegevens
      | reden beëindigen (64.10) | datum ingang geldigheid (85.10) |
      | 401                      | 20220601                        |
      En de 'nationaliteit' is vervolgens gewijzigd naar de volgende gegevens
      | reden beëindigen (64.10) | datum ingang geldigheid (85.10) |
      | 404                      | 20220601                        |
      Als nationaliteithistorie wordt geraadpleegd met de volgende parameters
      | naam                | waarde                               |
      | type                | RaadpleegMetPeriode                  |
      | burgerservicenummer | 000000139                            |
      | datumVan            | 2022-01-01                           |
      | datumTot            | 2022-07-01                           |
      | fields              | nationaliteiten.redenBeeindigen.code |
      Dan heeft de response de volgende 'nationaliteiten'
      | type          | redenBeeindigen.code |
      | Nationaliteit | 404                  |


  Rule: redenBeeindigen wordt alleen geleverd wanneer deze valt binnen de gevraagde periode
  
    Scenario: persoon met een beëindigde nationaliteit raadplegen op peildatum voor de ingangsdatum van beëindigen
      Gegeven de persoon met burgerservicenummer '000000450' heeft een 'nationaliteit' met de volgende gegevens
      | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
      | 0100                  | 301                   | 20011014                        |
      En de 'nationaliteit' is gewijzigd naar de volgende gegevens
      | reden beëindigen (64.10) | datum ingang geldigheid (85.10) |
      | 401                      | 20220526                        |
      Als nationaliteithistorie wordt geraadpleegd met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetPeildatum           |
      | burgerservicenummer | 000000450                       |
      | peildatum           | 2022-01-01                      |
      | fields              | nationaliteiten.redenBeeindigen |
      Dan heeft de response de volgende 'nationaliteiten'
      | type          |
      | Nationaliteit |

    Abstract Scenario: persoon met een beëindigde nationaliteit raadplegen met <omschrijving>
      Gegeven de persoon met burgerservicenummer '000000450' heeft een 'nationaliteit' met de volgende gegevens
      | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
      | 0100                  | 301                   | 20011014                        |
      En de 'nationaliteit' is gewijzigd naar de volgende gegevens
      | reden beëindigen (64.10) | datum ingang geldigheid (85.10) |
      | 401                      | 20220526                        |
      Als nationaliteithistorie wordt geraadpleegd met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetPeriode             |
      | burgerservicenummer | 000000450                       |
      | datumVan            | 2022-01-01                      |
      | datumTot            | <datumTot>                      |
      | fields              | nationaliteiten.redenBeeindigen |
      Dan heeft de response de volgende 'nationaliteiten'
      | type          |
      | Nationaliteit |

      Voorbeelden:
      | omschrijving                                   | datumTot   |
      | periode voor ingangsdatum van beëindigen       | 2022-05-01 |
      | periode eindigt op ingangsdatum van beëindigen | 2022-05-26 |

    Abstract Scenario: persoon met een beëindigde nationaliteit raadplegen met <omschrijving>
      Gegeven de persoon met burgerservicenummer '000000450' heeft een 'nationaliteit' met de volgende gegevens
      | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
      | 0100                  | 301                   | 20011014                        |
      En de 'nationaliteit' is gewijzigd naar de volgende gegevens
      | reden beëindigen (64.10) | datum ingang geldigheid (85.10) |
      | 401                      | 20220526                        |
      Als nationaliteithistorie wordt geraadpleegd met de volgende parameters
      | naam                | waarde                               |
      | type                | RaadpleegMetPeriode                  |
      | burgerservicenummer | 000000450                            |
      | datumVan            | 2022-01-01                           |
      | datumTot            | <datumTot>                           |
      | fields              | nationaliteiten.redenBeeindigen.code |
      Dan heeft de response de volgende 'nationaliteiten'
      | type          | redenBeeindigen.code |
      | Nationaliteit | 401                  |

      Voorbeelden:
      | omschrijving                                       | datumTot   |
      | periode loopt over ingangsdatum van beëindigen     | 2022-08-01 |
      | periode eindigt dag na ingangsdatum van beëindigen | 2022-05-27 |
