#language: nl

Functionaliteit: leveren van inOnderzoek bij raadplegen met periode

  Rule: als de hele categorie verblijfplaats in onderzoek is, dan worden alle velden van de verblijfplaats inOnderzoek en datumIngangOnderzoek ook geleverd
  
    Scenario: hele categorie verblijfplaats van een onbekende verblijfplaats
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op een buitenlands adres met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adres buitenland (13.20) | land adres buitenland (13.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
      | 1999                              | 20231014                               | 0000                          | 080000                          | 20240516                       |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2023-07-01          |
      | datumTot            | 2024-01-01          |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | type                   | datumVan.type | datumVan.datum | datumVan.langFormaat |
      | VerblijfplaatsOnbekend | Datum         | 2023-10-14     | 14 oktober 2023      |
      En heeft de verblijfplaats de volgende 'inOnderzoek' gegevens
      | naam                             | waarde      |
      | type                             | true        |
      | datumVan                         | true        |
      | datumIngangOnderzoek.type        | Datum       |
      | datumIngangOnderzoek.datum       | 2024-05-16  |
      | datumIngangOnderzoek.langFormaat | 16 mei 2024 |
  
    Scenario: hele categorie verblijfplaats van een historisch onbekende verblijfplaats is in onderzoek
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | straatnaam (11.10) | huisnummer (11.20) |
      | 0800                 | Testpad            | 8                  |
      En de persoon met burgerservicenummer '000000012' is ingeschreven op een buitenlands adres met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adres buitenland (13.20) | land adres buitenland (13.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
      | 1999                              | 20231014                               | 0000                          | 580000                          | 20240516                       |
      En de persoon is vervolgens ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20240228                           |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2023-07-01          |
      | datumTot            | 2024-01-01          |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | type                   | datumVan.type | datumVan.datum | datumVan.langFormaat | datumTot.type | datumTot.datum | datumTot.langFormaat |
      | VerblijfplaatsOnbekend | Datum         | 2023-10-14     | 14 oktober 2023      | Datum         | 2024-02-28     | 28 februari 2024     |
      En heeft de verblijfplaats de volgende 'inOnderzoek' gegevens
      | naam                             | waarde      |
      | type                             | true        |
      | datumVan                         | true        |
      | datumIngangOnderzoek.type        | Datum       |
      | datumIngangOnderzoek.datum       | 2024-05-16  |
      | datumIngangOnderzoek.langFormaat | 16 mei 2024 |


  Rule: als een verblijfplaatsveld in onderzoek is, en een ander veld wordt daaruit afgeleid of samengesteld, dan worden de afgeleide/samengestelde veld(en) in onderzoek en datumIngangOnderzoek ook geleverd

    Abstract Scenario: type wordt afgeleid van land die in onderzoek staat
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op een buitenlands adres met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adres buitenland (13.20) | land adres buitenland (13.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
      | 1999                              | 20231014                               | 0000                          | <aanduiding onderzoek>          | 20240516                       |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2023-07-01          |
      | datumTot            | 2024-01-01          |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | type                   | datumVan.type | datumVan.datum | datumVan.langFormaat |
      | VerblijfplaatsOnbekend | Datum         | 2023-10-14     | 14 oktober 2023      |
      En heeft de verblijfplaats de volgende 'inOnderzoek' gegevens
      | naam                             | waarde      |
      | type                             | true        |
      | datumIngangOnderzoek.type        | Datum       |
      | datumIngangOnderzoek.datum       | 2024-05-16  |
      | datumIngangOnderzoek.langFormaat | 16 mei 2024 |

      Voorbeelden:
      | aanduiding onderzoek |
      | 081310               |
      | 581310               |

    Abstract Scenario: datumVan wordt afgeleid van datum aanvang verblijf buitenland die in onderzoek staat
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op een buitenlands adres met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adres buitenland (13.20) | land adres buitenland (13.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
      | 1999                              | 20231014                               | 0000                          | <aanduiding onderzoek>          | 20240516                       |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2023-07-01          |
      | datumTot            | 2024-01-01          |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | type                   | datumVan.type | datumVan.datum | datumVan.langFormaat |
      | VerblijfplaatsOnbekend | Datum         | 2023-10-14     | 14 oktober 2023      |
      En heeft de verblijfplaats de volgende 'inOnderzoek' gegevens
      | naam                             | waarde      |
      | datumVan                         | true        |
      | datumIngangOnderzoek.type        | Datum       |
      | datumIngangOnderzoek.datum       | 2024-05-16  |
      | datumIngangOnderzoek.langFormaat | 16 mei 2024 |

      Voorbeelden:
      | aanduiding onderzoek |
      | 081320               |
      | 581320               |


  Rule: als de hele groep in verblijfplaats in onderzoek is, dan wordt voor alle velden van de groep, en die daaruit worden afgeleid, inOnderzoek en datumIngangOnderzoek ook geleverd

    Abstract Scenario: groep gemeente is in onderzoek maar komt niet voor bij verblijfplaats onbekend
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op een buitenlands adres met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adres buitenland (13.20) | land adres buitenland (13.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
      | 1999                              | 20231014                               | 0000                          | <aanduiding onderzoek>          | 20240516                       |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2023-07-01          |
      | datumTot            | 2024-01-01          |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | type                   | datumVan.type | datumVan.datum | datumVan.langFormaat |
      | VerblijfplaatsOnbekend | Datum         | 2023-10-14     | 14 oktober 2023      |

      Voorbeelden:
      | aanduiding onderzoek |
      | 080900               |
      | 580900               |

    Abstract Scenario: groep adres buitenland is in onderzoek
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op een buitenlands adres met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adres buitenland (13.20) | land adres buitenland (13.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
      | 1999                              | 20231014                               | 0000                          | <aanduiding onderzoek>          | 20240516                       |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2023-07-01          |
      | datumTot            | 2024-01-01          |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | type                   | datumVan.type | datumVan.datum | datumVan.langFormaat |
      | VerblijfplaatsOnbekend | Datum         | 2023-10-14     | 14 oktober 2023      |
      En heeft de verblijfplaats de volgende 'inOnderzoek' gegevens
      | naam                             | waarde      |
      | type                             | true        |
      | datumVan                         | true        |
      | datumIngangOnderzoek.type        | Datum       |
      | datumIngangOnderzoek.datum       | 2024-05-16  |
      | datumIngangOnderzoek.langFormaat | 16 mei 2024 |

      Voorbeelden:
      | aanduiding onderzoek |
      | 081300               |
      | 581300               |

  Rule: als de datum aanvang van de volgende verblijfplaats in onderzoek is, dan wordt inOnderzoek datumTot en datumIngangOnderzoek ook geleverd

    Abstract Scenario: <omschrijving> van volgende verblijfplaats in Nederland is in onderzoek
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | straatnaam (11.10) | huisnummer (11.20) |
      | 0800                 | Testpad            | 8                  |
      En de persoon met burgerservicenummer '000000012' is ingeschreven op een buitenlands adres met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adres buitenland (13.20) | land adres buitenland (13.10) |
      | 1999                              | 20231014                               | 0000                          |
      En de persoon is vervolgens ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
      | 0800                              | 20240228                           | <aanduiding onderzoek>          | 20240516                       |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2023-07-01          |
      | datumTot            | 2024-01-01          |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | type                   | datumVan.type | datumVan.datum | datumVan.langFormaat | datumTot.type | datumTot.datum | datumTot.langFormaat |
      | VerblijfplaatsOnbekend | Datum         | 2023-10-14     | 14 oktober 2023      | Datum         | 2024-02-28     | 28 februari 2024     |
      En heeft de verblijfplaats de volgende 'inOnderzoek' gegevens
      | naam                             | waarde      |
      | datumTot                         | true        |
      | datumIngangOnderzoek.type        | Datum       |
      | datumIngangOnderzoek.datum       | 2024-05-16  |
      | datumIngangOnderzoek.langFormaat | 16 mei 2024 |

      Voorbeelden:
      | omschrijving               | aanduiding onderzoek |
      | hele categorie             | 080000               |
      | groep adreshouding         | 081000               |
      | datum aanvang adreshouding | 081030               |
      | hele categorie             | 580000               |
      | groep adreshouding         | 581000               |
      | datum aanvang adreshouding | 581030               |

    Abstract Scenario: <omschrijving> van volgende verblijfplaats buitenland is in onderzoek
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | straatnaam (11.10) | huisnummer (11.20) |
      | 0800                 | Testpad            | 8                  |
      En de persoon met burgerservicenummer '000000012' is ingeschreven op een buitenlands adres met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adres buitenland (13.20) | land adres buitenland (13.10) |
      | 1999                              | 20231014                               | 0000                          |
      En de persoon is vervolgens ingeschreven op een buitenlands adres met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adres buitenland (13.20) | land adres buitenland (13.10) | regel 1 adres buitenland (13.30) | regel 2 adres buitenland (13.40) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
      | 1999                              | 20240228                               | 7044                          | Piazza del Colosseo, 1           | 00184 Roma RM                    | <aanduiding onderzoek>          | 20240516                       |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2023-07-01          |
      | datumTot            | 2024-01-01          |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | type                   | datumVan.type | datumVan.datum | datumVan.langFormaat | datumTot.type | datumTot.datum | datumTot.langFormaat |
      | VerblijfplaatsOnbekend | Datum         | 2023-10-14     | 14 oktober 2023      | Datum         | 2024-02-28     | 28 februari 2024     |
      En heeft de verblijfplaats de volgende 'inOnderzoek' gegevens
      | naam                             | waarde      |
      | datumTot                         | true        |
      | datumIngangOnderzoek.type        | Datum       |
      | datumIngangOnderzoek.datum       | 2024-05-16  |
      | datumIngangOnderzoek.langFormaat | 16 mei 2024 |

      Voorbeelden:
      | omschrijving                      | aanduiding onderzoek |
      | hele categorie                    | 080000               |
      | groep verblijf buitenland         | 081300               |
      | datum aanvang verblijf buitenland | 081320               |
      | hele categorie                    | 580000               |
      | groep verblijf buitenland         | 581300               |
      | datum aanvang verblijf buitenland | 581320               |
