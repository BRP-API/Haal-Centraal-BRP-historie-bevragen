#language: nl

Functionaliteit: leveren van inOnderzoek bij raadplegen met periode

  Rule: als de hele categorie verblijfplaats in onderzoek is, dan worden alle velden van de verblijfplaats inOnderzoek en datumIngangOnderzoek ook geleverd
  
    Scenario: hele categorie verblijfplaats van een Nederlands adres is in onderzoek
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | straatnaam (11.10) | huisnummer (11.20) |
      | 0800                 | Testpad            | 8                  |
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
      | type  | datumVan.type | datumVan.datum | datumVan.langFormaat | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving |
      | Adres | Datum         | 2023-10-14     | 14 oktober 2023      | 0800                         | Hoogeloon, Hapert en Casteren        |
      En heeft de verblijfplaats de volgende 'inOnderzoek' gegevens
      | naam                             | waarde      |
      | type                             | true        |
      | gemeenteVanInschrijving          | true        |
      | datumVan                         | true        |
      | nummeraanduidingIdentificatie    | true        |
      | adresseerbaarObjectIdentificatie | true        |
      | functieAdres                     | true        |
      | datumIngangOnderzoek.type        | Datum       |
      | datumIngangOnderzoek.datum       | 2024-05-16  |
      | datumIngangOnderzoek.langFormaat | 16 mei 2024 |
      En heeft de verblijfplaats de volgende 'verblijfadres' gegevens
      | naam                                         | waarde      |
      | korteStraatnaam                              | Testpad     |
      | huisnummer                                   | 8           |
      | inOnderzoek.korteStraatnaam                  | true        |
      | inOnderzoek.officieleStraatnaam              | true        |
      | inOnderzoek.huisnummer                       | true        |
      | inOnderzoek.huisletter                       | true        |
      | inOnderzoek.huisnummertoevoeging             | true        |
      | inOnderzoek.aanduidingBijHuisnummer          | true        |
      | inOnderzoek.postcode                         | true        |
      | inOnderzoek.woonplaats                       | true        |
      | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
      | inOnderzoek.datumIngangOnderzoek.datum       | 2024-05-16  |
      | inOnderzoek.datumIngangOnderzoek.langFormaat | 16 mei 2024 |
      En heeft de verblijfplaats de volgende 'adressering' gegevens
      | naam                                         | waarde                        |
      | adresregel1                                  | Testpad 8                     |
      | adresregel2                                  | HOOGELOON, HAPERT EN CASTEREN |
      | inOnderzoek.adresregel1                      | true                          |
      | inOnderzoek.adresregel2                      | true                          |
      | inOnderzoek.datumIngangOnderzoek.type        | Datum                         |
      | inOnderzoek.datumIngangOnderzoek.datum       | 2024-05-16                    |
      | inOnderzoek.datumIngangOnderzoek.langFormaat | 16 mei 2024                   |
  
    Scenario: hele categorie verblijfplaats van een historisch adres is in onderzoek
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | straatnaam (11.10) | huisnummer (11.20) |
      | 0800                 | Testpad            | 8                  |
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
      | type  | datumVan.type | datumVan.datum | datumVan.langFormaat | datumTot.type | datumTot.datum | datumTot.langFormaat | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving |
      | Adres | Datum         | 2023-10-14     | 14 oktober 2023      | Datum         | 2024-02-28     | 28 februari 2024     | 0800                         | Hoogeloon, Hapert en Casteren        |
      En heeft de verblijfplaats de volgende 'inOnderzoek' gegevens
      | naam                             | waarde      |
      | type                             | true        |
      | gemeenteVanInschrijving          | true        |
      | datumVan                         | true        |
      | nummeraanduidingIdentificatie    | true        |
      | adresseerbaarObjectIdentificatie | true        |
      | functieAdres                     | true        |
      | datumIngangOnderzoek.type        | Datum       |
      | datumIngangOnderzoek.datum       | 2024-05-16  |
      | datumIngangOnderzoek.langFormaat | 16 mei 2024 |
      En heeft de verblijfplaats de volgende 'verblijfadres' gegevens
      | naam                                         | waarde      |
      | korteStraatnaam                              | Testpad     |
      | huisnummer                                   | 8           |
      | inOnderzoek.korteStraatnaam                  | true        |
      | inOnderzoek.officieleStraatnaam              | true        |
      | inOnderzoek.huisnummer                       | true        |
      | inOnderzoek.huisletter                       | true        |
      | inOnderzoek.huisnummertoevoeging             | true        |
      | inOnderzoek.aanduidingBijHuisnummer          | true        |
      | inOnderzoek.postcode                         | true        |
      | inOnderzoek.woonplaats                       | true        |
      | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
      | inOnderzoek.datumIngangOnderzoek.datum       | 2024-05-16  |
      | inOnderzoek.datumIngangOnderzoek.langFormaat | 16 mei 2024 |
      En heeft de verblijfplaats de volgende 'adressering' gegevens
      | naam                                         | waarde                        |
      | adresregel1                                  | Testpad 8                     |
      | adresregel2                                  | HOOGELOON, HAPERT EN CASTEREN |
      | inOnderzoek.adresregel1                      | true                          |
      | inOnderzoek.adresregel2                      | true                          |
      | inOnderzoek.datumIngangOnderzoek.type        | Datum                         |
      | inOnderzoek.datumIngangOnderzoek.datum       | 2024-05-16                    |
      | inOnderzoek.datumIngangOnderzoek.langFormaat | 16 mei 2024                   |


  Rule: als een verblijfplaatsveld in onderzoek is, en een ander veld wordt daaruit afgeleid of samengesteld, dan worden de afgeleide/samengestelde veld(en) in onderzoek en datumIngangOnderzoek ook geleverd

    Abstract Scenario: type en adresregel1 worden afgeleid van straat die in onderzoek staat
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | straatnaam (11.10) | huisnummer (11.20) |
      | 0800                 | Testpad            | 8                  |
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
      | type  | datumVan.type | datumVan.datum | datumVan.langFormaat | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving |
      | Adres | Datum         | 2023-10-14     | 14 oktober 2023      | 0800                         | Hoogeloon, Hapert en Casteren        |
      En heeft de verblijfplaats de volgende 'inOnderzoek' gegevens
      | naam                             | waarde      |
      | type                             | true        |
      | datumIngangOnderzoek.type        | Datum       |
      | datumIngangOnderzoek.datum       | 2024-05-16  |
      | datumIngangOnderzoek.langFormaat | 16 mei 2024 |
      En heeft de verblijfplaats de volgende 'verblijfadres' gegevens
      | naam                                         | waarde      |
      | korteStraatnaam                              | Testpad     |
      | huisnummer                                   | 8           |
      | inOnderzoek.korteStraatnaam                  | true        |
      | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
      | inOnderzoek.datumIngangOnderzoek.datum       | 2024-05-16  |
      | inOnderzoek.datumIngangOnderzoek.langFormaat | 16 mei 2024 |
      En heeft de verblijfplaats de volgende 'adressering' gegevens
      | naam                                         | waarde                        |
      | adresregel1                                  | Testpad 8                     |
      | adresregel2                                  | HOOGELOON, HAPERT EN CASTEREN |
      | inOnderzoek.adresregel1                      | true                          |
      | inOnderzoek.datumIngangOnderzoek.type        | Datum                         |
      | inOnderzoek.datumIngangOnderzoek.datum       | 2024-05-16                    |
      | inOnderzoek.datumIngangOnderzoek.langFormaat | 16 mei 2024                   |

      Voorbeelden:
      | aanduiding onderzoek |
      | 081110               |
      | 581110               |

    Abstract Scenario: adresregel1 voor een adres in Nederland wordt afgeleid van <veld> die in onderzoek staat
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | straatnaam (11.10) | huisnummer (11.20) |
      | 0800                 | Testpad            | 8                  |
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
      | type  | datumVan.type | datumVan.datum | datumVan.langFormaat | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving |
      | Adres | Datum         | 2023-10-14     | 14 oktober 2023      | 0800                         | Hoogeloon, Hapert en Casteren        |
      En heeft de verblijfplaats de volgende 'verblijfadres' gegevens
      | naam                                         | waarde      |
      | korteStraatnaam                              | Testpad     |
      | huisnummer                                   | 8           |
      | inOnderzoek.<veld>                           | true        |
      | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
      | inOnderzoek.datumIngangOnderzoek.datum       | 2024-05-16  |
      | inOnderzoek.datumIngangOnderzoek.langFormaat | 16 mei 2024 |
      En heeft de verblijfplaats de volgende 'adressering' gegevens
      | naam                                         | waarde                        |
      | adresregel1                                  | Testpad 8                     |
      | adresregel2                                  | HOOGELOON, HAPERT EN CASTEREN |
      | inOnderzoek.adresregel1                      | true                          |
      | inOnderzoek.datumIngangOnderzoek.type        | Datum                         |
      | inOnderzoek.datumIngangOnderzoek.datum       | 2024-05-16                    |
      | inOnderzoek.datumIngangOnderzoek.langFormaat | 16 mei 2024                   |

      Voorbeelden:
      | veld                    | aanduiding onderzoek |
      | officieleStraatnaam     | 081115               |
      | huisnummer              | 081120               |
      | huisletter              | 081130               |
      | huisnummertoevoeging    | 081140               |
      | aanduidingBijHuisnummer | 081150               |
      | officieleStraatnaam     | 581115               |
      | huisnummer              | 581120               |
      | huisletter              | 581130               |
      | huisnummertoevoeging    | 581140               |
      | aanduidingBijHuisnummer | 581150               |

    Abstract Scenario: adresregel2 wordt afgeleid van <veld> die in onderzoek staat
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | straatnaam (11.10) | huisnummer (11.20) |
      | 0800                 | Testpad            | 8                  |
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
      | type  | datumVan.type | datumVan.datum | datumVan.langFormaat | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving |
      | Adres | Datum         | 2023-10-14     | 14 oktober 2023      | 0800                         | Hoogeloon, Hapert en Casteren        |
      En heeft de verblijfplaats de volgende 'inOnderzoek' gegevens
      | naam                             | waarde      |
      | type                             | true        |
      | gemeenteVanInschrijving          | true        |
      | datumVan                         | true        |
      | nummeraanduidingIdentificatie    | true        |
      | adresseerbaarObjectIdentificatie | true        |
      | functieAdres                     | true        |
      | datumIngangOnderzoek.type        | Datum       |
      | datumIngangOnderzoek.datum       | 2024-05-16  |
      | datumIngangOnderzoek.langFormaat | 16 mei 2024 |
      En heeft de verblijfplaats de volgende 'verblijfadres' gegevens
      | naam                                         | waarde      |
      | korteStraatnaam                              | Testpad     |
      | huisnummer                                   | 8           |
      | inOnderzoek.<veld>                           | true        |
      | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
      | inOnderzoek.datumIngangOnderzoek.datum       | 2024-05-16  |
      | inOnderzoek.datumIngangOnderzoek.langFormaat | 16 mei 2024 |
      En heeft de verblijfplaats de volgende 'adressering' gegevens
      | naam                                         | waarde                        |
      | adresregel1                                  | Testpad 8                     |
      | adresregel2                                  | HOOGELOON, HAPERT EN CASTEREN |
      | inOnderzoek.adresregel1                      | true                          |
      | inOnderzoek.adresregel2                      | true                          |
      | inOnderzoek.datumIngangOnderzoek.type        | Datum                         |
      | inOnderzoek.datumIngangOnderzoek.datum       | 2024-05-16                    |
      | inOnderzoek.datumIngangOnderzoek.langFormaat | 16 mei 2024                   |

      Voorbeelden:
      | veld       | aanduiding onderzoek |
      | postcode   | 081160               |
      | woonplaats | 081170               |
      | postcode   | 581160               |
      | woonplaats | 581170               |

    Scenario: adresregel2 wordt afgeleid van gemeenteVanInschrijving die in onderzoek staat
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | straatnaam (11.10) | huisnummer (11.20) |
      | 0800                 | Testpad            | 8                  |
      En de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
      | 0800                              | 20231014                           | 080910                          | 20240516                       |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2023-07-01          |
      | datumTot            | 2024-01-01          |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | type  | datumVan.type | datumVan.datum | datumVan.langFormaat | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving |
      | Adres | Datum         | 2023-10-14     | 14 oktober 2023      | 0800                         | Hoogeloon, Hapert en Casteren        |
      En heeft de verblijfplaats de volgende 'inOnderzoek' gegevens
      | naam                             | waarde      |
      | gemeenteVanInschrijving          | true        |
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
      | inOnderzoek.adresregel2                      | true                          |
      | inOnderzoek.datumIngangOnderzoek.type        | Datum                         |
      | inOnderzoek.datumIngangOnderzoek.datum       | 2024-05-16                    |
      | inOnderzoek.datumIngangOnderzoek.langFormaat | 16 mei 2024                   |

   Abstract Scenario: datumVan wordt afgeleid van datum aanvang die in onderzoek staat
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | straatnaam (11.10) | huisnummer (11.20) |
      | 0800                 | Testpad            | 8                  |
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
      | type  | datumVan.type | datumVan.datum | datumVan.langFormaat | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving |
      | Adres | Datum         | 2023-10-14     | 14 oktober 2023      | 0800                         | Hoogeloon, Hapert en Casteren        |
      En heeft de verblijfplaats de volgende 'inOnderzoek' gegevens
      | naam                             | waarde      |
      | datumVan                         | true        |
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

      Voorbeelden:
      | aanduiding onderzoek |
      | 081030               |
      | 581030               |


  Rule: als de hele groep in verblijfplaats in onderzoek is, dan wordt voor alle velden van de groep, en die daaruit worden afgeleid, inOnderzoek en datumIngangOnderzoek ook geleverd

    Scenario: groep gemeente is in onderzoek
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | straatnaam (11.10) | huisnummer (11.20) |
      | 0800                 | Testpad            | 8                  |
      En de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
      | 0800                              | 20231014                           | 080900                          | 20240516                       |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2023-07-01          |
      | datumTot            | 2024-01-01          |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | type  | datumVan.type | datumVan.datum | datumVan.langFormaat | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving |
      | Adres | Datum         | 2023-10-14     | 14 oktober 2023      | 0800                         | Hoogeloon, Hapert en Casteren        |
      En heeft de verblijfplaats de volgende 'inOnderzoek' gegevens
      | naam                             | waarde      |
      | gemeenteVanInschrijving          | true        |
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
      | inOnderzoek.adresregel2                      | true                          |
      | inOnderzoek.datumIngangOnderzoek.type        | Datum                         |
      | inOnderzoek.datumIngangOnderzoek.datum       | 2024-05-16                    |
      | inOnderzoek.datumIngangOnderzoek.langFormaat | 16 mei 2024                   |

    Abstract Scenario: groep adreshouding is in onderzoek
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | straatnaam (11.10) | huisnummer (11.20) |
      | 0800                 | Testpad            | 8                  |
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
      | type  | datumVan.type | datumVan.datum | datumVan.langFormaat | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving |
      | Adres | Datum         | 2023-10-14     | 14 oktober 2023      | 0800                         | Hoogeloon, Hapert en Casteren        |
      En heeft de verblijfplaats de volgende 'inOnderzoek' gegevens
      | naam                             | waarde      |
      | datumVan                         | true        |
      | functieAdres                     | true        |
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

      Voorbeelden:
      | aanduiding onderzoek |
      | 081000               |
      | 581000               |

    Abstract Scenario: groep adres is in onderzoek
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | straatnaam (11.10) | huisnummer (11.20) |
      | 0800                 | Testpad            | 8                  |
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
      | type  | datumVan.type | datumVan.datum | datumVan.langFormaat | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving |
      | Adres | Datum         | 2023-10-14     | 14 oktober 2023      | 0800                         | Hoogeloon, Hapert en Casteren        |
      En heeft de verblijfplaats de volgende 'inOnderzoek' gegevens
      | naam                             | waarde      |
      | type                             | true        |
      | nummeraanduidingIdentificatie    | true        |
      | adresseerbaarObjectIdentificatie | true        |
      | datumIngangOnderzoek.type        | Datum       |
      | datumIngangOnderzoek.datum       | 2024-05-16  |
      | datumIngangOnderzoek.langFormaat | 16 mei 2024 |
      En heeft de verblijfplaats de volgende 'verblijfadres' gegevens
      | naam                                         | waarde      |
      | korteStraatnaam                              | Testpad     |
      | huisnummer                                   | 8           |
      | inOnderzoek.korteStraatnaam                  | true        |
      | inOnderzoek.officieleStraatnaam              | true        |
      | inOnderzoek.huisnummer                       | true        |
      | inOnderzoek.huisletter                       | true        |
      | inOnderzoek.huisnummertoevoeging             | true        |
      | inOnderzoek.aanduidingBijHuisnummer          | true        |
      | inOnderzoek.postcode                         | true        |
      | inOnderzoek.woonplaats                       | true        |
      | inOnderzoek.datumIngangOnderzoek.type        | Datum       |
      | inOnderzoek.datumIngangOnderzoek.datum       | 2024-05-16  |
      | inOnderzoek.datumIngangOnderzoek.langFormaat | 16 mei 2024 |
      En heeft de verblijfplaats de volgende 'adressering' gegevens
      | naam                                         | waarde                        |
      | adresregel1                                  | Testpad 8                     |
      | adresregel2                                  | HOOGELOON, HAPERT EN CASTEREN |
      | inOnderzoek.adresregel1                      | true                          |
      | inOnderzoek.adresregel2                      | true                          |
      | inOnderzoek.datumIngangOnderzoek.type        | Datum                         |
      | inOnderzoek.datumIngangOnderzoek.datum       | 2024-05-16                    |
      | inOnderzoek.datumIngangOnderzoek.langFormaat | 16 mei 2024                   |

      Voorbeelden:
      | aanduiding onderzoek |
      | 081100               |
      | 581100               |


  Rule: als een verblijfplaatsveld in onderzoek is, dan wordt het bijbehorend inOnderzoek veld en datumIngangOnderzoek ook geleverd

    Abstract Scenario: veld <veld> is in onderzoek
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | straatnaam (11.10) | huisnummer (11.20) |
      | 0800                 | Testpad            | 8                  |
      En de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
      | 0800                              | 20231014                           | <aanduiding onderzoek>                          | 20240516                       |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2023-07-01          |
      | datumTot            | 2024-01-01          |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | type  | datumVan.type | datumVan.datum | datumVan.langFormaat | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving |
      | Adres | Datum         | 2023-10-14     | 14 oktober 2023      | 0800                         | Hoogeloon, Hapert en Casteren        |
      En heeft de verblijfplaats de volgende 'inOnderzoek' gegevens
      | naam                             | waarde      |
      | <veld>                           | true        |
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

      Voorbeelden:
      | veld                             | aanduiding onderzoek |
      | functieAdres                     | 081010               |
      | adresseerbaarObjectIdentificatie | 081180               |
      | nummeraanduidingIdentificatie    | 081190               |
      | functieAdres                     | 581010               |
      | adresseerbaarObjectIdentificatie | 581180               |
      | nummeraanduidingIdentificatie    | 581190               |


  Rule: als de datum aanvang van de volgende verblijfplaats in onderzoek is, dan wordt inOnderzoek datumTot en datumIngangOnderzoek ook geleverd

    Abstract Scenario: <omschrijving> van volgende verblijfplaats in Nederland is in onderzoek
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | straatnaam (11.10) | huisnummer (11.20) |
      | 0800                 | Testpad            | 8                  |
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
      | type  | datumVan.type | datumVan.datum | datumVan.langFormaat | datumTot.type | datumTot.datum | datumTot.langFormaat | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving |
      | Adres | Datum         | 2023-10-14     | 14 oktober 2023      | Datum         | 2024-02-28     | 28 februari 2024     | 0800                         | Hoogeloon, Hapert en Casteren        |
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

      Voorbeelden:
      | omschrijving               | aanduiding onderzoek |
      | hele categorie             | 080000               |
      | groep adreshouding         | 081000               |
      | datum aanvang adreshouding | 081030               |
      | hele categorie             | 580000               |
      | groep adreshouding         | 581000               |
      | datum aanvang adreshouding | 581030               |

    Abstract Scenario: <omschrijving> van volgende verblijfplaats in buitenland is in onderzoek
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | straatnaam (11.10) | huisnummer (11.20) |
      | 0800                 | Testpad            | 8                  |
      En de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20231014                           |
      En de persoon is vervolgens ingeschreven op een buitenlands adres met de volgende gegevens      
      | gemeente van inschrijving (09.10) | datum aanvang adres buitenland (13.20) | land adres buitenland (13.10) | regel 1 adres buitenland (13.30) | regel 2 adres buitenland (13.40) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
      | 1999                              | 20231014                               | 6014                          | Die Erste Straße                 | Beverly Hills CA 90210           | <aanduiding onderzoek>          | 20240516                       |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2023-07-01          |
      | datumTot            | 2024-01-01          |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | type  | datumVan.type | datumVan.datum | datumVan.langFormaat | datumTot.type | datumTot.datum | datumTot.langFormaat | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving |
      | Adres | Datum         | 2023-10-14     | 14 oktober 2023      | Datum         | 2024-02-28     | 28 februari 2024     | 0800                         | Hoogeloon, Hapert en Casteren        |
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

      Voorbeelden:
      | omschrijving               | aanduiding onderzoek |
      | hele categorie             | 080000               |
      | groep adreshouding         | 081300               |
      | datum aanvang adreshouding | 081320               |
      | hele categorie             | 580000               |
      | groep adreshouding         | 581300               |
      | datum aanvang adreshouding | 581320               |

  Rule: wanneer een veld of groep in onderzoek staat die niet in verblijfplaatshistorie voorkomt, wordt geen inOnderzoek geleverd

    Abstract Scenario: <omschrijving> van verblijfplaats in Nederland is in onderzoek
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | straatnaam (11.10) | huisnummer (11.20) |
      | 0800                 | Testpad            | 8                  |
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
      | type  | datumVan.type | datumVan.datum | datumVan.langFormaat | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving |
      | Adres | Datum         | 2023-10-14     | 14 oktober 2023      | 0800                         | Hoogeloon, Hapert en Casteren        |
      En heeft de verblijfplaats de volgende 'verblijfadres' gegevens
      | naam                                         | waarde      |
      | korteStraatnaam                              | Testpad     |
      | huisnummer                                   | 8           |
      En heeft de verblijfplaats de volgende 'adressering' gegevens
      | naam                                         | waarde                        |
      | adresregel1                                  | Testpad 8                     |
      | adresregel2                                  | HOOGELOON, HAPERT EN CASTEREN |

      Voorbeelden:
      | omschrijving                 | aanduiding onderzoek |
      | datum inschrijving           | 080920               |
      | gemeentedeel                 | 081020               |
      | immigratie                   | 081400               |
      | land vanwaar ingeschreven    | 081410               |
      | datum vestiging in Nederland | 081420               |
      | datum inschrijving           | 580920               |
      | gemeentedeel                 | 581020               |
      | immigratie                   | 581400               |
      | land vanwaar ingeschreven    | 581410               |
      | datum vestiging in Nederland | 581420               |
