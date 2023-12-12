#language: nl

Functionaliteit: test dat raadplegen historie met peildatum een correcte melding geeft bij een onjuiste aanroep

    Achtergrond:
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | straatnaam (11.10) |
      | 0800                 | Teststraat         |
      En de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20100818                           |

  Rule: type is een verplichte parameter met mogelijke waarden RaadpleegMetPeildatum en RaadpleegMetPeriode

    @fout-case
    Scenario: zoek zonder opgeven van parameters
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam | waarde |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                      |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
      | title    | Een of meerdere parameters zijn niet correct.               |
      | status   | 400                                                         |
      | detail   | De foutieve parameter(s) zijn: type.                        |
      | code     | paramsValidation                                            |
      | instance | /haalcentraal/api/brphistorie/verblijfplaatshistorie        |
      En heeft het object de volgende 'invalidParams' gegevens
      | code     | name | reason                  |
      | required | type | Parameter is verplicht. |

    @fout-case
    Scenario: zoek zonder parameter type
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde     |
      | burgerservicenummer | 000000012  |
      | peildatum           | 2020-01-01 |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                      |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
      | title    | Een of meerdere parameters zijn niet correct.               |
      | status   | 400                                                         |
      | detail   | De foutieve parameter(s) zijn: type.                        |
      | code     | paramsValidation                                            |
      | instance | /haalcentraal/api/brphistorie/verblijfplaatshistorie        |
      En heeft het object de volgende 'invalidParams' gegevens
      | code     | name | reason                  |
      | required | type | Parameter is verplicht. |

    @fout-case
    Abstract Scenario: zoek met onjuiste waarde voor parameter type
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde     |
      | type                | <type>     |
      | burgerservicenummer | 000000012  |
      | peildatum           | 2020-01-01 |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                      |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
      | title    | Een of meerdere parameters zijn niet correct.               |
      | status   | 400                                                         |
      | detail   | De foutieve parameter(s) zijn: type.                        |
      | code     | paramsValidation                                            |
      | instance | /haalcentraal/api/brphistorie/verblijfplaatshistorie        |
      En heeft het object de volgende 'invalidParams' gegevens
      | code  | name | reason                           |
      | value | type | Waarde is geen geldig zoek type. |

      Voorbeelden:
      | type                            |
      | onjuist                         |
      | RaadpleegMetBurgerservicenummer |
      |                                 |
      | raadpleegmetperiode             |
      | RaadpleegMetPeriodes            |

  Rule: burgerservicenummer is een verplichte parameter en met als waarde exact 9 cijfers van het burgerservicenummer van een persoon in de BRP

    @fout-case
    Scenario: De burgerservicenummer parameter is niet opgegeven
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam      | waarde                |
      | type      | RaadpleegMetPeildatum |
      | peildatum | 2020-01-01            |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                      |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
      | title    | Een of meerdere parameters zijn niet correct.               |
      | status   | 400                                                         |
      | detail   | De foutieve parameter(s) zijn: burgerservicenummer.         |
      | code     | paramsValidation                                            |
      | instance | /haalcentraal/api/brphistorie/verblijfplaatshistorie        |
      En heeft het object de volgende 'invalidParams' gegevens
      | code     | name                | reason                  |
      | required | burgerservicenummer | Parameter is verplicht. |

    @fout-case
    Abstract Scenario: zoek met onjuiste waarde voor parameter burgerservicenummer
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | <burgerservicenummer> |
      | peildatum           | 2020-01-01            |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                      |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
      | title    | Een of meerdere parameters zijn niet correct.               |
      | status   | 400                                                         |
      | detail   | De foutieve parameter(s) zijn: burgerservicenummer.         |
      | code     | paramsValidation                                            |
      | instance | /haalcentraal/api/brphistorie/verblijfplaatshistorie        |
      En heeft het object de volgende 'invalidParams' gegevens
      | code    | name                | reason                                      |
      | pattern | burgerservicenummer | Waarde voldoet niet aan patroon ^[0-9]{9}$. |

      Voorbeelden:
      | burgerservicenummer |
      | 12345678            |
      | 1234567890          |
      | A                   |
      | 12345678A           |
      | 123456789A          |
      | 1234 6789           |
      | 123456789+          |
      | 1234.67890          |
      |                     |

    @fout-case
    Abstract Scenario: zoek met waarde voor parameter burgerservicenummer die niet voorkomt in de BRP
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 123456789             |
      | peildatum           | 2020-01-01            |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                         |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.4    |
      | title    | Opgevraagde resource bestaat niet.                             |
      | status   | 404                                                            |
      | detail   | De persoon met burgerservicenummer 123456789 is niet gevonden. |
      | code     | notFound                                                       |
      | instance | /haalcentraal/api/brphistorie/verblijfplaatshistorie           |

  Rule: bij RaadpleegMetPeildatum is peildatum een verplichte parameter in RFC 3339 (yyyy-mm-dd) formaat

    @fout-case
    Scenario: De peildatum parameter is niet opgegeven
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 000000012             |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                      |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
      | title    | Een of meerdere parameters zijn niet correct.               |
      | status   | 400                                                         |
      | detail   | De foutieve parameter(s) zijn: peildatum.                    |
      | code     | paramsValidation                                            |
      | instance | /haalcentraal/api/brphistorie/verblijfplaatshistorie        |
      En heeft het object de volgende 'invalidParams' gegevens
      | code     | name      | reason                  |
      | required | peildatum | Parameter is verplicht. |

    @fout-case
    Scenario: De peildatum parameter is leeg
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 000000012             |
      | peildatum           |                       |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                      |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
      | title    | Een of meerdere parameters zijn niet correct.               |
      | status   | 400                                                         |
      | detail   | De foutieve parameter(s) zijn: peildatum.                    |
      | code     | paramsValidation                                            |
      | instance | /haalcentraal/api/brphistorie/verblijfplaatshistorie        |
      En heeft het object de volgende 'invalidParams' gegevens
      | code     | name      | reason                  |
      | required | peildatum | Parameter is verplicht. |

    @fout-case
    Abstract Scenario: De peildatum parameter heeft een ongeldige waarde
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 000000012             |
      | peildatum           | <peildatum>           |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                      |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
      | title    | Een of meerdere parameters zijn niet correct.               |
      | status   | 400                                                         |
      | detail   | De foutieve parameter(s) zijn: peildatum.                   |
      | code     | paramsValidation                                            |
      | instance | /haalcentraal/api/brphistorie/verblijfplaatshistorie        |
      En heeft het object de volgende 'invalidParams' gegevens
      | code | name      | reason                        |
      | date | peildatum | Waarde is geen geldige datum. |

      Voorbeelden:
      | peildatum      |
      | 20190101       |
      | 01/02/2019     |
      | 1 januari 2019 |
      | 2019-1-1       |
      | 2019-01-001    |
      | 2019-01-01-    |
      | -2019-01-01    |
      | 2019-13-01     |
      | 2019-06-31     |
      | 2019-02-29     |
      | --             |
      | - -            |

  Rule: parameter exclusiefVerblijfplaatsBuitenland is optioneel en moet een boolean (true of false) als waarde hebben
    
    @fout-case
    Abstract Scenario: De exclusiefVerblijfplaatsBuitenland parameter is geen boolean
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                              | waarde                |
      | type                              | RaadpleegMetPeildatum |
      | burgerservicenummer               | 000000012             |
      | peildatum                         | 2020-01-01            |
      | exclusiefVerblijfplaatsBuitenland | <ongeldige waarde>    |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                            |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1       |
      | title    | Een of meerdere parameters zijn niet correct.                     |
      | status   | 400                                                               |
      | detail   | De foutieve parameter(s) zijn: exclusiefVerblijfplaatsBuitenland. |
      | code     | paramsValidation                                                  |
      | instance | /haalcentraal/api/brphistorie/verblijfplaatshistorie              |
      En heeft het object de volgende 'invalidParams' gegevens
      | code    | name                              | reason                  |
      | boolean | exclusiefVerblijfplaatsBuitenland | Waarde is geen boolean. |

      Voorbeelden:
      | ongeldige waarde |
      | 0                |
      | 1                |
      | waar             |
      | ja               |
  
  Rule: Alleen gespecificeerde parameters bij het opgegeven raadpleeg type mogen worden gebruikt

    @fout-case
    Abstract Scenario: De <parameter> parameter is gebruikt bij RaadpleegMetPeildatum
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 000000012             |
      | peildatum           | 2020-01-01            |
      | <parameter>         | <waarde>              |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                      |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
      | title    | Een of meerdere parameters zijn niet correct.               |
      | status   | 400                                                         |
      | detail   | De foutieve parameter(s) zijn: <parameter>.                 |
      | code     | paramsValidation                                            |
      | instance | /haalcentraal/api/brphistorie/verblijfplaatshistorie        |
      En heeft het object de volgende 'invalidParams' gegevens
      | code         | name        | reason                      |
      | unknownParam | <parameter> | Parameter is niet verwacht. |

      Voorbeelden:
      | parameter | waarde     |
      | datumVan  | 2019-01-01 |
      | datumVan  | 2020-01-01 |
      | datumVan  | 2020-07-01 |
      | datumVan  | 2021-01-01 |
      | datumVan  | 2021-07-01 |
      | datumTot  | 2019-01-01 |
      | datumTot  | 2020-01-01 |
      | datumTot  | 2020-07-01 |
      | datumTot  | 2021-01-01 |
      | datumTot  | 2021-07-01 |

    @fout-case
    Abstract Scenario: De datumVan en datumTot parameters gebruikt bij RaadpleegMetPeildatum
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 000000012             |
      | peildatum           | 2020-01-01            |
      | datumVan            | 2020-01-01            |
      | datumTot            | 2020-01-02            |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                      |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
      | title    | Een of meerdere parameters zijn niet correct.               |
      | status   | 400                                                         |
      | detail   | De foutieve parameter(s) zijn: datumTot, datumVan.          |
      | code     | paramsValidation                                            |
      | instance | /haalcentraal/api/brphistorie/verblijfplaatshistorie        |
      En heeft het object de volgende 'invalidParams' gegevens
      | code         | name     | reason                      |
      | unknownParam | datumVan | Parameter is niet verwacht. |
      | unknownParam | datumTot | Parameter is niet verwacht. |

    @fout-case
    Abstract Scenario: Een niet gespecificeerde parameter is gebruikt bij RaadpleegMetPeriode
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 000000012             |
      | peildatum           | 2020-01-01            |
      | <parameter>         | <waarde>              |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                      |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
      | title    | Een of meerdere parameters zijn niet correct.               |
      | status   | 400                                                         |
      | detail   | De foutieve parameter(s) zijn: <parameter>.                 |
      | code     | paramsValidation                                            |
      | instance | /haalcentraal/api/brphistorie/verblijfplaatshistorie        |
      En heeft het object de volgende 'invalidParams' gegevens
      | code         | name        | reason                      |
      | unknownParam | <parameter> | Parameter is niet verwacht. |

      Voorbeelden:
      | parameter                        | waarde              |
      | iets                             | geks                |
      | gemeenteVanInschrijving          | 0530                |
      | geheimhouding                    | true                |
      | fields                           | burgerservicenummer |
      | adresseerbaarObjectIdentificatie | 0800010000000001    |
