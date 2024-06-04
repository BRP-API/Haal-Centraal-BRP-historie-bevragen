#language: nl

Functionaliteit: leveren van inOnderzoek bij raadplegen met periode

  Rule: als de hele categorie verblijfplaats in onderzoek is, dan worden alle velden van de verblijfplaats inOnderzoek en datumIngangOnderzoek ook geleverd
  
    Scenario: hele categorie verblijfplaats van een locatie is in onderzoek
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | locatiebeschrijving (12.10) |
      | 0800                 | Woonboot bij de Grote Sloot |
      En de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
      | 0800                              | 20231014                           | 080000                          | 20240516                       |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2023-07-01          |
      | datumTot            | 2024-01-01          |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | type    | datumVan.type | datumVan.datum | datumVan.langFormaat | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving |
      | Locatie | Datum         | 2023-10-14     | 14 oktober 2023      | 0800                         | Hoogeloon, Hapert en Casteren        |
      En heeft de verblijfplaats de volgende 'inOnderzoek' gegevens
      | naam                             | waarde      |
      | type                             | true        |
      | gemeenteVanInschrijving          | true        |
      | datumVan                         | true        |
      | functieAdres                     | true        |
      | datumIngangOnderzoek.type        | Datum       |
      | datumIngangOnderzoek.datum       | 2024-05-16  |
      | datumIngangOnderzoek.langFormaat | 16 mei 2024 |
      En heeft de verblijfplaats de volgende 'verblijfadres' gegevens
      | naam                                         | waarde                      |
      | locatiebeschrijving                          | Woonboot bij de Grote Sloot |
      | inOnderzoek.locatiebeschrijving              | true                        |
      | inOnderzoek.datumIngangOnderzoek.type        | Datum                       |
      | inOnderzoek.datumIngangOnderzoek.datum       | 2024-05-16                  |
      | inOnderzoek.datumIngangOnderzoek.langFormaat | 16 mei 2024                 |
      En heeft de verblijfplaats de volgende 'adressering' gegevens
      | naam                                         | waarde                        |
      | adresregel1                                  | Woonboot bij de Grote Sloot   |
      | adresregel2                                  | HOOGELOON, HAPERT EN CASTEREN |
      | inOnderzoek.adresregel1                      | true                          |
      | inOnderzoek.adresregel2                      | true                          |
      | inOnderzoek.datumIngangOnderzoek.type        | Datum                         |
      | inOnderzoek.datumIngangOnderzoek.datum       | 2024-05-16                    |
      | inOnderzoek.datumIngangOnderzoek.langFormaat | 16 mei 2024                   |

    Scenario: hele categorie verblijfplaats van een historisch adres is in onderzoek
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | locatiebeschrijving (12.10) |
      | 0800                 | Woonboot bij de Grote Sloot |
      En adres 'A2' heeft de volgende gegevens
      | gemeentecode (92.10) | straatnaam (11.10) | huisnummer (11.20) |
      | 0800                 | Beatrixpark        | 52                 |
      En de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
      | 0800                              | 20231014                           | 580000                          | 20240516                       |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20240228                           |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2023-07-01          |
      | datumTot            | 2024-01-01          |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | type    | datumVan.type | datumVan.datum | datumVan.langFormaat | datumTot.type | datumTot.datum | datumTot.langFormaat | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving |
      | Locatie | Datum         | 2023-10-14     | 14 oktober 2023      | Datum         | 2024-02-28     | 28 februari 2024     | 0800                         | Hoogeloon, Hapert en Casteren        |
      En heeft de verblijfplaats de volgende 'inOnderzoek' gegevens
      | naam                             | waarde      |
      | type                             | true        |
      | gemeenteVanInschrijving          | true        |
      | datumVan                         | true        |
      | functieAdres                     | true        |
      | datumIngangOnderzoek.type        | Datum       |
      | datumIngangOnderzoek.datum       | 2024-05-16  |
      | datumIngangOnderzoek.langFormaat | 16 mei 2024 |
      En heeft de verblijfplaats de volgende 'verblijfadres' gegevens
      | naam                                         | waarde                      |
      | locatiebeschrijving                          | Woonboot bij de Grote Sloot |
      | inOnderzoek.locatiebeschrijving              | true                        |
      | inOnderzoek.datumIngangOnderzoek.type        | Datum                       |
      | inOnderzoek.datumIngangOnderzoek.datum       | 2024-05-16                  |
      | inOnderzoek.datumIngangOnderzoek.langFormaat | 16 mei 2024                 |
      En heeft de verblijfplaats de volgende 'adressering' gegevens
      | naam                                         | waarde                        |
      | adresregel1                                  | Woonboot bij de Grote Sloot   |
      | adresregel2                                  | HOOGELOON, HAPERT EN CASTEREN |
      | inOnderzoek.adresregel1                      | true                          |
      | inOnderzoek.adresregel2                      | true                          |
      | inOnderzoek.datumIngangOnderzoek.type        | Datum                         |
      | inOnderzoek.datumIngangOnderzoek.datum       | 2024-05-16                    |
      | inOnderzoek.datumIngangOnderzoek.langFormaat | 16 mei 2024                   |


  Rule: als een verblijfplaatsveld in onderzoek is, en een ander veld wordt daaruit afgeleid of samengesteld, dan worden de afgeleide/samengestelde veld(en) in onderzoek en datumIngangOnderzoek ook geleverd

    Scenario: type en adresregel1 worden afgeleid van locatie die in onderzoek staat
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | locatiebeschrijving (12.10) |
      | 0800                 | Woonboot bij de Grote Sloot |
      En de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
      | 0800                              | 20231014                           | 081210                          | 20240516                       |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2023-07-01          |
      | datumTot            | 2024-01-01          |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | type    | datumVan.type | datumVan.datum | datumVan.langFormaat | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving |
      | Locatie | Datum         | 2023-10-14     | 14 oktober 2023      | 0800                         | Hoogeloon, Hapert en Casteren        |
      En heeft de verblijfplaats de volgende 'inOnderzoek' gegevens
      | naam                             | waarde      |
      | type                             | true        |
      | datumIngangOnderzoek.type        | Datum       |
      | datumIngangOnderzoek.datum       | 2024-05-16  |
      | datumIngangOnderzoek.langFormaat | 16 mei 2024 |
      En heeft de verblijfplaats de volgende 'verblijfadres' gegevens
      | naam                                         | waarde                      |
      | locatiebeschrijving                          | Woonboot bij de Grote Sloot |
      | inOnderzoek.locatiebeschrijving              | true                        |
      | inOnderzoek.datumIngangOnderzoek.type        | Datum                       |
      | inOnderzoek.datumIngangOnderzoek.datum       | 2024-05-16                  |
      | inOnderzoek.datumIngangOnderzoek.langFormaat | 16 mei 2024                 |
      En heeft de verblijfplaats de volgende 'adressering' gegevens
      | naam                                         | waarde                        |
      | adresregel1                                  | Woonboot bij de Grote Sloot   |
      | adresregel2                                  | HOOGELOON, HAPERT EN CASTEREN |
      | inOnderzoek.adresregel1                      | true                          |
      | inOnderzoek.datumIngangOnderzoek.type        | Datum                         |
      | inOnderzoek.datumIngangOnderzoek.datum       | 2024-05-16                    |
      | inOnderzoek.datumIngangOnderzoek.langFormaat | 16 mei 2024                   |

    Scenario: adresregel2 wordt afgeleid van gemeenteVanInschrijving die in onderzoek staat
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | locatiebeschrijving (12.10) |
      | 0800                 | Woonboot bij de Grote Sloot |
      En de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
      | 0800                              | 20231014                           | <aanduiding onderzoek>          | 20240516                       |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2023-07-01          |
      | datumTot            | 2024-01-01          |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | type    | datumVan.type | datumVan.datum | datumVan.langFormaat | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving |
      | Locatie | Datum         | 2023-10-14     | 14 oktober 2023      | 0800                         | Hoogeloon, Hapert en Casteren        |
      En heeft de verblijfplaats de volgende 'inOnderzoek' gegevens
      | naam                             | waarde      |
      | gemeenteVanInschrijving          | true        |
      | datumIngangOnderzoek.type        | Datum       |
      | datumIngangOnderzoek.datum       | 2024-05-16  |
      | datumIngangOnderzoek.langFormaat | 16 mei 2024 |
      En heeft de verblijfplaats de volgende 'verblijfadres' gegevens
      | naam                                         | waarde                      |
      | locatiebeschrijving                          | Woonboot bij de Grote Sloot |
      En heeft de verblijfplaats de volgende 'adressering' gegevens
      | naam                                         | waarde                        |
      | adresregel1                                  | Woonboot bij de Grote Sloot   |
      | adresregel2                                  | HOOGELOON, HAPERT EN CASTEREN |
      | inOnderzoek.adresregel2                      | true                          |
      | inOnderzoek.datumIngangOnderzoek.type        | Datum                         |
      | inOnderzoek.datumIngangOnderzoek.datum       | 2024-05-16                    |
      | inOnderzoek.datumIngangOnderzoek.langFormaat | 16 mei 2024                   |

      Voorbeelden:
      | aanduiding onderzoek |
      | 080910               |
      | 580910               |

    Abstract Scenario: datumVan wordt afgeleid van datum aanvang die in onderzoek staat
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | locatiebeschrijving (12.10) |
      | 0800                 | Woonboot bij de Grote Sloot |
      En de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
      | 0800                              | 20231014                           | <aanduiding onderzoek>          | 20240516                       |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2023-07-01          |
      | datumTot            | 2024-01-01          |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | type    | datumVan.type | datumVan.datum | datumVan.langFormaat | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving |
      | Locatie | Datum         | 2023-10-14     | 14 oktober 2023      | 0800                         | Hoogeloon, Hapert en Casteren        |
      En heeft de verblijfplaats de volgende 'inOnderzoek' gegevens
      | naam                             | waarde      |
      | datumVan                         | true        |
      | datumIngangOnderzoek.type        | Datum       |
      | datumIngangOnderzoek.datum       | 2024-05-16  |
      | datumIngangOnderzoek.langFormaat | 16 mei 2024 |
      En heeft de verblijfplaats de volgende 'verblijfadres' gegevens
      | naam                                         | waarde                      |
      | locatiebeschrijving                          | Woonboot bij de Grote Sloot |
      En heeft de verblijfplaats de volgende 'adressering' gegevens
      | naam                                         | waarde                        |
      | adresregel1                                  | Woonboot bij de Grote Sloot   |
      | adresregel2                                  | HOOGELOON, HAPERT EN CASTEREN |

      Voorbeelden:
      | aanduiding onderzoek |
      | 081030               |
      | 581030               |


  Rule: als de hele groep in verblijfplaats in onderzoek is, dan wordt voor alle velden van de groep, en die daaruit worden afgeleid, inOnderzoek en datumIngangOnderzoek ook geleverd

    Scenario: groep gemeente is in onderzoek
      
    Scenario: groep adreshouding is in onderzoek

    Scenario: groep locatie is in onderzoek 


  Rule: als de datum aanvang van de volgende verblijfplaats in onderzoek is, dan wordt inOnderzoek datumTot en datumIngangOnderzoek ook geleverd
      
    Abstract Scenario: <omschrijving> van volgende verblijfplaats in Nederland is in onderzoek
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | locatiebeschrijving (12.10) |
      | 0800                 | Woonboot bij de Grote Sloot |
      En adres 'A2' heeft de volgende gegevens
      | gemeentecode (92.10) | straatnaam (11.10) | huisnummer (11.20) |
      | 0800                 | Beatrixpark        | 52                 |
      En de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20231014                           |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
      | 0800                              | 20240228                           | <aanduiding onderzoek>          | 20240516                       |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2023-07-01          |
      | datumTot            | 2024-01-01          |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | type    | datumVan.type | datumVan.datum | datumVan.langFormaat | datumTot.type | datumTot.datum | datumTot.langFormaat | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving |
      | Locatie | Datum         | 2023-10-14     | 14 oktober 2023      | Datum         | 2024-02-28     | 28 februari 2024     | 0800                         | Hoogeloon, Hapert en Casteren        |
      En heeft de verblijfplaats de volgende 'inOnderzoek' gegevens
      | naam                             | waarde      |
      | datumTot                         | true        |
      | datumIngangOnderzoek.type        | Datum       |
      | datumIngangOnderzoek.datum       | 2024-05-16  |
      | datumIngangOnderzoek.langFormaat | 16 mei 2024 |
      En heeft de verblijfplaats de volgende 'verblijfadres' gegevens
      | naam                                         | waarde      |
      | korteStraatnaam                              | Testpad     |
      | huisnummer                                   | 8           |
      En heeft de verblijfplaats de volgende 'adressering' gegevens
      | naam                                         | waarde                        |
      | adresregel1                                  | Testpad 8                     |
      | adresregel2                                  | HOOGELOON, HAPERT EN CASTEREN |
