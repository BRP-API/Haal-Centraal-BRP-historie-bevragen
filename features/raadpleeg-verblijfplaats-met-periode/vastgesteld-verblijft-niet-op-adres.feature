#language: nl 

Functionaliteit: persoon met 'indicatie vastgesteld verblijft niet op adres' bij verblijfplaatshistorie met periode

  Een burger kan bij de gemeente melden dat iemand anders ten onrechte op diens adres staat ingeschreven. 
  De gemeente doet daar dan onderzoek naar en kan concluderen dat deze andere persoon inderdaad niet meer op dat adres verblijft. 
  Wanneer tijdens de uitvoer van het onderzoek vastgesteld wordt dat een persoon niet meer woont op het adres waarop hij is ingeschreven in de BRP, 
  kan dit deel van het onderzoeksresultaat al worden opgenomen op de persoonslijst van de persoon. 
  Dit wordt gedaan door het zetten van aanduiding onderzoek 089999.
  Hiermee wordt geregistreerd dat is vastgesteld dat een persoon niet (langer) op het adres verblijft waarop hij ingeschreven staat, 
  maar dat het onderzoek naar het (nieuwe) woonadres nog loopt.
  Hierdoor kunnen eventuele problemen voor de nieuwe of oude medebewoners voorkomen worden.
  In de verblijfplaatshistorie leveren we dan de verblijfplaats met indicatieVastgesteldVerblijftNietOpAdres en datumVan is gelijk aan de datum ingang van het onderzoek.

  Wanneer onderzoek is afgesloten moet normaal gesproken worden aangenomen dat de resultaten van het onderzoek in de registratie zijn verwerkt.
  Het feit dat er een beëindigd onderzoek is met aanduiding vastgesteld geen bewoner meer (089999) kan dan worden genegeerd.
  
  Het kan echter voorkomen dat dit onderzoek wordt gesloten zonder dat het onderzoek inhoudelijk is afgerond. 
  Dit kan bijvoorbeeld gebeuren nadat de betreffende persoon zich inschrijft in een andere gemeente. 
  Deze andere gemeente zal of kan het onderzoek naar verblijf voor inschrijving in die gemeente vaak niet onderzoeken.
  Het onderzoek wordt dan in de registratie gesloten zonder dat is vastgesteld dat de registratie van verblijfplaatsen correct is.
  De aanduiding vastgesteld geen bewoner meer is dan nog steeds van belang, ook al is het onderzoek beëindigd.

  Wanneer onderzoek is beëindigd voor de datum aanvang van een volgend verblijf kunnen we zeker aannemen dat het onderzoek ook inhoudelijk afgerond is.
  Wanneer onderzoek is beëindigd op of na de datum aanvang van een volgend verblijf kunnen we niet met zekerheid zeggen of het onderzoek inhoudelijk afgerond is dan wel alleen administratie afgerond.
  In dat geval leveren we verblijftNietOpAdresVanaf met de datum dat vastgesteld verblijft niet op adres is vastgelegd.


    Achtergrond:
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | straatnaam (11.10) | huisnummer (11.20) |
      | 0800                 | Testpad            | 8                  |
      En adres 'A2' heeft de volgende gegevens
      | gemeentecode (92.10) | straatnaam (11.10) | huisnummer (11.20) |
      | 0800                 | Voorbeeldstraat    | 2                  |


  Rule: bij een lopend onderzoek met aanduiding 089999 of 589999 wordt verblijftNietOpAdresVanaf geleverd met als waarde de datum ingang van het onderzoek

    Abstract Scenario: er is vastgesteld dat de persoon niet meer op het adres verblijft en het onderzoek loopt nog en <omschrijving>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
      | 0800                              | 20211014                           | <aanduiding onderzoek>          | 20230516                       |
      Als verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2023-01-01          |
      | datumTot            | 2024-01-01          |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | type  | datumVan.type | datumVan.datum | datumVan.langFormaat | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving |
      | Adres | Datum         | 2021-10-14     | 14 oktober 2021      | 0800                         | Hoogeloon, Hapert en Casteren        |
      En heeft de verblijfplaats de volgende 'verblijftNietOpAdresVanaf' gegevens
      | naam        | waarde      |
      | type        | Datum       |
      | datum       | 2023-05-16  |
      | langFormaat | 16 mei 2023 |
      En heeft de verblijfplaats de volgende 'inOnderzoek' gegevens
      | naam                             | waarde      |
      | type                             | true        |
      | gemeenteVanInschrijving          | true        |
      | datumVan                         | true        |
      | nummeraanduidingIdentificatie    | true        |
      | adresseerbaarObjectIdentificatie | true        |
      | functieAdres                     | true        |
      | datumIngangOnderzoek.type        | Datum       |
      | datumIngangOnderzoek.datum       | 2023-05-16  |
      | datumIngangOnderzoek.langFormaat | 16 mei 2023 |
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
      | inOnderzoek.datumIngangOnderzoek.datum       | 2023-05-16  |
      | inOnderzoek.datumIngangOnderzoek.langFormaat | 16 mei 2023 |
      En heeft de verblijfplaats de volgende 'adressering' gegevens
      | naam                                         | waarde                        |
      | adresregel1                                  | Testpad 8                     |
      | adresregel2                                  | HOOGELOON, HAPERT EN CASTEREN |
      | inOnderzoek.adresregel1                      | true                          |
      | inOnderzoek.adresregel2                      | true                          |
      | inOnderzoek.datumIngangOnderzoek.type        | Datum                         |
      | inOnderzoek.datumIngangOnderzoek.datum       | 2023-05-16                    |
      | inOnderzoek.datumIngangOnderzoek.langFormaat | 16 mei 2023                   |

      Voorbeelden:
      | aanduiding onderzoek | datum van  | datum tot  | omschrijving                                       |
      | 089999               | 2023-01-01 | 2024-01-01 | periode overlapt de datum ingang van het onderzoek |
      | 589999               | 2022-01-01 | 2023-01-01 | periode ligt voor de start van het onderzoek       |


  Rule: bij een beëindigd onderzoek met aanduiding 089999 of 589999 en datum einde van het onderzoek ligt voor datum aanvang van het volgende verblijf worden verblijftNietOpAdresVanaf en het onderzoek niet geleverd

    Abstract Scenario: er is vastgesteld dat de persoon niet meer op het adres verblijft en het onderzoek is beëindigd voor datum aanvang van de volgende verblijfplaats in Nederland
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | datum einde onderzoek (83.30) |
      | 0800                              | 20211014                           | <aanduiding onderzoek>          | 20230516                       | 20230729                      |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20230730                           |
      Als verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2023-01-01          |
      | datumTot            | 2024-01-01          |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | type  | datumVan.type | datumVan.datum | datumVan.langFormaat | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving |
      | Adres | Datum         | 2023-07-30     | 30 juli 2023         | 0800                         | Hoogeloon, Hapert en Casteren        |
      En heeft de verblijfplaats de volgende 'verblijfadres' gegevens
      | naam            | waarde          |
      | korteStraatnaam | Voorbeeldstraat |
      | huisnummer      | 2               |
      En heeft de verblijfplaats de volgende 'adressering' gegevens
      | naam        | waarde                        |
      | adresregel1 | Voorbeeldstraat 2             |
      | adresregel2 | HOOGELOON, HAPERT EN CASTEREN |
      En heeft de response verblijfplaatsen met de volgende gegevens
      | type  | datumVan.type | datumVan.datum | datumVan.langFormaat | datumTot.type | datumTot.datum | datumTot.langFormaat | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving |
      | Adres | Datum         | 2021-10-14     | 14 oktober 2021      | Datum         | 2023-07-30     | 30 juli 2023         | 0800                         | Hoogeloon, Hapert en Casteren        |
      En heeft de verblijfplaats de volgende 'verblijfadres' gegevens
      | naam            | waarde  |
      | korteStraatnaam | Testpad |
      | huisnummer      | 8       |
      En heeft de verblijfplaats de volgende 'adressering' gegevens
      | naam        | waarde                        |
      | adresregel1 | Testpad 8                     |
      | adresregel2 | HOOGELOON, HAPERT EN CASTEREN |

      Voorbeelden:
      | aanduiding onderzoek |
      | 089999               |
      | 589999               |

    Abstract Scenario: er is vastgesteld dat de persoon niet meer op het adres verblijft en het onderzoek is beëindigd voor datum vertrek met onbekende verblijfplaats
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | datum einde onderzoek (83.30) |
      | 0800                              | 20211014                           | <aanduiding onderzoek>          | 20230516                       | 20230729                      |
      En de persoon is vervolgens ingeschreven op een buitenlands adres met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adres buitenland (13.20) | land adres buitenland (13.10) |
      | 1999                              | 20230730                               | 0000                          |
      Als verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2023-01-01          |
      | datumTot            | 2024-01-01          |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | type                   | datumVan.type | datumVan.datum | datumVan.langFormaat |
      | VerblijfplaatsOnbekend | Datum         | 2023-07-30     | 30 juli 2023         |
      En heeft de response verblijfplaatsen met de volgende gegevens
      | type  | datumVan.type | datumVan.datum | datumVan.langFormaat | datumTot.type | datumTot.datum | datumTot.langFormaat | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving |
      | Adres | Datum         | 2021-10-14     | 14 oktober 2021      | Datum         | 2023-07-30     | 30 juli 2023         | 0800                         | Hoogeloon, Hapert en Casteren        |
      En heeft de verblijfplaats de volgende 'verblijfadres' gegevens
      | naam            | waarde  |
      | korteStraatnaam | Testpad |
      | huisnummer      | 8       |
      En heeft de verblijfplaats de volgende 'adressering' gegevens
      | naam        | waarde                        |
      | adresregel1 | Testpad 8                     |
      | adresregel2 | HOOGELOON, HAPERT EN CASTEREN |

      Voorbeelden:
      | aanduiding onderzoek |
      | 089999               |
      | 589999               |


  Rule: bij een beëindigd onderzoek met aanduiding 089999 of 589999 en datum einde van het onderzoek ligt op of na datum aanvang van het volgende verblijf wordt verblijftNietOpAdresVanaf geleverd met als waarde de datum ingang van het onderzoek

    Abstract Scenario: er is vastgesteld dat de persoon niet meer op het adres verblijft en het onderzoek is beëindigd <op of na> datum aanvang van de volgende verblijfplaats in Nederland
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | datum einde onderzoek (83.30) |
      | 0800                              | 20211014                           | <aanduiding onderzoek>          | 20230516                       | <datum einde onderzoek>       |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20230730                           |
      Als verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2023-01-01          |
      | datumTot            | 2024-01-01          |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | type  | datumVan.type | datumVan.datum | datumVan.langFormaat | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving |
      | Adres | Datum         | 2023-07-30     | 30 juli 2023         | 0800                         | Hoogeloon, Hapert en Casteren        |
      En heeft de verblijfplaats de volgende 'verblijfadres' gegevens
      | naam            | waarde          |
      | korteStraatnaam | Voorbeeldstraat |
      | huisnummer      | 2               |
      En heeft de verblijfplaats de volgende 'adressering' gegevens
      | naam        | waarde                        |
      | adresregel1 | Voorbeeldstraat 2             |
      | adresregel2 | HOOGELOON, HAPERT EN CASTEREN |
      En heeft de response verblijfplaatsen met de volgende gegevens
      | type  | datumVan.type | datumVan.datum | datumVan.langFormaat | datumTot.type | datumTot.datum | datumTot.langFormaat | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving |
      | Adres | Datum         | 2021-10-14     | 14 oktober 2021      | Datum         | 2023-07-30     | 30 juli 2023         | 0800                         | Hoogeloon, Hapert en Casteren        |
      En heeft de verblijfplaats de volgende 'verblijftNietOpAdresVanaf' gegevens
      | naam        | waarde      |
      | type        | Datum       |
      | datum       | 2023-05-16  |
      | langFormaat | 16 mei 2023 |
      En heeft de verblijfplaats de volgende 'verblijfadres' gegevens
      | naam            | waarde  |
      | korteStraatnaam | Testpad |
      | huisnummer      | 8       |
      En heeft de verblijfplaats de volgende 'adressering' gegevens
      | naam        | waarde                        |
      | adresregel1 | Testpad 8                     |
      | adresregel2 | HOOGELOON, HAPERT EN CASTEREN |

      Voorbeelden:
      | aanduiding onderzoek | op of na | datum einde onderzoek |
      | 089999               | op       | 20230730              |
      | 589999               | op       | 20230730              |
      | 089999               | na       | 20230731              |
      | 589999               | na       | 20230731              |

    Abstract Scenario: er is vastgesteld dat de persoon niet meer op het adres verblijft en het onderzoek is beëindigd na datum vertrek met onbekende verblijfplaats en periode ligt voor de start van het onderzoek
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | datum einde onderzoek (83.30) |
      | 0800                              | 20211014                           | <aanduiding onderzoek>          | 20230516                       | <datum einde onderzoek>       |
      En de persoon is vervolgens ingeschreven op een buitenlands adres met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adres buitenland (13.20) | land adres buitenland (13.10) |
      | 1999                              | 20230730                               | 0000                          |
      Als verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2022-01-01          |
      | datumTot            | 2023-01-01          |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | type  | datumVan.type | datumVan.datum | datumVan.langFormaat | datumTot.type | datumTot.datum | datumTot.langFormaat | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving |
      | Adres | Datum         | 2021-10-14     | 14 oktober 2021      | Datum         | 2023-07-30     | 30 juli 2023         | 0800                         | Hoogeloon, Hapert en Casteren        |
      En heeft de verblijfplaats de volgende 'verblijftNietOpAdresVanaf' gegevens
      | naam        | waarde      |
      | type        | Datum       |
      | datum       | 2023-05-16  |
      | langFormaat | 16 mei 2023 |
      En heeft de verblijfplaats de volgende 'verblijfadres' gegevens
      | naam            | waarde  |
      | korteStraatnaam | Testpad |
      | huisnummer      | 8       |
      En heeft de verblijfplaats de volgende 'adressering' gegevens
      | naam        | waarde                        |
      | adresregel1 | Testpad 8                     |
      | adresregel2 | HOOGELOON, HAPERT EN CASTEREN |

      Voorbeelden:
      | aanduiding onderzoek | op of na | datum einde onderzoek |
      | 089999               | op       | 20230730              |
      | 589999               | op       | 20230730              |
      | 089999               | na       | 20230731              |
      | 589999               | na       | 20230731              |


  Rule: bij een beëindigd onderzoek met aanduiding 089999 of 589999 op de actuele verblijfplaats wordt het onderzoek niet geleverd

    Scenario: er is vastgesteld dat de persoon niet meer op het adres verblijft en het onderzoek is beëindigd en er is geen volgende verblijfplaats
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | datum einde onderzoek (83.30) |
      | 0800                              | 20211014                           | <aanduiding onderzoek>          | 20230516                       | 20230730                      |
      Als verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2023-01-01          |
      | datumTot            | 2024-01-01          |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | type  | datumVan.type | datumVan.datum | datumVan.langFormaat | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving |
      | Adres | Datum         | 2021-10-14     | 14 oktober 2021      | 0800                         | Hoogeloon, Hapert en Casteren        |
      En heeft de verblijfplaats de volgende 'verblijfadres' gegevens
      | naam            | waarde  |
      | korteStraatnaam | Testpad |
      | huisnummer      | 8       |
      En heeft de verblijfplaats de volgende 'adressering' gegevens
      | naam        | waarde                        |
      | adresregel1 | Testpad 8                     |
      | adresregel2 | HOOGELOON, HAPERT EN CASTEREN |

      Voorbeelden:
      | aanduiding onderzoek |
      | 089999               |
      | 589999               |
    
  Rule: vastgesteld verblijft niet op adres op de volgende verblijfplaats wordt niet geleverd
    De aanduiding onderzoek vastgesteld verblijft niet langer op adres kan nooit betrekking hebben op de datum aanvang van dat adres,
    en dus kan het geen betrekking hebben op de datum tot van het vorige verblijf.

    Scenario: er is vastgesteld dat de persoon niet meer op het adres verblijft en de periode valt in het vorige verblijf
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20211014                           |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
      | 0800                              | 20230730                           | 089999                          | 20230516                       |
      Als verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2022-01-01          |
      | datumTot            | 2023-01-01          |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | type  | datumVan.type | datumVan.datum | datumVan.langFormaat | datumTot.type | datumTot.datum | datumTot.langFormaat | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving |
      | Adres | Datum         | 2021-10-14     | 14 oktober 2021      | Datum         | 2023-07-30     | 30 juli 2023         | 0800                         | Hoogeloon, Hapert en Casteren        |
      En heeft de verblijfplaats de volgende 'verblijfadres' gegevens
      | naam            | waarde  |
      | korteStraatnaam | Testpad |
      | huisnummer      | 8       |
      En heeft de verblijfplaats de volgende 'adressering' gegevens
      | naam        | waarde                        |
      | adresregel1 | Testpad 8                     |
      | adresregel2 | HOOGELOON, HAPERT EN CASTEREN |
