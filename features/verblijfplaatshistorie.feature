# language: nl

Functionaliteit: Tonen van historishe en actuele verblijfplaatsen

  Huidige en vorige verblijfplaatsen van ingeschreven personen kunnen worden opgezocht.
  Filteren op peildatum of periode wordt gedaan op basis van de datum aanvang adreshouding van de verblijfplaats(en).
  Historische voorkomens die onjuist zijn worden niet opgenomen in het antwoord.
  Wanneer verblijfplaatshistorie wordt samengesteld op basis van een GBA-V bevraging, en het autorisatieprofiel geeft geen toegang tot datum ingang geldigheid, dan wordt steeds het eerste (bovenste) voorkomen gebruikt, wanneer er meerdere voorkomens zijn met exact dezelfde datum aanvang adreshouding.

  Bij het zoeken wordt door de gba-bevraging altijd de eerstvolgende verblijfplaats die na de datumTotEnMet ligt opgehaald om de datumTot van de laatste verblijfplaats binnen de periode te kunnen bepalen.

  De verblijfplaatsen worden in het antwoord aflopend gesorteerd op datum aanvang adreshouding, zodat de meest actuele bovenaan staat. --> is dit nog steeds zo ? Json is toch volgorde onafhankelijk ?


  Achtergrond:
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | burgerservicenummer |
    | 999994669           |
    | 999992338           |
    | 999993483           |
    | 999990378           |
    | 999990263           |
    En het systeem heeft personen met de volgende 'verblijfplaats' gegevens
    | burgerservicenummer | Categorie | Datum aanvang adreshouding | Datum aanvang adres buitenland | Datum ingang geldigheid | Straat              | Huisnummer | Land | Onderzoek | Datum ingang onderzoek | Datum einde onderzoek |
    | 999994669           | 8         | 19940508                   | -                              | 20110205                | Beethovenlaan       | 23         | 6030 | -         | -                      | -                     |
    | 999994669           | 58        | 19940508                   | -                              | 19940508                | Beethovenlaan       | 5          | 6030 | -         | -                      | -                     |
    | 999994669           | 58        | 19930910                   | -                              | 19930910                | Kerkstraat          | 83         | 6030 | -         | -                      | -                     |
    | 999994669           | 58        | -                          | 19930215                       | 19930215                | -                   | -          | 5010 | -         | -                      | -                     |
    | 999994669           | 58        | 19611230                   | -                              | 19611230                | Javaplein           | 11         | 6030 | -         | -                      | -                     |
    | 999992338           | 58        | -                          | 19960000                       | 19960000                | -                   | -          | 5010 | -         | -                      | -                     |
    | 999992338           | 8         | 20010508                   | -                              | 20010508                | Leyweg              | 61         | 6030 | -         | -                      | -                     |
    | 999993483           | 8         | 20120305                   | -                              | 20120305                | Zonegge             | 27         | 6030 | -         | -                      | -                     |
    | 999993483           | 58        | 00000000                   | -                              | 00000000                | Leyweg              | 61         | 6030 | -         | -                      | -                     |
    | 999990378           | 8         | 20150601                   | -                              | -                       | Rietzangerstraat    | 20         | 6030 | -         | -                      | -                     |
    | 999990378           | 58        | 19881118                   | -                              | -                       | Voorhofdreef        | 30         | 6030 | 580000    | 19881120               | -                     |
    | 999990263           | 8         | 20150601                   | -                              | -                       | Rapheëlstraat       | 1          | 6030 | -         | -                      | 20120305              |
    | 999990263           | 58        | 19890501                   | -                              | -                       | Oudegracht          | 380        | 6030 | 580000    | -                      | 19920102              |
    | 999990451           | 8         | 20130301                   | -                              | 20130302                | Chilidreef          | 14         | 6030 | -         | -                      |                       |
    | 999990451           | 58        | 19890000                   | -                              | 20120302                | Dennestraat         | 35         | 6030 | -         | -                      |                       |
    | 999990762           | 8         | 20140203                   | -                              | 20140203                | Jan Provostlaan     | 172        | 6030 | -         | -                      |                       |
    | 999990762           | 58        | 19891000                   | -                              | 19930203                | Cypresstraat        | 14         | 6030 | -         | -                      |                       |


Rule: Bij het zoeken is de peildatum verplicht of zijn de datumVan en datumTotEnMet verplicht.

  @fout-case
  Scenario: Verblijfplaats raadplegen zonder peildatum of periode
    Als verblijfplaatshistorie wordt geraadpleegd met de volgende parameters
    | naam                | waarde             |
    | type                | RaadpleegMetPeriode|
    | burgerservicenummer | 999994669          |
    | fields              | datumVan, datumTot, datumIngangGeldigheid, adresregel1, land.code     |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Minimale combinatie van parameters moet worden opgegeven.   |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: datumVan, datumTotEnMet      |
    | code     | paramsCombination                                           |
    | instance | /haalcentraal/api/brp/verblijfplaatshistorie                |
    En heeft het object de volgende 'invalidParams' gegevens
    | code     | name          | reason                  |
    | required | datumVan      | Parameter is verplicht. |
    | required | datumTotEnMet | Parameter is verplicht. |

  @fout-case
  Scenario: Verblijfplaats raadplegen met lege peildatum
    Als verblijfplaatshistorie wordt geraadpleegd met de volgende parameters
    | naam                | waarde               |
    | type                | RaadpleegMetPeildatum|
    | burgerservicenummer | 999994669            |
    | fields              | datumVan, datumTot, datumIngangGeldigheid, adresregel1, land.code |
    | peildatum           | -                    |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Minimale combinatie van parameters moet worden opgegeven.   |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: peildatum                    |
    | code     | paramsCombination                                           |
    | instance | /haalcentraal/api/brp/verblijfplaatshistorie                |
    En heeft het object de volgende 'invalidParams' gegevens
    | code     | name          | reason                  |
    | required | peildatum     | Parameter is verplicht. |

  @fout-case
  Abstract Scenario: Verblijfplaats raadplegen met invalide peildatum
    Als verblijfplaatshistorie wordt geraadpleegd met de volgende parameters
    | naam                | waarde               |
    | type                | RaadpleegMetPeildatum|
    | burgerservicenummer | 999994669            |
    | fields              | datumVan, datumTot, datumIngangGeldigheid, adresregel1, land.code |
    | peildatum           | <peildatum>          |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: peildatum                    |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/brp/verblijfplaatshistorie                |
    En heeft het object de volgende 'invalidParams' gegevens
    | code | name          | reason                        |
    | date | peildatum     | Waarde is geen geldige datum. |

    Voorbeelden:
    | peildatum     |
    | 19830526      |
    | 26 mei 2014   |

Rule: Bij het zoeken is het burgerservicenummer verplicht.

  @fout-case
  Scenario: Verblijfplaats raadplegen zonder burgerservicenummer
    Als verblijfplaatshistorie wordt geraadpleegd met de volgende parameters
    | naam                | waarde                |
    | type                | RaadpleegMetPeildatum |
    | burgerservicenummer | -                     |
    | fields              | datumVan, datumTot, datumIngangGeldigheid, adresregel1, land.code     |
    | peildatum           | 2012-02-03            |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Minimale combinatie van parameters moet worden opgegeven.   |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: burgerservicenummer          |
    | code     | paramsCombination                                           |
    | instance | /haalcentraal/api/brp/verblijfplaatshistorie                |
    En heeft het object de volgende 'invalidParams' gegevens
    | code     | name                | reason                  |
    | required | burgerservicenummer | Parameter is verplicht. |


  @gba
    Scenario: Verblijfplaats opvragen met een recente peildatum
      Als verblijfplaatshistorie wordt geraadpleegd met de volgende parameters
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 999994669             |
      | fields              | datumVan, datumTot, datumIngangGeldigheid, adresregel1, land.code |
      | peildatum           | 2022-03-03            |
      Dan heeft de response een verblijfplaats met de volgende gegevens
      | datumAanvangAdreshouding   | datumAanvangAdresBuitenland    | datumIngangGeldigheid   | Straat        | Huisnummer   | Land.code   |
      | 19940508                   | -                              | 20110205                | Beethovenlaan | 23           | 6030        |

  @proxy
    Scenario: Verblijfplaats opvragen met een recente peildatum
      Als verblijfplaatshistorie wordt geraadpleegd met de volgende parameters
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 999994669             |
      | fields              | datumVan, datumTot, datumIngangGeldigheid, adresregel1, land.code |
      | peildatum           | 2022-03-03            |
      Dan heeft de response een verblijfplaats met de volgende gegevens
      | datumVan.datum | datumVan.type | datumVan.onbekend | datumTot.datum | datumTot.type | datumIngangGeldigheid.datum | datumIngangGeldigheid.type | datumIngangGeldigheid.onbekend | Adresregel1      | Land.code |
      | 1994-05-08     | Datum         | -                 | -              | -             | 2011-02-05                  | Datum                      | -                              | Beethovenlaan 23 | 6030      |

  @gba
    Scenario: Verblijfplaats opvragen met een recente peildatum, burger heeft een verblijfplaats met DatumAanvangHuishouding = 00000000
      Als verblijfplaatshistorie wordt geraadpleegd met de volgende parameters
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 999993483             |
      | fields              | datumVan, datumTot, datumIngangGeldigheid, adresregel1, land.code |
      | peildatum           | 2012-04-05            |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | datumAanvangAdreshouding   | datumAanvangAdresBuitenland    | datumIngangGeldigheid   | Straat        | Huisnummer   | Land.code   |
      | 20120305                   | -                              | 20120305                | Zonegge       | 27           | 6030        |

  @proxy
    Scenario: Verblijfplaats opvragen met een recente peildatum, burger heeft een verblijfplaats met DatumAanvangHuishouding = 00000000
      Als verblijfplaatshistorie wordt geraadpleegd met de volgende parameters
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 999993483             |
      | fields              | datumVan, datumTot, datumIngangGeldigheid, adresregel1, land.code |
      | peildatum           | 2012-04-05            |
      Dan heeft de response een verblijfplaats met de volgende gegevens
      | datumVan.datum | datumVan.type | datumVan.onbekend | datumTot.datum | datumTot.type | datumIngangGeldigheid.datum | datumIngangGeldigheid.type | datumIngangGeldigheid.onbekend | Adresregel1      | Land.code |
      | 2012-03-05     | Datum         | -                 | -              | -             | 2012-03-05                  | Datum                      | -                              | Zonegge27        | 6030      |

  @gba
    Scenario: Verblijfplaats opvragen met een recente peildatum, burger heeft een verblijfplaats met DatumAanvangHuishouding = 00000000
      Als verblijfplaatshistorie wordt geraadpleegd met de volgende parameters
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 999993483             |
      | fields              | datumVan, datumTot, datumIngangGeldigheid, adresregel1, land.code |
      | peildatum           | 1853-07-30            |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | datumAanvangAdreshouding   | datumAanvangAdresBuitenland    | datumIngangGeldigheid   | Straat        | Huisnummer   | Land.code   |
      | 20120305                   | -                              | 20120305                | Zonegge       | 27           | 6030        |
      | 00000000                   | -                              | 00000000                | Leyweg        | 61           | 6030        |

  @proxy
    Scenario: Verblijfplaats opvragen met een recente peildatum, burger heeft een verblijfplaats met DatumAanvangHuishouding = 00000000
      Als verblijfplaatshistorie wordt geraadpleegd met de volgende parameters
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 999993483             |
      | fields              | datumVan, datumTot, datumIngangGeldigheid, adresregel1, land.code |
      | peildatum           | 1853-07-30            |
      Dan heeft de response een verblijfplaats met de volgende gegevens
      | datumVan.datum | datumVan.type | datumVan.onbekend | datumTot.datum | datumTot.type | datumIngangGeldigheid.datum | datumIngangGeldigheid.type | datumIngangGeldigheid.onbekend | Adresregel1      | Land.code |
      | 2012-03-05     | Datum         | -                 | -              | -             | 2012-03-05                  | Datum                      | -                              | Zonegge 27       | 6030      |
      | -              | DatumOnbekend | true              | 2012-03-05     | Datum         | -                           | DatumOnbekend              | -                              | Leyweg 61        | 6030      |

    Scenario: Verblijfplaats opvragen met een peildatum ver in het verleden
      Als verblijfplaatshistorie wordt geraadpleegd met de volgende parameters
      | naam                | waarde               |
      | type                | RaadpleegMetPeildatum|
      | burgerservicenummer | 999994669            |
      | fields              | datumVan, datumTot, datumIngangGeldigheid, adresregel1, land.code |
      | peildatum           | 1961-12-29           |
      Dan heeft de response geen verblijfplaatsen

    @gba
      Scenario: Verblijfplaats opvragen met een recente peildatum, buitenlandse verblijfplaats
        Als verblijfplaatshistorie wordt geraadpleegd met de volgende parameters
        | naam                | waarde                |
        | type                | RaadpleegMetPeildatum |
        | burgerservicenummer | 999994669             |
        | fields              | datumVan, datumTot, datumIngangGeldigheid, adresregel1, land.code |
        | peildatum           | 1993-07-01            |
        Dan heeft de response verblijfplaatsen met de volgende gegevens
        | datumAanvangAdreshouding   | datumAanvangAdresBuitenland    | datumIngangGeldigheid   | Straat        | Huisnummer   | Land.code   |
        | 19930910                   | -                              | 19930910                | Kerkstraat    | 83           | 6030        |
        | -                          | 19930215                       | 19930215                | -             | -            | 5010        |

    @gba
      Scenario: Verblijfplaats opvragen met een recente peildatum, adres gecorrigeerd
        Als verblijfplaatshistorie wordt geraadpleegd met de volgende parameters
        | naam                | waarde                |
        | type                | RaadpleegMetPeildatum |
        | burgerservicenummer | 999994669             |
        | fields              | datumVan, datumTot, datumIngangGeldigheid, adresregel1, land.code |
        | peildatum           | 1994-05-07            |
        Dan heeft de response verblijfplaatsen met de volgende gegevens
        | datumAanvangAdreshouding   | datumAanvangAdresBuitenland    | datumIngangGeldigheid   | Straat        | Huisnummer   | Land.code   |
        | 19940508                   | -                              | 20110205                | Beethovenlaan | 23           | 6030        |
        | 19940508                   | -                              | 19940508                | Beethovenlaan | 5            | 6030        |      --> Dit is ng even een vraag of die dan geleverd moet worden.
        | 19930910                   | -                              | 19930910                | Kerkstraat    | 83           | 6030        |

Rule : Bij een historische verblijfplaats wordt een datumTot opgenomen, die gelijk is aan de datum aanvang adreshouding van de daarop volgende (actuele of historische) verblijfplaats.

    @proxy
      Scenario: Verblijfplaats opvragen met een recente peildatum, adres gecorrigeerd
        Als verblijfplaatshistorie wordt geraadpleegd met de volgende parameters
        | naam                | waarde                |
        | type                | RaadpleegMetPeildatum |
        | burgerservicenummer | 999994669             |
        | fields              | datumVan, datumTot, datumIngangGeldigheid, adresregel1, land.code |
        | peildatum           | 1994-05-07            |
        Dan heeft de response verblijfplaatsen met de volgende gegevens
        | datumVan.datum | datumVan.type | datumVan.onbekend | datumTot.datum | datumTot.type | datumIngangGeldigheid.datum | datumIngangGeldigheid.type | datumIngangGeldigheid.onbekend | Adresregel1      | Land.code |
        | 1993-09-10     | Datum         |                   | 1994-05-08     | Datum         | 1993-09-10                  | Datum                      | -                              | Kerkstraat 83    | 6030      |

    @proxy
      Scenario: Verblijfplaats opvragen met een recente peildatum, burger heeft een verblijfplaats met DatumAanvangHuishouding = 00000000
        Als verblijfplaatshistorie wordt geraadpleegd met de volgende parameters
        | naam                | waarde                |
        | type                | RaadpleegMetPeildatum |
        | burgerservicenummer | 999993483             |
        | fields              | datumVan, datumTot, datumIngangGeldigheid, adresregel1, land.code |
        | peildatum           | 1853-07-30            |
        Dan heeft de response een verblijfplaats met de volgende gegevens
        | datumVan.datum | datumVan.type | datumVan.onbekend | datumTot.datum | datumTot.type | datumIngangGeldigheid.datum | datumIngangGeldigheid.type | datumIngangGeldigheid.onbekend | Adresregel1      | Land.code |
        | 2012-03-05     | Datum         | -                 | -              | -             | 2012-03-05                  | Datum                      | -                              | Zonegge 27       | 6030      |
        | -              | DatumOnbekend | true              | 2012-03-05     | Datum         | -                           | DatumOnbekend              | -                              | Leyweg 61        | 6030      |


Rule: Wanneer een verblijfplaats een buitenlands adres betreft, wordt datumAanvangAdreshouding gevuld met de waarde in Datum aanvang adres buitenland (element 13.20).
        In dit geval wordt ook de sortering in het antwoord, de filtering op peildatum of periode, en het afleiden van de datumTot bepaald op basis van Datum aanvang adres buitenland (element 13.20).


  @proxy
    Scenario: Verblijfplaats opvragen met een recente peildatum, buitenlandse verblijfplaats
      Als verblijfplaatshistorie wordt geraadpleegd met de volgende parameters
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 999994669             |
      | fields              | datumVan, datumTot, datumIngangGeldigheid, adresregel1, land.code |
      | peildatum           | 1993-07-01            |
      Dan heeft de response een verblijfplaats met de volgende gegevens
      | datumVan.datum | datumVan.type | datumVan.onbekend | datumTot.datum | datumTot.type | datumIngangGeldigheid.datum | datumIngangGeldigheid.type | datumIngangGeldigheid.onbekend | Adresregel1      | Land.code |
      | 1993-09-10     | Datum         | -                 | -              | -             | 1993-09-10                  | Datum                      | -                              | Kerkstraat 83    | 6030      |
      | 1993-02-15     | Datum         | -                 | 1993-09-10     | Datum         | 1993-02-15                  | Datum                      | -                              | -                | 5010      |



Rule: Er kunnen verblijfplaatsen van een persoon geraadpleegd worden binnen een specifieke periode.
Rule: Op periode gefilterde gegevens tonen alle verblijfplaatsen waar de persoon gedurende de periode heeft verbleven.
        - Ook wanneer de persoon al voor de periode op een verblijfplaats verbleef en binnen (een deel van) de gevraagde periode nog steeds,
          wordt de verblijfplaats opgenomen in het antwoord.
        - Ook wanneer de persoon tijdens (een deel van) de periode op een verblijfplaats verbleef en na de gevraagde periode nog steeds,
          wordt de verblijfplaats opgenomen in het antwoord.

    Scenario: Geen verblijfplaatsen in gevraagde periode
    Als verblijfplaatshistorie wordt geraadpleegd met de volgende parameters
    | naam                | waarde               |
    | type                | RaadpleegMetPeriode  |
    | burgerservicenummer | 999990378            |
    | fields              | datumVan, datumTot, datumIngangGeldigheid, adresregel1, land.code |
    | datumVan            | 1961-07-01           |
    | datumTotEnMet       | 1972-01-01           |
    Dan heeft de response geen verblijfplaatsen

  @gba
    Scenario: Verblijfplaatsen opvragen in een periode
    Als verblijfplaatshistorie wordt geraadpleegd met de volgende parameters
    | naam                | waarde               |
    | type                | RaadpleegMetPeriode  |
    | burgerservicenummer | 999994669            |
    | fields              | datumVan, datumTot, datumIngangGeldigheid, adresregel1, land.code |
    | datumVan            | 1961-07-01           |
    | datumTotEnMet       | 2019-09-11           |
    Dan heeft de response verblijfplaatsen met de volgende gegevens
    | datumAanvangAdreshouding | datumAanvangAdresBuitenland | datumIngangGeldigheid | Straat        | Huisnummer | Land.code |
    | 19940508                 | -                           | 20110205              | Beethovenlaan | 23         | 6030      |
    | 19940508                 | -                           | 19940508              | Beethovenlaan | 5          | 6030      |    --> Wordt deze geleverd door de GBA-variant ???
    | 19930910                 | -                           | 19930910              | Kerkstraat    | 83         | 6030      |
    |                          | 19930215                    | 19930215              | -             | -          | 5010      |
    | 19611230                 | -                           | 19611230              | Javaplein     | 11         | 6030      |

  @proxy
    Scenario: Verblijfplaatsen opvragen in een periode
    Als verblijfplaatshistorie wordt geraadpleegd met de volgende parameters
    | naam                | waarde               |
    | type                | RaadpleegMetPeriode  |
    | burgerservicenummer | 999994669            |
    | fields              | datumVan, datumTot, datumIngangGeldigheid, adresregel1, land.code |
    | datumVan            | 1961-07-01         |
    | datumTotEnMet       | 2019-09-11           |
    Dan heeft de response verblijfplaatsen met de volgende gegevens
    | datumVan.datum | datumVan.type | datumVan.onbekend | datumTot.datum | datumTot.type | datumIngangGeldigheid.datum | datumIngangGeldigheid.type | datumIngangGeldigheid.onbekend | Adresregel1      | Land.code |
    | 1994-05-08     | Datum         | -                 | -              | -             | 2011-02-05                  | Datum                      | -                              | Beethovenlaan 23 | 6030      |
    | 1993-09-10     | Datum         | -                 | 1994-05-08     | Datum         | 1993-09-10                  | Datum                      | -                              | Kerkstraat 83    | 6030      |
    | 1993-02-15     | Datum         | -                 | 1993-09-10     | Datum         | 1993-02-15                  | Datum                      | -                              |                  | 5010      |
    | 1961-12-30     | Datum         | -                 | 1993-02-15     | Datum         | 1961-12-30                  | Datum                      | -                              | Javaplein 11     | 6030      |

Rule   Wanneer in de registratie voor de persoon meer dan één verblijfplaats, actueel (categorie 8) of historisch (categorie 58), bevat met exact
       dezelfde datum aanvang adreshouding, dan wordt alleen het voorkomen met de meest recente datum ingang geldigheid opgenomen.
          - Dit speelt bijvoorbeeld wanneer er een correctie is uitgevoerd op de verblijfplaats, of wanneer er een adres hernummering is gedaan.
  @gba
    Scenario: Verblijfplaatsen opvragen in een periode, datumVan ligt na de meest recente datumIngangGeldigheid
    Als verblijfplaatshistorie wordt geraadpleegd met de volgende parameters
    | naam                | waarde               |
    | type                | RaadpleegMetPeriode  |
    | burgerservicenummer | 999994669            |
    | fields              | datumVan, datumTot, datumIngangGeldigheid, adresregel1, land.code |
    | datumVan            | 2012-01-01           |
    | datumTotEnMet       | 2019-09-11           |
    Dan heeft de response een verblijfplaats met de volgende gegevens
    | datumAanvangAdreshouding | datumIngangGeldigheid | Straat        | Huisnummer | Land.code |
    | 19940508                 | 20110205              | Beethovenlaan | 23         | 6030      |

  @proxy
    Scenario: Verblijfplaatsen opvragen in een periode, datumVan ligt na de meest recente datumIngangGeldigheid
    Als verblijfplaatshistorie wordt geraadpleegd met de volgende parameters
    | naam                | waarde               |
    | type                | RaadpleegMetPeriode  |
    | burgerservicenummer | 999994669            |
    | fields              | datumVan, datumTot, datumIngangGeldigheid, adresregel1, land.code |
    | datumVan            | 2012-01-01           |
    | datumTotEnMet       | 2019-09-11           |
    Dan heeft de response een verblijfplaats met de volgende gegevens
    | datumVan.datum | datumVan.type | datumVan.onbekend | datumTot.datum | datumTot.type | datumIngangGeldigheid.datum | datumIngangGeldigheid.type | datumIngangGeldigheid.onbekend | Adresregel1      | Land.code |
    | 1994-05-08     | Datum         | -                 | -              | -             | 2011-02-05                  | Datum                      | -                              | Beethovenlaan 23 | 6030      |


  @gba
    Scenario: Verblijfplaatsen opvragen in een periode, datumVan ligt voor de meest recente datumIngangGeldigheid
    Als verblijfplaatshistorie wordt geraadpleegd met de volgende parameters
    | naam                | waarde               |
    | type                | RaadpleegMetPeriode  |
    | burgerservicenummer | 999994669            |
    | fields              | datumVan, datumTot, datumIngangGeldigheid, adresregel1, land.code |
    | datumVan            | 1995-01-01           |
    | datumTotEnMet       | 1996-01-01           |
    Dan heeft de response een verblijfplaats met de volgende gegevens
    | datumAanvangAdreshouding | datumIngangGeldigheid | Straat        | Huisnummer | Land.code |
    | 19940508                 | 20110205              | Beethovenlaan | 23         | 6030      |

  @proxy
    Scenario: Verblijfplaatsen opvragen in een periode, datumVan ligt voor de meest recente datumIngangGeldigheid
    Als verblijfplaatshistorie wordt geraadpleegd met de volgende parameters
    | naam                | waarde               |
    | type                | RaadpleegMetPeriode  |
    | burgerservicenummer | 999994669            |
    | fields              | datumVan, datumTot, datumIngangGeldigheid, adresregel1, land.code |
    | datumVan            | 1995-01-01           |
    | datumTotEnMet       | 1996-01-01           |
    Dan heeft de response een verblijfplaats met de volgende gegevens
    | datumVan.datum | datumVan.type | datumVan.onbekend | datumTot.datum | datumTot.type | datumIngangGeldigheid.datum | datumIngangGeldigheid.type | datumIngangGeldigheid.onbekend | Adresregel1      | Land.code |
    | 1994-05-08     | Datum         | -                 | -              | -             | 2011-02-05                  | Datum                      | -                              | Beethovenlaan 23 | 6030      |

  @gba
    Scenario: Verblijfplaatsen opvragen in een periode, datumTotEnMet ligt voor de meest recente datumIngangGeldigheid van een verblijfplaats
    Als verblijfplaatshistorie wordt geraadpleegd met de volgende parameters
    | naam                | waarde               |
    | type                | RaadpleegMetPeriode  |
    | burgerservicenummer | 999994669            |
    | fields              | datumVan, datumTot, datumIngangGeldigheid, adresregel1, land.code |
    | datumVan            | 1993-10-01           |
    | datumTotEnMet       | 1994-01-01           |
    Dan heeft de response een verblijfplaats met de volgende gegevens
    | datumAanvangAdreshouding | datumIngangGeldigheid | Straat        | Huisnummer | Land.code |
    | 19940508                 | 20110205              | Beethovenlaan | 23         | 6030      |
    | 19930910                 | 19930910              | Kerkstraat    | 83         | 6030      |

  @proxy
    Scenario: Verblijfplaatsen opvragen in een periode, datumTotEnMet ligt voor de meest recente datumIngangGeldigheid van een verblijfplaats
    Als verblijfplaatshistorie wordt geraadpleegd met de volgende parameters
    | naam                | waarde               |
    | type                | RaadpleegMetPeriode  |
    | burgerservicenummer | 999994669            |
    | fields              | datumVan, datumTot, datumIngangGeldigheid, adresregel1, land.code |
    | datumVan            | 1993-10-01           |
    | datumTotEnMet       | 1994-01-01           |
    Dan heeft de response een verblijfplaats met de volgende gegevens
    | datumVan.datum | datumVan.type | datumVan.onbekend | datumTot.datum | datumTot.type | datumIngangGeldigheid.datum | datumIngangGeldigheid.type | datumIngangGeldigheid.onbekend | Adresregel1      | Land.code |
    | 1994-05-08     | Datum         | -                 | -              | -             | 2011-02-05                  | Datum                      | -                              | Beethovenlaan 23 | 6030      |
    | 1993-09-10     | Datum         | -                 | 1994-05-08     | Datum         | 1993-09-10                  | Datum                      | -                              | Kerkstraat 83    | 6030      |

Rule: Wanneer de datum aanvang gedeeltelijk onbekend is, wordt voor de filtering aangenomen dat de persoon gedurende de gehele onzekerheidstijd
      op het adres heeft verbleven.
        - Wanneer van de datum aanvang adreshouding alleen het jaar bekend is, wordt aangenomen dat de persoon het hele jaar op deze verblijfplaats heeft verbleven.

  @gba
    Scenario: Verblijfplaatsen opvragen in een periode, datumAanvangAdreshuishouding deels onbekend
    Als verblijfplaatshistorie wordt geraadpleegd met de volgende parameters
    | naam                | waarde               |
    | type                | RaadpleegMetPeriode  |
    | burgerservicenummer | 999990451            |
    | fields              | datumVan, datumTot, datumIngangGeldigheid, adresregel1, land.code |
    | datumVan            | 1989-12-01           |
    | datumTotEnMet       | 1996-01-01           |
    Dan heeft de response een verblijfplaats met de volgende gegevens
    | datumAanvangAdreshouding | datumIngangGeldigheid | Straat        | Huisnummer | Land.code |
    | 20130301                 | 20130302              | Chilidreef    | 14         | 6030      |
    | 19890000                 | 20110205              | Dennestraat   | 35         | 6030      |

  @proxy
    Scenario: Verblijfplaatsen opvragen in een periode, datumAanvangAdreshuishouding deels onbekend
    Als verblijfplaatshistorie wordt geraadpleegd met de volgende parameters
    | naam                | waarde               |
    | type                | RaadpleegMetPeriode  |
    | burgerservicenummer | 999990451            |
    | fields              | datumVan, datumTot, datumIngangGeldigheid, adresregel1, land.code |
    | datumVan            | 1989-12-01           |
    | datumTotEnMet       | 1996-01-01           |
    Dan heeft de response een verblijfplaats met de volgende gegevens
    | datumVan.jaar | datumVan.type | datumVan.onbekend | datumTot.datum | datumTot.type | datumIngangGeldigheid.datum | datumIngangGeldigheid.type | datumIngangGeldigheid.onbekend | Adresregel1      | Land.code |
    | 1989          | JaarDatum     | -                 | 2013-03-01     | Datum         | 2011-02-05                  | Datum                      | -                              | Dennestraat 35   | 6030      |

Rule: Wanneer van de datum aanvang adreshouding alleen het jaar en de maand bekend is, wordt voor de filtering aangenomen dat de persoon de hele maand op deze verblijfplaats heeft verbleven.

  @gba
    Scenario: Verblijfplaatsen opvragen in een periode, datumAanvangAdreshuishouding alleen jaar en maand benkend
    Als verblijfplaatshistorie wordt geraadpleegd met de volgende parameters
    | naam                | waarde               |
    | type                | RaadpleegMetPeriode  |
    | burgerservicenummer | 999990762            |
    | fields              | datumVan, datumTot, datumIngangGeldigheid, adresregel1, land.code |
    | datumVan            | 1989-10-28           |
    | datumTotEnMet       | 1996-01-01           |
    Dan heeft de response een verblijfplaats met de volgende gegevens
    | datumAanvangAdreshouding | datumIngangGeldigheid | Straat          | Huisnummer | Land.code |
    | 20140203                 | 20140203              | Jan Provostlaan | 172        | 6030      |
    | 19891000                 | 19930203              | Cypresstraat    | 14         | 6030      |

  @proxy
    Scenario: Verblijfplaatsen opvragen in een periode, datumAanvangAdreshuishouding alleen jaar en maand benkend
    Als verblijfplaatshistorie wordt geraadpleegd met de volgende parameters
    | naam                | waarde               |
    | type                | RaadpleegMetPeriode  |
    | burgerservicenummer | 999990762            |
    | fields              | datumVan, datumTot, datumIngangGeldigheid, adresregel1, land.code |
    | datumVan            | 1989-10-28           |
    | datumTotEnMet       | 1996-01-01           |
    Dan heeft de response een verblijfplaats met de volgende gegevens
    | datumVan.jaar | datumVan.maand | datumVan.type  | datumVan.onbekend | datumTot.datum | datumTot.type | datumIngangGeldigheid.datum | datumIngangGeldigheid.type | datumIngangGeldigheid.onbekend | Adresregel1      | Land.code |
    | 1989          | 10             | JaarMaandDatum | -                 | 2014-02-03     | Datum         | 2014-02-03                  | Datum                      | -                              | Cypresstraat 14  | 6030      |


Rule: Wanneer de datum aanvang adreshouding geheel onbekend is, wordt voor de filtering aangenomen dat de persoon daar altijd al woonde.

  @gba
    Scenario: Verblijfplaatsen opvragen in een periode, datumAanvangAdreshuishouding onbekend
    Als verblijfplaatshistorie wordt geraadpleegd met de volgende parameters
    | naam                | waarde                |
    | type                | RaadpleegMetPeildatum |
    | burgerservicenummer | 999993483             |
    | fields              | datumVan, datumTot, datumIngangGeldigheid, adresregel1, land.code |
    | peildatum           | 1964-01-01            |
    Dan heeft de response verblijfplaatsen met de volgende gegevens
    | datumAanvangAdreshouding | datumIngangGeldigheid | Straat        | Huisnummer | Land.code |
    | 2012-03-05               | 2012-03-05            | Zonegge       | 27         | 6030      |
    | 00000000                 | 00000000              | Leyweg        | 61         | 6030      |

  @proxy
    Scenario: Verblijfplaatsen opvragen in een periode, datumAanvangAdreshuishouding onbekend
    Als verblijfplaatshistorie wordt geraadpleegd met de volgende parameters
    | naam                | waarde                |
    | type                | RaadpleegMetPeildatum |
    | burgerservicenummer | 999993483             |
    | fields              | datumVan, datumTot, datumIngangGeldigheid, adresregel1, land.code |
    | peildatum           | 1964-01-01            |
    Dan heeft de response verblijfplaatsen met de volgende gegevens
    | datumVan.datum | datumVan.type  | datumVan.onbekend | datumTot.datum | datumTot.type | datumIngangGeldigheid.datum | datumIngangGeldigheid.type | datumIngangGeldigheid.onbekend | Adresregel1      | Land.code |
    | -              | DatumOnbekend  | true              | 2012-03-05     | Datum         | -                           | DatumOnbekend              | true                           | Leyweg 61        | 6030      |

  @gba
    Scenario: Verblijfplaatsen opvragen in een periode, datumAanvangAdreshuishouding onbekend
    Als verblijfplaatshistorie wordt geraadpleegd met de volgende parameters
    | naam                | waarde               |
    | type                | RaadpleegMetPeriode  |
    | burgerservicenummer | 999993483            |
    | fields              | datumVan, datumTot, datumIngangGeldigheid, adresregel1, land.code |
    | datumVan            | 2009-06-01           |
    | datumTotEnMet       | 2014-06-01           |
    Dan heeft de response verblijfplaatsen met de volgende gegevens
    | datumAanvangAdreshouding | datumIngangGeldigheid | Straat        | Huisnummer | Land.code |
    | 20120305                 | 20120305              | Zonegge       | 27         | 6030      |
    | 00000000                 | 00000000              | Leyweg        | 61         | 6030      |

  @proxy
    Scenario: Verblijfplaatsen opvragen in een periode, datumAanvangAdreshuishouding onbekend
    Als verblijfplaatshistorie wordt geraadpleegd met de volgende parameters
    | naam                | waarde                |
    | type                | RaadpleegMetPeriode   |
    | burgerservicenummer | 999993483             |
    | fields              | datumVan, datumTot, datumIngangGeldigheid, adresregel1, land.code |
    | datumVan            | 2009-06-01           |
    | datumTotEnMet       | 2014-06-01           |
    Dan heeft de response verblijfplaatsen met de volgende gegevens
    | datumVan.datum | datumVan.type  | datumVan.onbekend | datumTot.datum | datumTot.type | datumIngangGeldigheid.datum | datumIngangGeldigheid.type | datumIngangGeldigheid.onbekend | Adresregel1      | Land.code |
    | 2012-03-05     | Datum          | -                 | -              | -             | 2012-03-05                  | Datum                      | -                              | Zonegge 27       | 6030      |
    | -              | DatumOnbekend  | true              | 2012-03-05     | Datum         | -                           | DatumOnbekend              | true                           | Leyweg 61        | 6030      |

  @gba
    Scenario: Verblijfplaatsen opvragen in een periode, datumAanvangAdreshuishouding onbekend
    Als verblijfplaatshistorie wordt geraadpleegd met de volgende parameters
    | naam                | waarde               |
    | type                | RaadpleegMetPeriode  |
    | burgerservicenummer | 999993483            |
    | fields              | datumVan, datumTot, datumIngangGeldigheid, adresregel1, land.code |
    | datumVan            | 1843-01-02           |
    | datumTotEnMet       | 1914-01-01           |
    Dan heeft de response een verblijfplaats met de volgende gegevens
    | datumAanvangAdreshouding | datumIngangGeldigheid | Straat        | Huisnummer | Land.code |
    | 20120305                 | 20120305              | Zonegge       | 27         | 6030      |
    | 00000000                 | 00000000              | Leyweg        | 61         | 6030      |

  @proxy
    Scenario: Verblijfplaatsen opvragen in een periode, datumAanvangAdreshuishouding onbekend
    Als verblijfplaatshistorie wordt geraadpleegd met de volgende parameters
    | naam                | waarde                |
    | type                | RaadpleegMetPeriode   |
    | burgerservicenummer | 999993483             |
    | fields              | datumVan, datumTot, datumIngangGeldigheid, adresregel1, land.code |
    | datumVan            | 1843-01-02            |
    | datumTotEnMet       | 1914-01-01            |
    Dan heeft de response verblijfplaatsen met de volgende gegevens
    | datumVan.datum | datumVan.type  | datumVan.onbekend | datumTot.datum | datumTot.type | datumIngangGeldigheid.datum | datumIngangGeldigheid.type | datumIngangGeldigheid.onbekend | Adresregel1      | Land.code |
    | 2012-03-05     | Datum          | -                 | -              | -             | 2012-03-05                  | Datum                      | -                              | Zonegge 27       | 6030      |
    | -              | DatumOnbekend  | true              | 2012-03-05     | Datum         | -                           | DatumOnbekend              | true                           | Leyweg 61        | 6030      |

Rule: Wanneer een verblijfplaats, actueel of historisch, in onderzoek is, en dit onderzoek is niet afgerond (Datum einde onderzoek is leeg), wordt inOnderzoek gevuld voor betreffende verblijfplaats.

  @gba
    Scenario: Verblijfplaatsen opvragen in een periode, veblijfplaats is in onderzoek
    Als verblijfplaatshistorie wordt geraadpleegd met de volgende parameters
    | naam                | waarde               |
    | type                | RaadpleegMetPeriode  |
    | burgerservicenummer | 999990378            |
    | fields              | datumVan, datumTot, datumIngangGeldigheid, adresregel1, land.code |
    | datumVan            | 2009-06-01           |
    | datumTotEnMet       | 2016-06-01           |
    Dan heeft de response verblijfplaatsen met de volgende gegevens
    | datumAanvangAdreshouding | datumIngangGeldigheid | Straat           | Huisnummer | Land.code | aanduidingGegevensInOnderzoek | datumIngangOnderzoek |
    | 20150601                 | -                     | Rietzangerstraat | 27         | 6030      | -                             | -                    |
    | 19881118                 | -                     | Voorhofdreef     | 30         | 6030      | 580000                        | 19881120             |


  @proxy
    Scenario: Verblijfplaatsen opvragen in een periode, veblijfplaats is in onderzoek
    Als verblijfplaatshistorie wordt geraadpleegd met de volgende parameters
    | naam                | waarde               |
    | type                | RaadpleegMetPeriode  |
    | burgerservicenummer | 999990378            |
    | fields              | datumVan, datumTot, datumIngangGeldigheid, adresregel1, land.code |
    | datumVan            | 2009-06-01           |
    | datumTotEnMet       | 2016-06-01           |
    Dan heeft de response verblijfplaatsen met de volgende gegevens
    | datumVan.datum | datumVan.type  | datumVan.onbekend | datumTot.datum | datumTot.type | datumIngangGeldigheid.datum | datumIngangGeldigheid.type | datumIngangGeldigheid.onbekend | Adresregel1          | Land.code | inOnderzoek.datumIngangOnderzoek.datum | inOnderzoek.datumIngangOnderzoek.type | inOnderzoek.type | inOnderzoek.datumInschrijvingGemeente | inOnderzoek.gemeenteVanInschrijving | inOnderzoek.datumVan | inOnderzoek.datumIngangGeldigheid |
    | 2015-06-01     | Datum          | -                 | -              | -             | -                           | -                          | -                              | Rietzangerstraat 27  | 6030      | -                                      | -                                     | -                | -                                     | -                                   | -                    | -                                 |
    | 1988-11-18     | Datum          | -                 | 2015-06-01     | Datum         | -                           | -                          | -                              | Voorhofdreef 30      | 6030      | 1988-11-20                             | Datum                                 | true             | true                                  | true                                | true                 | true                              |

  @gba
    Scenario: Verblijfplaatsen opvragen in een periode, veblijfplaats is in onderzoek geweest
    Als verblijfplaatshistorie wordt geraadpleegd met de volgende parameters
    | naam                | waarde               |
    | type                | RaadpleegMetPeriode  |
    | burgerservicenummer | 999990263            |
    | fields              | datumVan, datumTot, datumIngangGeldigheid, adresregel1, land.code |
    | datumVan            | 2009-06-01           |
    | datumTotEnMet       | 2016-06-01           |
    Dan heeft de response verblijfplaatsen met de volgende gegevens
    | datumAanvangAdreshouding | datumIngangGeldigheid | Straat           | Huisnummer | Land.code | aanduidingGegevensInOnderzoek | datumIngangOnderzoek |
    | 20150601                 | -                     | Raphaëlstraat    | 1          | 6030      | -                             | -                    |
    | 19890501                 | -                     | Oudegracht       | 380        | 6030      | -                             | -                    |

  @proxy
    Scenario: Verblijfplaatsen opvragen in een periode, veblijfplaats is in onderzoek geweest
    Als verblijfplaatshistorie wordt geraadpleegd met de volgende parameters
    | naam                | waarde               |
    | type                | RaadpleegMetPeriode  |
    | burgerservicenummer | 999990263            |
    | fields              | datumVan, datumTot, datumIngangGeldigheid, adresregel1, land.code |
    | datumVan            | 2009-06-01           |
    | datumTotEnMet       | 2016-06-01           |
    Dan heeft de response verblijfplaatsen met de volgende gegevens
    | datumVan.datum | datumVan.type  | datumVan.onbekend | datumTot.datum | datumTot.type | datumIngangGeldigheid.datum | datumIngangGeldigheid.type | datumIngangGeldigheid.onbekend | Adresregel1          | Land.code | inOnderzoek.datumIngangOnderzoek.datum | inOnderzoek.datumIngangOnderzoek.type | inOnderzoek.type | inOnderzoek.datumInschrijvingGemeente | inOnderzoek.gemeenteVanInschrijving | inOnderzoek.datumVan | inOnderzoek.datumIngangGeldigheid |
    | 2015-06-01     | Datum          | -                 | -              | -             | -                           | -                          | -                              | Raphaëlstraat 1      | 6030      | -                                      | -                                     | -                | -                                     | -                                   | -                    | -                                 |
    | 1989-05-01     | Datum          | -                 | 2015-06-01     | Datum         | -                           | -                          | -                              | Oudergracht 380      | 6030      | -                                      | -                                     | -                | -                                     | -                                   | -                    | -                                 |
