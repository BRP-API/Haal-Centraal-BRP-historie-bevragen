# language: nl

Functionaliteit: Lever het juiste type van een nationaliteit

  Als consumer van de BRP
  Wil ik de nationaliteiten van een persoon met alle geldige gegevens

  In de bron worden gegevens over een nationaliteit of bijzonder Nederlanderschap opgeslagen in één categorievoorkomen met de actuele gegevens (categorie 4) en optioneel in een of meerdere categorievoorkomens met "historische" gegevens (categorie 54).

  Voor een nationaliteit die is beëindigd, is de "actuele" situatie dat er geen nationaliteit meer is, waardoor de gegevens over die (beëindigde) nationaliteit niet "actueel" zijn en dus in historische categorievoorkomen(s) staan.
  Alleen gegevens over het beëindigen van de nationaliteit staan dan in het "actuele" categorievoorkomen.

  Daar waar in onderstaande scenario's in de Gegeven stap de tabel meer dan 1 rij waarden bevat, staat de meest actuele bovenaan en de oudste status onderaan.

  Rule: de type wordt gevuld op basis van het voorkomen van nationaliteit of aanduidingBijzonderNederlanderschap
    - wanneer nationaliteit voorkomt met een waarde gelijk aan "0000" (onbekend), dan wordt type opgenomen met de waarde "NationaliteitOnbekend"
    - wanneer nationaliteit voorkomt met een waarde gelijk aan "0002", dan wordt type opgenomen met de waarde "BehandeldAlsNederlander"
    - wanneer nationaliteit voorkomt met een waarde gelijk aan "0499", dan wordt type opgenomen met de waarde "Staatloos"
    - wanneer nationaliteit voorkomt met een waarde gelijk aan "0500", dan wordt type opgenomen met de waarde "VastgesteldNietNederlander"
    - wanneer nationaliteit voorkomt met een waarde ongelijk aan "0000", "0002", "0499" of "0500", dan wordt type opgenomen met de waarde "Nationaliteit"
    - wanneer aanduidingBijzonderNederlanderschap voorkomt met een waarde gelijk aan "B", dan wordt type opgenomen met de waarde "BehandeldAlsNederlander"
    - wanneer aanduidingBijzonderNederlanderschap voorkomt met een waarde gelijk aan "V", dan wordt type opgenomen met de waarde "VastgesteldNietNederlander"
    - het veld "nationaliteit" wordt alleen opgenomen bij type "Nationaliteit"

    Scenario: de persoon heeft de Nederlandse nationaliteit
      Gegeven de persoon met burgerservicenummer '000009830' heeft een 'nationaliteit' met de volgende gegevens
      | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
      | 0001                  | 001                   | 19750707                        |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde               |
      | type                | RaadpleegMetPeriode  |
      | burgerservicenummer | 000009830            |
      | peildatum           | 2022-08-01           |
      | fields              | nationaliteiten.type |
      Dan heeft de response de volgende 'nationaliteiten'
      | type          |
      | Nationaliteit |

    Scenario: de persoon heeft een vreemde nationaliteit
      Gegeven de persoon met burgerservicenummer '999993045' heeft een 'nationaliteit' met de volgende gegevens
      | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
      | 0263                  | 301                   | 00000000                        |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde               |
      | type                | RaadpleegMetPeriode  |
      | burgerservicenummer | 999993045            |
      | peildatum           | 2022-08-01           |
      | fields              | nationaliteiten.type |
      Dan heeft de response de volgende 'nationaliteiten'
      | type          |
      | Nationaliteit |

    Scenario: de persoon is staatloos
      Gegeven de persoon met burgerservicenummer '999991188' heeft een 'nationaliteit' met de volgende gegevens
      | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
      | 0499                  | 312                   | 20040201                        |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde               |
      | type                | RaadpleegMetPeriode  |
      | burgerservicenummer | 999991188            |
      | peildatum           | 2022-08-01           |
      | fields              | nationaliteiten.type |
      Dan heeft de response de volgende 'nationaliteiten'
      | type      |
      | Staatloos |

    Scenario: de persoon heeft een onbekende nationaliteit
      Gegeven de persoon met burgerservicenummer '999993367' heeft een 'nationaliteit' met de volgende gegevens
      | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
      | 0000                  | 311                   | 00000000                        |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde               |
      | type                | RaadpleegMetPeriode  |
      | burgerservicenummer | 999993367            |
      | peildatum           | 2022-08-01           |
      | fields              | nationaliteiten.type |
      Dan heeft de response de volgende 'nationaliteiten'
      | type                  |
      | NationaliteitOnbekend |

    Scenario: de persoon wordt behandeld als Nederlander
      Gegeven de persoon met burgerservicenummer '000009866' heeft een 'nationaliteit' met de volgende gegevens
      | bijzonder Nederlanderschap (65.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
      | B                                  | 310                   | 19570115                        |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde               |
      | type                | RaadpleegMetPeriode  |
      | burgerservicenummer | 000009866            |
      | peildatum           | 2022-08-01           |
      | fields              | nationaliteiten.type |
      Dan heeft de response de volgende 'nationaliteiten'
      | type                    |
      | BehandeldAlsNederlander |

    Scenario: de persoon wordt behandeld als Nederlander, nationaliteit heeft code 0002
      Gegeven de persoon met burgerservicenummer '555550001' heeft een 'nationaliteit' met de volgende gegevens
      | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
      | 0002                  | 310                   | 19530614                        |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde               |
      | type                | RaadpleegMetPeriode  |
      | burgerservicenummer | 555550001            |
      | peildatum           | 2022-08-01           |
      | fields              | nationaliteiten.type |
      Dan heeft de response de volgende 'nationaliteiten'
      | type                    |
      | BehandeldAlsNederlander |

    Scenario: de persoon is vastgesteld niet-Nederlander
      Gegeven de persoon met burgerservicenummer '999994748' heeft een 'nationaliteit' met de volgende gegevens
      | bijzonder Nederlanderschap (65.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
      | V                                  | 310                   | 19750615                        |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde               |
      | type                | RaadpleegMetPeriode  |
      | burgerservicenummer | 999994748            |
      | peildatum           | 2022-08-01           |
      | fields              | nationaliteiten.type |
      Dan heeft de response de volgende 'nationaliteiten'
      | type                       |
      | VastgesteldNietNederlander |

    Scenario: de persoon is vastgesteld niet-Nederlander, nationaliteit heeft code 0500
      Gegeven de persoon met burgerservicenummer '555550002' heeft een 'nationaliteit' met de volgende gegevens
      | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
      | 0500                  | 310                   | 19861102                        |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550002                       |
      | fields              | nationaliteiten                 |
      Dan heeft de response de volgende 'nationaliteiten'
      | type                       |
      | VastgesteldNietNederlander |

  
  Rule: Voor een beëindigde nationaliteit of beëindigd bijzonder Nederlanderschap wordt type bepaald op de waarde voor nationaliteit en aanduidingBijzonderNederlanderschap uit de jongste bijbehorende historische categorie (54) waarin deze voorkomen en die niet onjuist is.
    
    Scenario: persoon heeft een beëindigde nationaliteit
      Gegeven de persoon met burgerservicenummer '999993008' heeft een 'nationaliteit' met de volgende gegevens
      | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | datum ingang geldigheid (85.10) |
      |                       |                       | 404                      | 20050131                        |
      | 0131                  | 301                   |                          | 19750501                        |
      Als nationaliteithistorie wordt geraadpleegd met de volgende parameters
      | naam                | waarde               |
      | type                | RaadpleegMetPeriode  |
      | burgerservicenummer | 999993008            |
      | peildatum           | 2000-01-01           |
      | fields              | nationaliteiten.type |
      Dan heeft de response de volgende 'nationaliteiten'
      | type |
      | Nationaliteit |

    Scenario: verlies bijzonder Nederlanderschap
      Gegeven de persoon met burgerservicenummer '555550003' heeft een 'nationaliteit' met de volgende gegevens
      | bijzonder Nederlanderschap (65.10) | reden opnemen (63.10) | reden beëindigen (64.10) | datum ingang geldigheid (85.10) |
      |                                    |                       | 410                      | 20190604                        |
      | B                                  | 310                   |                          | 20010319                        |
      Als nationaliteithistorie wordt geraadpleegd met de volgende parameters
      | naam                | waarde               |
      | type                | RaadpleegMetPeriode  |
      | burgerservicenummer | 555550003            |
      | peildatum           | 2018-01-01           |
      | fields              | nationaliteiten.type |
      Dan heeft de response de volgende 'nationaliteiten'
      | type                    |
      | BehandeldAlsNederlander |

    Scenario: persoon heeft een beëindigde nationaliteit met gecorrigeerde reden beëindigen
      Gegeven de persoon met burgerservicenummer '999994657' heeft een 'nationaliteit' met de volgende gegevens
      | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | datum ingang geldigheid (85.10) |
      |                       |                       | 404                      | 20140601                        |
      |                       |                       | 401                      | 19940601                        |
      | 0100                  | 301                   |                          | 19890301                        |
      Als nationaliteithistorie wordt geraadpleegd met de volgende parameters
      | naam                | waarde               |
      | type                | RaadpleegMetPeriode  |
      | burgerservicenummer | 999994657            |
      | peildatum           | 2000-01-01           |
      | fields              | nationaliteiten.type |
      Dan heeft de response de volgende 'nationaliteiten'
      | type          |
      | Nationaliteit |
