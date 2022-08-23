# language: nl

Functionaliteit: Lever de juiste reden opname van een nationaliteit

  Als consumer van de BRP
  Wil ik de nationaliteiten van een persoon met alle geldige gegevens

  In de bron worden gegevens over een nationaliteit of bijzonder Nederlanderschap opgeslagen in één categorievoorkomen met de actuele gegevens (categorie 4) en optioneel in een of meerdere categorievoorkomens met "historische" gegevens (categorie 54).

  Voor een nationaliteit die is beëindigd, is de "actuele" situatie dat er geen nationaliteit meer is, waardoor de gegevens over die (beëindigde) nationaliteit niet "actueel" zijn en dus in historische categorievoorkomen(s) staan.
  Alleen gegevens over het beëindigen van de nationaliteit staan dan in het "actuele" categorievoorkomen.

  Daar waar in onderstaande scenario's in de Gegeven stap de tabel meer dan 1 rij waarden bevat, staat de meest actuele bovenaan en de oudste status onderaan.

  Rule: Voor een niet-beëindigde nationaliteit of bijzonder Nederlanderschap wordt de redenOpname gevuld met de reden opnemen (63.10) in de actuele categorie (04).
    - een nationaliteit of bijzonder Nederlanderschap is niet beëindigd wanneer reden beëindigen (64.10) leeg is of geen waarde heeft.

    Scenario: persoon heeft een niet-beëindigde nationaliteit
      Gegeven de persoon met burgerservicenummer '000000140' heeft een 'nationaliteit' met de volgende gegevens
      | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
      | 0001                  | 001                   | 19750707                        |
      Als nationaliteithistorie wordt geraadpleegd met de volgende parameters
      | naam                | waarde                           |
      | type                | RaadpleegMetPeildatum            |
      | burgerservicenummer | 000000140                        |
      | peildatum           | 2022-08-16                       |
      | fields              | nationaliteiten.redenOpname.code |
      Dan heeft de response de volgende 'nationaliteiten'
      | type          | redenOpname.code |
      | Nationaliteit | 001              |


  Rule: Voor een beëindigde nationaliteit of beëindigd bijzonder Nederlanderschap wordt redenOpname overgenomen uit de jongste bijbehorende historische categorie (54) waarin deze voorkomen en die niet onjuist is.
    
    Scenario: persoon heeft een beëindigde nationaliteit
      Gegeven de persoon met burgerservicenummer '000000152' heeft een 'nationaliteit' met de volgende gegevens
      | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | datum ingang geldigheid (85.10) |
      | 0131                  | 301                   |                          | 19750501                        |
      En de 'nationaliteit' is gewijzigd naar de volgende gegevens
      | reden beëindigen (64.10) | datum ingang geldigheid (85.10) |
      | 404                      | 20220131                        |
      Als nationaliteithistorie wordt geraadpleegd met de volgende parameters
      | naam                | waarde                           |
      | type                | RaadpleegMetPeildatum            |
      | burgerservicenummer | 000000152                        |
      | peildatum           | 2022-01-01                       |
      | fields              | nationaliteiten.redenOpname.code |
      Dan heeft de response de volgende 'nationaliteiten'
      | type          | redenOpname.code |
      | Nationaliteit | 301              |

    Scenario: verlies bijzonder Nederlanderschap
      Gegeven de persoon met burgerservicenummer '000000164' heeft een 'nationaliteit' met de volgende gegevens
      | bijzonder Nederlanderschap (65.10) | reden opnemen (63.10) | reden beëindigen (64.10) | datum ingang geldigheid (85.10) |
      | B                                  | 310                   |                          | 20180319                        |
      En de 'nationaliteit' is gewijzigd naar de volgende gegevens
      | reden beëindigen (64.10) | datum ingang geldigheid (85.10) |
      | 410                      | 20220604                        |
      Als nationaliteithistorie wordt geraadpleegd met de volgende parameters
      | naam                | waarde                                                                 |
      | type                | RaadpleegMetPeildatum                                                  |
      | burgerservicenummer | 000000164                                                              |
      | peildatum           | 2021-01-01                                                             |
      | fields              | nationaliteiten.redenOpname.code |
      Dan heeft de response de volgende 'nationaliteiten'
      | type                    | redenOpname.code |
      | BehandeldAlsNederlander | 310              |

    Scenario: persoon heeft een beëindigde nationaliteit met gecorrigeerde reden beëindigen
      Gegeven de persoon met burgerservicenummer '000000176' heeft een 'nationaliteit' met de volgende gegevens
      | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | datum ingang geldigheid (85.10) |
      | 0100                  | 301                   |                          | 19890301                        |
      En de 'nationaliteit' is gewijzigd naar de volgende gegevens
      | reden beëindigen (64.10) | datum ingang geldigheid (85.10) |
      | 401                      | 19940601                        |
      En de 'nationaliteit' is vervolgens gewijzigd naar de volgende gegevens
      | reden beëindigen (64.10) | datum ingang geldigheid (85.10) |
      | 404                      | 20140601                        |
      Als nationaliteithistorie wordt geraadpleegd met de volgende parameters
      | naam                | waarde                           |
      | type                | RaadpleegMetPeildatum            |
      | burgerservicenummer | 000000176                        |
      | peildatum           | 2000-01-01                       |
      | fields              | nationaliteiten.redenOpname.code |
      Dan heeft de response de volgende 'nationaliteiten'
      | type          | redenOpname.code |
      | Nationaliteit | 301              |

    Scenario: persoon heeft een beëindigde nationaliteit met gecorrigeerde reden opnemen
      Gegeven de persoon met burgerservicenummer '000000188' heeft een 'nationaliteit' met de volgende gegevens
      | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
      | 0001                  | 017                   | 20170401                        |
      En de 'nationaliteit' is gewijzigd naar de volgende gegevens
      | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
      | 0001                  | 032                   | 20170401                        |
      En de 'nationaliteit' is vervolgens gewijzigd naar de volgende gegevens
      | reden beëindigen (64.10) | datum ingang geldigheid (85.10) |
      | 191                      | 20220305                        |
      Als nationaliteithistorie wordt geraadpleegd met de volgende parameters
      | naam                | waarde                           |
      | type                | RaadpleegMetPeildatum            |
      | burgerservicenummer | 000000188                        |
      | peildatum           | 2022-01-01                       |
      | fields              | nationaliteiten.redenOpname.code |
      Dan heeft de response de volgende 'nationaliteiten'
      | type          | redenOpname.code |
      | Nationaliteit | 032              |


  Rule: Op basis van de reden opname wordt de bijbehorende omschrijving gehaald uit de tabel 'Reden_Nationaliteit' (Landelijke tabel 37)

    Abstract Scenario: persoon heeft reden opname "<reden opname code>"
      Gegeven landelijke tabel "Reden_Nationaliteit" heeft de volgende waarde
      | code                | omschrijving                |
      | <reden opname code> | <reden opname omschrijving> |
      En de persoon met burgerservicenummer '<burgerservicenummer>' heeft een 'nationaliteit' met de volgende gegevens
      | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
      | <nationaliteit code>  | <reden opname code>   | 20150426                        |
      Als nationaliteithistorie wordt geraadpleegd met de volgende parameters
      | naam                | waarde                      |
      | type                | RaadpleegMetPeildatum       |
      | burgerservicenummer | <burgerservicenummer>       |
      | peildatum           | 2022-08-16                  |
      | fields              | nationaliteiten.redenOpname |
      Dan heeft de response de volgende 'nationaliteiten'
      | type          | redenOpname.code    | redenOpname.omschrijving    |
      | Nationaliteit | <reden opname code> | <reden opname omschrijving> |

      Voorbeelden:
      | burgerservicenummer | nationaliteit code | reden opname code | reden opname omschrijving                                                        |
      | 000000401           | 0001               | 176               | Wijziging Rw. Nederl. Bep: Rw. 27-06-2008 art. II, lid 1, sub b (Stb. 2008, 270) |
      | 000000413           | 0001               | 100               | Toescheidingsovereenkomst Nederland-Indonesië, art. 3                            |
      | 000000425           | 0052               | 301               | Vaststelling bezit vreemde nationaliteit                                         |

    Scenario: bijzonder Nederlanderschap
      Gegeven landelijke tabel "Reden_Nationaliteit" heeft de volgende waarde
      | code | omschrijving                            |
      | 310  | Vaststelling bijzonder Nederlanderschap |
      En de persoon met burgerservicenummer '000000449' heeft een 'nationaliteit' met de volgende gegevens
      | bijzonder Nederlanderschap (65.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
      | B                                  | 310                   | 20180319                        |
      Als nationaliteithistorie wordt geraadpleegd met de volgende parameters
      | naam                | waarde                                                                 |
      | type                | RaadpleegMetPeildatum                                                  |
      | burgerservicenummer | 000000449                                                              |
      | peildatum           | 2021-01-01                                                             |
      | fields              | nationaliteiten.redenOpname |
      Dan heeft de response de volgende 'nationaliteiten'
      | type                    | redenOpname.code | redenOpname.omschrijving                |
      | BehandeldAlsNederlander | 310              | Vaststelling bijzonder Nederlanderschap |

    Scenario: de persoon heeft een onbekende nationaliteit
      Gegeven landelijke tabel "Reden_Nationaliteit" heeft de volgende waarde
      | code | omschrijving                            |
      | 311  | Vaststelling onbekende nationaliteit |
      En de persoon met burgerservicenummer '000000255' heeft een 'nationaliteit' met de volgende gegevens
      | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
      | 0000                  | 311                   | 19531104                        |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                      |
      | type                | RaadpleegMetPeildatum       |
      | burgerservicenummer | 000000255                   |
      | peildatum           | 2022-08-01                  |
      | fields              | nationaliteiten.redenOpname |
      Dan heeft de response de volgende 'nationaliteiten'
      | type                  | redenOpname.code | redenOpname.omschrijving             |
      | NationaliteitOnbekend | 311              | Vaststelling onbekende nationaliteit |
      
    Scenario: de persoon is staatloos
      Gegeven landelijke tabel "Reden_Nationaliteit" heeft de volgende waarde
      | code | omschrijving               |
      | 312  | Vaststelling staatloosheid |
      En de persoon met burgerservicenummer '000000243' heeft een 'nationaliteit' met de volgende gegevens
      | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
      | 0499                  | 312                   | 20040201                        |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                      |
      | type                | RaadpleegMetPeildatum       |
      | burgerservicenummer | 000000243                   |
      | peildatum           | 2022-08-01                  |
      | fields              | nationaliteiten.redenOpname |
      Dan heeft de response de volgende 'nationaliteiten'
      | type      | redenOpname.code | redenOpname.omschrijving   |
      | Staatloos | 312              | Vaststelling staatloosheid |
