  #language: nl

  Functionaliteit: alle gegevens van verblijfplaatsen worden geleverd bij raadplegen op periode


    Scenario: verblijfplaats is een BAG-adres
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | straatnaam (11.10) | naam openbare ruimte (11.15) | huisnummer (11.20) | huisletter (11.30) | huisnummertoevoeging (11.40) | postcode (11.60) | woonplaats (11.70) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
      | 0800                 | Teststraat         | Test Openbare Ruimtenaam     | 123                | B                  | 4567                         | 1234AB           | Testdorp           | 0800010000000001                         | 0800200000000001                           |
      En de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | functie adres (10.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | W                     | 20100818                           |
      Als verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2010-01-01          |
      | datumTot            | 2011-01-01          |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | type  | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | functieAdres.code | functieAdres.omschrijving | datumVan.type | datumVan.datum | datumVan.langFormaat | adresseerbaarObjectIdentificatie | nummeraanduidingIdentificatie |
      | Adres | 0800                         | Hoogeloon, Hapert en Casteren        | W                 | woonadres                 | Datum         | 2010-08-18     | 18 augustus 2010     | 0800010000000001                 | 0800200000000001              |
      En heeft de verblijfplaats de volgende 'verblijfadres' gegevens
      | korteStraatnaam | officieleStraatnaam      | huisnummer | huisletter | huisnummertoevoeging | postcode | woonplaats |
      | Teststraat      | Test Openbare Ruimtenaam | 123        | B          | 4567                 | 1234AB   | Testdorp   |
      En heeft de verblijfplaats de volgende 'adressering' gegevens
      | adresregel1          | adresregel2       |
      | Teststraat 123 B4567 | 1234 AB  TESTDORP |

    Scenario: verblijfplaats is een niet-BAG adres
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | straatnaam (11.10) | huisnummer (11.20) | huisletter (11.30) | huisnummertoevoeging (11.40) | aanduiding bij huisnummer (11.50) | postcode (11.60) |
      | 0800                 | Teststraat         | 123                | B                  | 4567                         | by                                | 1234AB           |
      En de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | functie adres (10.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | W                     | 20100818                           |
      Als verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2010-01-01          |
      | datumTot            | 2011-01-01          |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | type  | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | functieAdres.code | functieAdres.omschrijving | datumVan.type | datumVan.datum | datumVan.langFormaat |
      | Adres | 0800                         | Hoogeloon, Hapert en Casteren        | W                 | woonadres                 | Datum         | 2010-08-18     | 18 augustus 2010     |
      En heeft de verblijfplaats de volgende 'verblijfadres' gegevens
      | korteStraatnaam | officieleStraatnaam      | huisnummer | huisletter | huisnummertoevoeging | aanduidingBijHuisnummer.code | aanduidingBijHuisnummer.omschrijving | postcode |
      | Teststraat      | Test Openbare Ruimtenaam | 123        | B          | 4567                 | by                           | bij                                  | 1234AB   |
      En heeft de verblijfplaats de volgende 'adressering' gegevens
      | adresregel1              | adresregel2                            |
      | Teststraat bij 123 B4567 | 1234 AB  HOOGELOON, HAPERT EN CASTEREN |

    Scenario: verblijfplaats heeft diakrieten in adres
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | straatnaam (diakrieten) | naam openbare ruimte (diakrieten) | huisnummer (11.20) | postcode (11.60) | woonplaats (diakrieten) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
      | 0800                 | Contrôle                | Tést Openbare Ruimtenaam          | 123                | 1234AB           | Testdörp                | 0800010000000001                         | 0800200000000001                           |
      En de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | functie adres (10.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | W                     | 20100818                           |
      Als verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2010-01-01          |
      | datumTot            | 2011-01-01          |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | type  | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | functieAdres.code | functieAdres.omschrijving | datumVan.type | datumVan.datum | datumVan.langFormaat | adresseerbaarObjectIdentificatie | nummeraanduidingIdentificatie |
      | Adres | 0800                         | Hoogeloon, Hapert en Casteren        | W                 | woonadres                 | Datum         | 2010-08-18     | 18 augustus 2010     | 0800010000000001                 | 0800200000000001              |
      En heeft de verblijfplaats de volgende 'verblijfadres' gegevens
      | korteStraatnaam | officieleStraatnaam      | huisnummer | postcode | woonplaats |
      | Contrôle        | Tést Openbare Ruimtenaam | 123        | 1234AB   | Testdörp   |
      En heeft de verblijfplaats de volgende 'adressering' gegevens
      | adresregel1  | adresregel2       |
      | Contrôle 123 | 1234 AB  Testdörp |

    Scenario: verblijfplaats is locatie
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | locatiebeschrijving (12.10) |
      | 0800                 | Woonboot bij de Grote Sloot |
      En de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | functie adres (10.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | W                     | 20100818                           |
      Als verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2010-01-01          |
      | datumTot            | 2011-01-01          |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | type    | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | functieAdres.code | functieAdres.omschrijving | datumVan.type | datumVan.datum | datumVan.langFormaat |
      | Locatie | 0800                         | Hoogeloon, Hapert en Casteren        | W                 | woonadres                 | Datum         | 2010-08-18     | 18 augustus 2010     |
      En heeft de verblijfplaats de volgende 'verblijfadres' gegevens
      | locatiebeschrijving         |
      | Woonboot bij de Grote Sloot |
      En heeft de verblijfplaats de volgende 'adressering' gegevens
      | adresregel1                 | adresregel2                   |
      | Woonboot bij de Grote Sloot | HOOGELOON, HAPERT EN CASTEREN |

    Scenario: verblijfplaats is locatie met diakrieten
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | locatiebeschrijving (diakrieten) |
      | 0800                 | Woonboot bij de Græte Slüß       |
      En de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | functie adres (10.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | W                     | 20100818                           |
      Als verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2010-01-01          |
      | datumTot            | 2011-01-01          |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | type    | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | functieAdres.code | functieAdres.omschrijving | datumVan.type | datumVan.datum | datumVan.langFormaat |
      | Locatie | 0800                         | Hoogeloon, Hapert en Casteren        | W                 | woonadres                 | Datum         | 2010-08-18     | 18 augustus 2010     |
      En heeft de verblijfplaats de volgende 'verblijfadres' gegevens
      | locatiebeschrijving        |
      | Woonboot bij de Græte Slüß |
      En heeft de verblijfplaats de volgende 'adressering' gegevens
      | adresregel1                | adresregel2                   |
      | Woonboot bij de Græte Slüß | HOOGELOON, HAPERT EN CASTEREN |

    Scenario: verblijfplaats is buitenlands adres
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | straatnaam (11.10) | naam openbare ruimte (11.15) | huisnummer (11.20) | huisletter (11.30) | huisnummertoevoeging (11.40) | postcode (11.60) | woonplaats (11.70) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
      | 0800                 | Teststraat         | Test Openbare Ruimtenaam     | 123                | B                  | 4567                         | 1234AB           | Testdorp           | 0800010000000001                         | 0800200000000001                           |
      En de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | functie adres (10.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | W                     | 20040526                           |
      En de persoon is vervolgens ingeschreven op een buitenlands adres met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adres buitenland (13.20) | land adres buitenland (13.10) | regel 1 adres buitenland (13.30) | regel 2 adres buitenland (13.40) | regel 3 adres buitenland (13.50) |
      | 1999                              | 20100818                               | 6014                          | Die Erste Straße                 | Beverly Hills CA 90210           | Loin d'ici                       |
      Als verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2011-01-01          |
      | datumTot            | 2012-01-01          |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | type                     | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | datumVan.type | datumVan.datum | datumVan.langFormaat |
      | VerblijfplaatsBuitenland | 1999                         | Registratie Niet Ingezetenen (RNI)   | Datum         | 2010-08-18     | 18 augustus 2010     |
      En heeft de verblijfplaats de volgende 'verblijfadres' gegevens
      | land.code | land.omschrijving            | regel1           | regel2                 | regel3     |
      | 6014      | Verenigde Staten van Amerika | Die Erste Straße | Beverly Hills CA 90210 | Loin d'ici |
      En heeft de verblijfplaats de volgende 'adressering' gegevens
      | adresregel1      | adresregel2            | adresregel3 | land.code | land.omschrijving            |
      | Die Erste Straße | Beverly Hills CA 90210 | Loin d'ici  | 6014      | Verenigde Staten van Amerika |

    Scenario: verblijfplaats is onbekend
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | straatnaam (11.10) | naam openbare ruimte (11.15) | huisnummer (11.20) | huisletter (11.30) | huisnummertoevoeging (11.40) | postcode (11.60) | woonplaats (11.70) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
      | 0800                 | Teststraat         | Test Openbare Ruimtenaam     | 123                | B                  | 4567                         | 1234AB           | Testdorp           | 0800010000000001                         | 0800200000000001                           |
      En de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | functie adres (10.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | W                     | 20040526                           |
      En de persoon is vervolgens ingeschreven op een buitenlands adres met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adres buitenland (13.20) | land adres buitenland (13.10) |
      | 1999                              | 20100818                               | 0000                          |
      Als verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2011-01-01          |
      | datumTot            | 2012-01-01          |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | type                   | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | datumVan.type | datumVan.datum | datumVan.langFormaat |
      | VerblijfplaatsOnbekend | 1999                         | Registratie Niet Ingezetenen (RNI)   | Datum         | 2010-08-18     | 18 augustus 2010     |
