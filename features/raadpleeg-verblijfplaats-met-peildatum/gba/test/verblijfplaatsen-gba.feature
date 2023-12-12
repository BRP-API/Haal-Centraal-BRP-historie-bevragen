#language: nl

@gba
Functionaliteit: test dat alle gegevens van verblijfplaatsen worden geleverd bij raadplegen op peildatum


    Scenario: verblijfplaats is een BAG-adres
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | straatnaam (11.10) | naam openbare ruimte (11.15) | huisnummer (11.20) | huisletter (11.30) | huisnummertoevoeging (11.40) | postcode (11.60) | woonplaats (11.70) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
      | 0800                 | Teststraat         | Test Openbare Ruimtenaam     | 123                | B                  | 4567                         | 1234AB           | Testdorp           | 0800010000000001                         | 0800200000000001                           |
      En de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | functie adres (10.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | W                     | 20100818                           |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 000000012             |
      | peildatum           | 2011-01-01            |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | functieAdres.code | functieAdres.omschrijving | datumAanvangAdreshouding | straat     | naamOpenbareRuimte       | huisnummer | huisletter | huisnummertoevoeging | postcode | woonplaats | adresseerbaarObjectIdentificatie | nummeraanduidingIdentificatie |
      | 0800                         | Hoogeloon, Hapert en Casteren        | W                 | woonadres                 | 20100818                 | Teststraat | Test Openbare Ruimtenaam | 123        | B          | 4567                 | 1234AB   | Testdorp   | 0800010000000001                 | 0800200000000001              |

    Scenario: verblijfplaats is een niet-BAG adres 
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | straatnaam (11.10) | huisnummer (11.20) | huisletter (11.30) | huisnummertoevoeging (11.40) | aanduiding bij huisnummer (11.50) | postcode (11.60) |
      | 0800                 | Teststraat         | 123                | B                  | 4567                         | by                                | 1234AB           |
      En de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | functie adres (10.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | W                     | 20100818                           |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 000000012             |
      | peildatum           | 2011-01-01            |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | functieAdres.code | functieAdres.omschrijving | datumAanvangAdreshouding | straat     | huisnummer | huisletter | huisnummertoevoeging | aanduidingBijHuisnummer.code | aanduidingBijHuisnummer.omschrijving | postcode |
      | 0800                         | Hoogeloon, Hapert en Casteren        | W                 | woonadres                 | 20100818                 | Teststraat | 123        | B          | 4567                 | by                           | bij                                  | 1234AB   |

    Scenario: verblijfplaats heeft diakrieten in adres
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | straatnaam (diakrieten) | naam openbare ruimte (diakrieten) | huisnummer (11.20) | postcode (11.60) | woonplaats (diakrieten) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
      | 0800                 | Contrôle                | Tést Openbare Ruimtenaam          | 123                | 1234AB           | Testdörp                | 0800010000000001                         | 0800200000000001                           |
      En de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | functie adres (10.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | W                     | 20100818                           |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 000000012             |
      | peildatum           | 2011-01-01            |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | functieAdres.code | functieAdres.omschrijving | datumAanvangAdreshouding | straat   | naamOpenbareRuimte       | huisnummer | postcode | woonplaats | adresseerbaarObjectIdentificatie | nummeraanduidingIdentificatie |
      | 0800                         | Hoogeloon, Hapert en Casteren        | W                 | woonadres                 | 20100818                 | Contrôle | Tést Openbare Ruimtenaam | 123        | 1234AB   | Testdörp   | 0800010000000001                 | 0800200000000001              |

    Scenario: verblijfplaats is locatie 
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | locatiebeschrijving (12.10) |
      | 0800                 | Woonboot bij de Grote Sloot |
      En de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | functie adres (10.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | W                     | 20100818                           |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 000000012             |
      | peildatum           | 2011-01-01            |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | functieAdres.code | functieAdres.omschrijving | datumAanvangAdreshouding | locatiebeschrijving         |
      | 0800                         | Hoogeloon, Hapert en Casteren        | W                 | woonadres                 | 20100818                 | Woonboot bij de Grote Sloot |

     Scenario: verblijfplaats is locatie met diakrieten
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | locatiebeschrijving (diakrieten) |
      | 0800                 | Woonboot bij de Græte Slüß       |
      En de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | functie adres (10.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | W                     | 20100818                           |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 000000012             |
      | peildatum           | 2011-01-01            |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | functieAdres.code | functieAdres.omschrijving | datumAanvangAdreshouding | locatiebeschrijving        |
      | 0800                         | Hoogeloon, Hapert en Casteren        | W                 | woonadres                 | 20100818                 | Woonboot bij de Græte Slüß |

    Scenario: verblijfplaats is buitenlands adres
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | straatnaam (11.10) | naam openbare ruimte (11.15) | huisnummer (11.20) | huisletter (11.30) | huisnummertoevoeging (11.40) | postcode (11.60) | woonplaats (11.70) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
      | 0800                 | Teststraat         | Test Openbare Ruimtenaam     | 123                | B                  | 4567                         | 1234AB           | Testdorp           | 0800010000000001                         | 0800200000000001                           |
      En de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | functie adres (10.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | W                     | 20040526                           |
      En de persoon is vervolgens ingeschreven op een buitenlands adres met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adres buitenland (13.20) | land adres buitenland (13.10) | regel 1 adres buitenland (13.30) | regel 2 adres buitenland (13.40) | regel 3 adres buitenland (13.50) |
      | 1999                              | 20100818                               | 6014                          | Die Erste Straße                 | Beverly Hills CA 91210           | Loin d'ici                       |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 000000012             |
      | peildatum           | 2011-01-01            |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | land.code | land.omschrijving            | datumAanvangAdresBuitenland | regel1           | regel2                 | regel3     |
      | 1999                         | Registratie Niet Ingezetenen (RNI)   | 6014      | Verenigde Staten van Amerika | 20100818                    | Die Erste Straße | Beverly Hills CA 91210 | Loin d'ici |
  