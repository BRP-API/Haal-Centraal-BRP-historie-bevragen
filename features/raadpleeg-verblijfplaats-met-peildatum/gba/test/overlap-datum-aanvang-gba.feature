#language: nl

Functionaliteit: test dat raadplegen historie met peildatum bij een opeenvolgende verblijfplaatsen met gelijke of overlappende datum aanvang correct wordt geleverd

    Achtergrond:
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | straatnaam (11.10) |
      | 0800                 | Korte straatnaam   |
      En adres 'A2' heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | straatnaam (11.10) | naam openbare ruimte (11.15) | woonplaats (11.70) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
      | 0800                 | 0800010000000002                         | Korte straatnaam   | Officiele straatnaam         | Testdorp           | 0800010000000002                         | 0800200000000002                           |

  Rule: een verblijfplaats wordt niet geleverd wanneer de bekende datum aanvang volgende verblijfplaats gelijk is aan (of eerder) dan de datum aanvang van het verblijf

    Scenario: wel leveren wanneer de datum aanvang van de gewijzigde verblijfplaats later is dan de aanvang oorspronkelijke
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20020701                           |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) | aangifte adreshouding (72.10) |
      | 0800                              | 20101014                           | T                             |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 000000012             |
      | peildatum           | 2010-01-01            |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | datumAanvangAdreshouding | datumAanvangVolgendeAdreshouding | straat           | naamOpenbareRuimte   | woonplaats | adresseerbaarObjectIdentificatie | nummeraanduidingIdentificatie |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 20020701                 | 20101014                         | Korte straatnaam |                      |            |                                  |                               |

    Abstract Scenario: niet leveren wanneer de datum aanvang van de gewijzigde verblijfplaats is <omschrijving> de aanvang oorspronkelijke
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20020701                           |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) | aangifte adreshouding (72.10) |
      | 0800                              | <datum aanvang>                    | T                             |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 000000012             |
      | peildatum           | <peildatum>           |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | datumAanvangAdreshouding | straat           | naamOpenbareRuimte   | woonplaats | adresseerbaarObjectIdentificatie | nummeraanduidingIdentificatie |
      | 0800                         | Hoogeloon, Hapert en Casteren        | <datum aanvang>          | Korte straatnaam | Officiele straatnaam | Testdorp   | 0800010000000002                 | 0800200000000002              |

      Voorbeelden:
      | omschrijving | datum aanvang | peildatum  |
      | gelijk aan   | 20020701      | 2002-07-01 |
      | eerder dan   | 20020628      | 2002-06-28 |
      | eerder dan   | 20020628      | 2002-06-29 |
      | eerder dan   | 20020628      | 2002-07-01 |
      | eerder dan   | 20020628      | 2002-07-03 |

    Abstract Scenario: wel leveren wanneer de datum aanvang na gecorrigeerde verblijfplaats later is dan de aanvang oorspronkelijke
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20020701                           |
      En de persoon is vervolgens ingeschreven op een buitenlands adres met de volgende gegevens
      | datum aanvang adres buitenland (13.20) | land adres buitenland (13.10) |
      | 20101014                               | 6014                          |
      En de inschrijving is vervolgens gecorrigeerd als een inschrijving op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20101014                           |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 000000012             |
      | peildatum           | <peildatum>           |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | datumAanvangAdreshouding   | datumAanvangVolgendeAdreshouding   | straat           |
      | 0800                         | Hoogeloon, Hapert en Casteren        | <datumAanvangAdreshouding> | <datumAanvangVolgendeAdreshouding> | Korte straatnaam |

      Voorbeelden:
      | peildatum  | datumAanvangAdreshouding | datumAanvangVolgendeAdreshouding |
      | 2002-07-01 | 20020701                 | 20101014                         |
      | 2002-07-30 | 20020701                 | 20101014                         |
      | 2010-10-13 | 20020701                 | 20101014                         |
      | 2010-10-14 | 20101014                 |                                  |
      | 2011-01-01 | 20101014                 |                                  |

    Abstract Scenario: niet leveren wanneer de datum aanvang na gecorrigeerde verblijfplaats <omschrijving> de aanvang oorspronkelijke
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20020701                           |
      En de persoon is vervolgens ingeschreven op een buitenlands adres met de volgende gegevens
      | datum aanvang adres buitenland (13.20) | land adres buitenland (13.10) |
      | 20101014                               | 6014                          |
      En de inschrijving is vervolgens gecorrigeerd als een inschrijving op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <datum aanvang>                    |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 000000012             |
      | peildatum           | <peildatum>           |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | datumAanvangAdreshouding | straat           |
      | 0800                         | Hoogeloon, Hapert en Casteren        | <datum aanvang>          | Korte straatnaam |

      Voorbeelden:
      | omschrijving | datum aanvang | peildatum  |
      | gelijk aan   | 20020701      | 2002-07-01 |
      | gelijk aan   | 20020701      | 2010-10-13 |
      | gelijk aan   | 20020701      | 2010-10-14 |
      | gelijk aan   | 20020701      | 2011-01-01 |
      | eerder dan   | 20020628      | 2002-06-28 |
      | eerder dan   | 20020628      | 2002-07-01 |
      | eerder dan   | 20020628      | 2010-10-14 |
      | eerder dan   | 20020628      | 2011-01-01 |
