#language: nl

@gba
Functionaliteit: raadpleeg verblijfplaats voorkomens in een periode

  Als consumer van de Historie bevragen API
  wil ik kunnen opvragen waar een persoon in een periode heeft verbleven
  zodat ik deze informatie kan gebruiken in mijn proces

  De verblijfperiode van een verblijfplaats voorkomen begint op datum aanvang adreshouding/adres buitenland, oftewel datum aanvang verblijf van het verblijfplaats voorkomen
  en eindigt indien aanwezig op de dag vóór datum aanvang verblijf van het volgende verblijfplaats voorkomen.

  Het verblijfplaats voorkomen van een gevraagde persoon wordt geleverd als minimaal één dag van de gevraagde periode in de verblijfperiode ligt.

  Een persoon kan in tijd maximaal op één adres hebben verbleven. Als de verblijfplaats historie van de persoon per dag (met een periode van 1 dag) wordt doorlopen,
  dan wordt voor elke dag maximaal één verblijfplaats voorkomen geleverd.

  Achtergrond:
    Gegeven adres 'A1' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | straatnaam (11.10) |
    | 0800                 | 0800010000000001                         | Laan               |
    En adres 'A2' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | straatnaam (11.10) |
    | 0800                 | 0800010000000002                         | Luttestraat        |
    En adres 'A3' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
    | 0800                 | 0800010000000003                         |
    En adres 'A4' heeft de volgende gegevens
    | gemeentecode (92.10) | locatiebeschrijving (12.10) |
    | 0800                 | Woonboot bij de Grote Sloot |

Rule: Een verblijfplaats voorkomen met bekend datum aanvang wordt geleverd als datumTot van de gevraagde periode groter is dan de datum aanvang van het verblijfplaats voorkomen en bij volgende verblijfplaats voorkomen als datumVan kleiner is dan de datum aanvang van het volgende verblijfplaats voorkomen

  De verblijfplaats voorkomens worden aflopend gesorteerd geleverd.
  Het meest recente verblijfplaats voorkomen in de gevraagde periode is het eerste verblijfplaats voorkomen in de geleverde lijst.
  De sortering komt overeen met het aflopend sorteren van de verblijfplaats voorkomens op datum aanvang verblijf.

  Abstract Scenario: <scenario> (geen vorige en geen volgende verblijfplaats voorkomen)
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100818                           |
    Als gba verblijfplaatsen wordt gezocht met de volgende parameters
    | naam                | waarde              |
    | type                | RaadpleegMetPeriode |
    | burgerservicenummer | 000000024           |
    | datumVan            | <datum van>         |
    | datumTot            | <datum tot>         |
    Dan heeft de response verblijfplaatsen met de volgende gegevens
    | adresseerbaarObjectIdentificatie | straat | datumAanvangAdreshouding | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving |
    | 0800010000000001                 | Laan   | 20100818                 | 0800                         | Hoogeloon, Hapert en Casteren        |

    Voorbeelden:
    | datum van  | datum tot  | scenario                                                                                                          |
    | 2010-09-01 | 2011-09-01 | De gevraagde periode ligt na datum aanvang verblijf van een verblijfplaats voorkomen                              |
    | 2010-01-01 | 2010-08-19 | datumTot van de gevraagde periode is gelijk aan de dag na datum aanvang verblijf van een verblijfplaats voorkomen |
    | 2010-08-18 | 2010-08-19 | datumVan van de gevraagde periode is gelijk aan datum aanvang verblijf van een verblijfplaats voorkomen           |
    # 24 |--A1--     |--A1-- |--A1--
    #      |---| |---|       |-|

  Abstract Scenario: <scenario> (wel vorige en geen volgende verblijfplaats voorkomen)
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100818                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20160526                           |
    Als gba verblijfplaatsen wordt gezocht met de volgende parameters
    | naam                | waarde              |
    | type                | RaadpleegMetPeriode |
    | burgerservicenummer | 000000024           |
    | datumVan            | <datum van>         |
    | datumTot            | 2020-01-01          |
    Dan heeft de response verblijfplaatsen met de volgende gegevens
    | adresseerbaarObjectIdentificatie | straat      | datumAanvangAdreshouding | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving |
    | 0800010000000002                 | Luttestraat | 20160526                 | 0800                         | Hoogeloon, Hapert en Casteren        |

    Voorbeelden:
    | datum van  | scenario                                                                               |
    | 2016-05-26 | De gevraagde periode begint op datum aanvang verblijf van een verblijfplaats voorkomen |
    | 2016-09-01 | De gevraagde periode begint na datum aanvang verblijf van een verblijfplaats voorkomen |
    # 24 |-A1-|--A2--  |-A1-|--A2--
    #         |---|           |---|

  Abstract Scenario: <scenario> (geen vorige en wel volgende verblijfplaats voorkomen)
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100818                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20160526                           |
    Als gba verblijfplaatsen wordt gezocht met de volgende parameters
    | naam                | waarde              |
    | type                | RaadpleegMetPeriode |
    | burgerservicenummer | 000000024           |
    | datumVan            | 2010-01-01          |
    | datumTot            | <datum tot>         |
    Dan heeft de response verblijfplaatsen met de volgende gegevens
    | adresseerbaarObjectIdentificatie | straat | datumAanvangAdreshouding | datumAanvangVolgendeAdreshouding | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving |
    | 0800010000000001                 | Laan   | 20100818                 | 20160526                         | 0800                         | Hoogeloon, Hapert en Casteren        |

    Voorbeelden:
    | datum tot  | scenario                                                                                                          |
    | 2016-05-26 | datumTot van de gevraagde periode is gelijk aan datum aanvang verblijf van het volgende verblijfplaats voorkomen  |
    | 2010-08-19 | datumTot van de gevraagde periode is gelijk aan de dag na datum aanvang verblijf van een verblijfplaats voorkomen |
    # 24  |--A1--|--A2--     |--A1--|--A2--
    #   |--------|       |---|

  Scenario: De gevraagde periode ligt tussen datum aanvang verblijf van een verblijfplaats voorkomen en datum aanvang verblijf van het volgende verblijfplaats voorkomen (wel vorige en wel volgende verblijfplaats voorkomen)
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100818                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20160526                           |
    En de persoon is vervolgens ingeschreven op adres 'A3' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20201008                           |
    Als gba verblijfplaatsen wordt gezocht met de volgende parameters
    | naam                | waarde              |
    | type                | RaadpleegMetPeriode |
    | burgerservicenummer | 000000024           |
    | datumVan            | 2016-10-01          |
    | datumTot            | 2020-07-01          |
    Dan heeft de response verblijfplaatsen met de volgende gegevens
    | adresseerbaarObjectIdentificatie | straat      | datumAanvangAdreshouding | datumAanvangVolgendeAdreshouding | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving |
    | 0800010000000002                 | Luttestraat | 20160526                 | 20201008                         | 0800                         | Hoogeloon, Hapert en Casteren        |
    # 24 |--A1--|--A2--|--A3--
    #            |---|

  Scenario: De gevraagde periode ligt tussen datum aanvang adreshouding op een locatie en datum aanvang verblijf van het volgende verblijfplaats voorkomen
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A4' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100818                           |
    En de persoon is vervolgens ingeschreven op adres 'A3' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20201008                           |
    Als gba verblijfplaatsen wordt gezocht met de volgende parameters
    | naam                | waarde              |
    | type                | RaadpleegMetPeriode |
    | burgerservicenummer | 000000024           |
    | datumVan            | 2016-10-01          |
    | datumTot            | 2020-07-01          |
    Dan heeft de response verblijfplaatsen met de volgende gegevens
    | locatiebeschrijving         | datumAanvangAdreshouding | datumAanvangVolgendeAdreshouding | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving |
    | Woonboot bij de Grote Sloot | 20100818                 | 20201008                         | 0800                         | Hoogeloon, Hapert en Casteren        |

  Scenario: De gevraagde periode ligt na datum aanvang adres buitenland van een verblijfplaats voorkomen
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100818                           |
    En de persoon is vervolgens ingeschreven op een buitenlands adres met de volgende gegevens
    | datum aanvang adres buitenland (13.20) | land adres buitenland (13.10) |
    | 20181201                               | 6014                          |
    Als gba verblijfplaatsen wordt gezocht met de volgende parameters
    | naam                | waarde              |
    | type                | RaadpleegMetPeriode |
    | burgerservicenummer | 000000024           |
    | datumVan            | 2019-10-01          |
    | datumTot            | 2020-07-01          |
    Dan heeft de response verblijfplaatsen met de volgende gegevens
    | land.code | land.omschrijving            | datumAanvangAdresBuitenland |
    | 6014      | Verenigde Staten van Amerika | 20181201                    |

  Scenario: De gevraagde persoon heeft meerdere verblijfplaats voorkomens met bekend datum aanvang verblijf die in de gevraagde periode liggen
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100818                           |
    En de persoon is vervolgens ingeschreven op adres 'A4' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20160526                           |
    En de persoon is vervolgens ingeschreven op een buitenlands adres met de volgende gegevens
    | datum aanvang adres buitenland (13.20) | land adres buitenland (13.10) |
    | 20181201                               | 6014                          |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20200415                           |
    Als gba verblijfplaatsen wordt gezocht met de volgende parameters
    | naam                | waarde              |
    | type                | RaadpleegMetPeriode |
    | burgerservicenummer | 000000024           |
    | datumVan            | 2010-07-01          |
    | datumTot            | 2020-07-01          |
    Dan heeft de response verblijfplaatsen met de volgende gegevens
    | land.code | land.omschrijving            | straat      | adresseerbaarObjectIdentificatie | locatiebeschrijving         | datumAanvangAdreshouding | datumAanvangVolgendeAdreshouding | datumAanvangAdresBuitenland | datumAanvangVolgendeAdresBuitenland | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving |
    |           |                              | Luttestraat | 0800010000000002                 |                             | 20200415                 |                                  |                             |                                     | 0800                         | Hoogeloon, Hapert en Casteren        |
    | 6014      | Verenigde Staten van Amerika |             |                                  |                             |                          | 20200415                         | 20181201                    |                                     |                              |                                      |
    |           |                              |             |                                  | Woonboot bij de Grote Sloot | 20160526                 |                                  |                             | 20181201                            | 0800                         | Hoogeloon, Hapert en Casteren        |
    |           |                              | Laan        | 0800010000000001                 |                             | 20100818                 | 20160526                         |                             |                                     | 0800                         | Hoogeloon, Hapert en Casteren        |

Rule: Een verblijfplaats voorkomen met deels/geheel onbekend datum aanvang verblijf wordt geleverd als datumTot van de gevraagde periode groter is dan de gehanteerde datum aanvang verblijf van het verblijfplaats voorkomen en bij volgende verblijfplaats voorkomen als datumVan kleiner is dan de (gehanteerde) datum aanvang verblijf van het volgende verblijfplaats voorkomen.

  De verblijfperiode van een verblijfplaats voorkomen heeft een onzekerheidsperiode als de datum aanvang verblijf geheel/deels onbekend is.
  Bij een datum aanvang waarvan de dag onbekend is, loopt de onzekerheidsperiode vanaf de eerste dag tot en met de laatste dag van de betreffende maand.
  Analoog voor een datum aanvang waarvan de maand en dag onbekend is, loopt de onzekerheidsperiode vanaf de eerste dag tot en met de laatste dag van het betreffende jaar.
  Voor een geheel onbekend datum aanvang loopt de onzekerheidsperiode vanaf 1-1-1 tot en met vandaag.

  Voor het bepalen of een verblijfplaats voorkomen met geheel/deels onbekend datum aanvang verblijf moet worden geleverd, wordt de eerste dag van de onzekerheidsperiode als datum aanvang gehanteerd,
  mits de gehanteerde datum aanvang niet op of vóór de (gehanteerde) datum aanvang van het vorige verblijfplaats voorkomen ligt.
  In dat geval wordt de dag na de (gehanteerde) datum aanvang van het vorige verblijfplaats voorkomen als datum aanvang verblijf gehanteerd.

  De verblijfplaats voorkomens worden aflopend gesorteerd geleverd.
  Het meest recente verblijfplaats voorkomen in de gevraagde periode is het eerste verblijfplaats voorkomen in de geleverde lijst.
  De sortering hoeft niet overeen te komen met het aflopend sorteren van de verblijfplaats voorkomens op datum aanvang adreshouding/adres buitenland. Dit is het geval als bijvoorbeeld de datum aanvang van een verblijfplaats voorkomen in de onzekerheidsperiode ligt van het volgende verblijfplaats voorkomen.

  Abstract Scenario: datumTot van de gevraagde periode ligt op de dag na de gehanteerde datum aanvang verblijf van een verblijfplaats voorkomen met deels onbekend datum aanvang verblijf (geen vorige en geen volgende verblijfplaats voorkomen)
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | <datum aanvang adreshouding>       |
    Als gba verblijfplaatsen wordt gezocht met de volgende parameters
    | naam                | waarde              |
    | type                | RaadpleegMetPeriode |
    | burgerservicenummer | 000000024           |
    | datumVan            | 2007-01-01          |
    | datumTot            | <datum tot>         |
    Dan heeft de response verblijfplaatsen met de volgende gegevens
    | adresseerbaarObjectIdentificatie | straat | datumAanvangAdreshouding     | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving |
    | 0800010000000001                 | Laan   | <datum aanvang adreshouding> | 0800                         | Hoogeloon, Hapert en Casteren        |

    Voorbeelden:
    | datum aanvang adreshouding | datum tot  |
    | 20100800                   | 2010-08-02 |
    | 20100000                   | 2010-01-02 |

  Abstract Scenario: <scenario> (wel vorige en geen volgende verblijfplaats voorkomen)
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100810                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20160000                           |
    Als gba verblijfplaatsen wordt gezocht met de volgende parameters
    | naam                | waarde              |
    | type                | RaadpleegMetPeriode |
    | burgerservicenummer | 000000024           |
    | datumVan            | <datum van>         |
    | datumTot            | <datum tot>         |
    Dan heeft de response verblijfplaatsen met de volgende gegevens
    | adresseerbaarObjectIdentificatie | straat      | datumAanvangAdreshouding | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving |
    | 0800010000000002                 | Luttestraat | 20160000                 | 0800                         | Hoogeloon, Hapert en Casteren        |

    Voorbeelden:
    | datum van  | datum tot  | scenario                                                                                                            |
    | 2016-01-01 | 2016-07-01 | de gevraagde periode begint op de eerste dag van de onzekerheidsperiode van het verblijfplaats voorkomen            |
    | 2016-02-02 | 2016-12-02 | de gevraagde periode ligt in de onzekerheidsperiode van het verblijfplaats voorkomen                                |
    | 2016-07-01 | 2017-07-01 | datumVan ligt in de onzekerheidsperiode en datumTot ligt na de onzekerheidsperiode van het verblijfplaats voorkomen |
    | 2017-01-01 | 2020-01-01 | de gevraagde periode ligt na de onzekerheidsperiode van het verblijfplaats voorkomen                                |

  Abstract Scenario: datum aanvang van het volgende verblijfplaats voorkomen ligt niet in de onzekerheidsperiode van een verblijfplaats voorkomen en datumVan van de gevraagde periode is groter of gelijk aan de eerste dag van de onzekerheidsperiode en kleiner dan datum aanvang volgende verblijf (geen vorige en wel volgende verblijfplaats voorkomen)
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100000                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20160526                           |
    Als gba verblijfplaatsen wordt gezocht met de volgende parameters
    | naam                | waarde              |
    | type                | RaadpleegMetPeriode |
    | burgerservicenummer | 000000024           |
    | datumVan            | <datum van>         |
    | datumTot            | 2017-01-01          |
    Dan heeft de response verblijfplaatsen met de volgende gegevens
    | adresseerbaarObjectIdentificatie | straat      | datumAanvangAdreshouding | datumAanvangVolgendeAdreshouding | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving |
    | 0800010000000002                 | Luttestraat | 20160526                 |                                  | 0800                         | Hoogeloon, Hapert en Casteren        |
    | 0800010000000001                 | Laan        | 20100000                 | 20160526                         | 0800                         | Hoogeloon, Hapert en Casteren        |

    Voorbeelden:
    | datum van  |
    | 2010-01-01 |
    | 2016-05-25 |
    # 24 |~~A1--|--A2--  |~~A1--|--A2--
    #    |----------|           |---|

  Scenario: datum aanvang van een verblijfplaats voorkomen ligt in de onzekerheidsperiode van het volgende verblijfplaats voorkomen en de gevraagde periode begint op de dag na datum aanvang van het verblijfplaats voorkomen
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20160810                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20160000                           |
    Als gba verblijfplaatsen wordt gezocht met de volgende parameters
    | naam                | waarde              |
    | type                | RaadpleegMetPeriode |
    | burgerservicenummer | 000000024           |
    | datumVan            | 2016-08-11          |
    | datumTot            | 2018-01-01          |
    Dan heeft de response verblijfplaatsen met de volgende gegevens
    | adresseerbaarObjectIdentificatie | straat      | datumAanvangAdreshouding | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving |
    | 0800010000000002                 | Luttestraat | 20160000                 | 0800                         | Hoogeloon, Hapert en Casteren        |

  Abstract Scenario: datum aanvang van een verblijfplaats voorkomen ligt in de onzekerheidsperiode van het volgende verblijfplaats voorkomen en de gevraagde periode eindigt op de dag na datum aanvang van het verblijfplaats voorkomen
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20160810                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20160000                           |
    Als gba verblijfplaatsen wordt gezocht met de volgende parameters
    | naam                | waarde              |
    | type                | RaadpleegMetPeriode |
    | burgerservicenummer | 000000024           |
    | datumVan            | <datum van>         |
    | datumTot            | 2016-08-11          |
    Dan heeft de response verblijfplaatsen met de volgende gegevens
    | adresseerbaarObjectIdentificatie | straat | datumAanvangAdreshouding | datumAanvangVolgendeAdreshouding | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving |
    | 0800010000000001                 | Laan   | 20160810                 | 20160000                         | 0800                         | Hoogeloon, Hapert en Casteren        |

    Voorbeelden:
    | datum van  |
    | 2016-08-10 |
    | 2016-01-01 |

  Scenario: De gevraagde persoon heeft meerdere verblijfplaatsen met deels onbekende datum aanvang adreshouding/adres buitenland die in de gevraagde periode liggen
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100600                           |
    En de persoon is vervolgens ingeschreven op adres 'A4' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100000                           |
    En de persoon is vervolgens ingeschreven op een buitenlands adres met de volgende gegevens
    | datum aanvang adres buitenland (13.20) | land adres buitenland (13.10) |
    | 20101026                               | 6014                          |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20200415                           |
    Als gba verblijfplaatsen wordt gezocht met de volgende parameters
    | naam                | waarde              |
    | type                | RaadpleegMetPeriode |
    | burgerservicenummer | 000000024           |
    | datumVan            | 2010-07-01          |
    | datumTot            | 2020-07-01          |
    Dan heeft de response verblijfplaatsen met de volgende gegevens
    | land.code | land.omschrijving            | straat      | adresseerbaarObjectIdentificatie | locatiebeschrijving         | datumAanvangAdreshouding | datumAanvangVolgendeAdreshouding | datumAanvangAdresBuitenland | datumAanvangVolgendeAdresBuitenland | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving |
    |           |                              | Luttestraat | 0800010000000002                 |                             | 20200415                 |                                  |                             |                                     | 0800                         | Hoogeloon, Hapert en Casteren        |
    | 6014      | Verenigde Staten van Amerika |             |                                  |                             |                          | 20200415                         | 20101026                    |                                     |                              |                                      |
    |           |                              |             |                                  | Woonboot bij de Grote Sloot | 20100000                 |                                  |                             | 20101026                            | 0800                         | Hoogeloon, Hapert en Casteren        |

  Scenario: gevraagde periode ligt in de onzekerheidsperiode van een verblijfplaats voorkomen met geheel onbekend datum aanvang verblijf en eindigt op datum aanvang van het volgende verblijfplaats voorkomen
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 00000000                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100625                           |
    Als gba verblijfplaatsen wordt gezocht met de volgende parameters
    | naam                | waarde              |
    | type                | RaadpleegMetPeriode |
    | burgerservicenummer | 000000024           |
    | datumVan            | 2009-07-01          |
    | datumTot            | 2010-06-25          |
    Dan heeft de response verblijfplaatsen met de volgende gegevens
    | adresseerbaarObjectIdentificatie | straat | datumAanvangAdreshouding | datumAanvangVolgendeAdreshouding | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving |
    | 0800010000000001                 | Laan   | 00000000                 | 20100625                         | 0800                         | Hoogeloon, Hapert en Casteren        |

  Scenario: gevraagde periode ligt in de onzekerheidsperiode van een verblijfplaats voorkomen met geheel onbekend datum aanvang verblijf en begint op de dag na datum aanvang van het vorige verblijfplaats voorkomen
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100625                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 00000000                           |
    Als gba verblijfplaatsen wordt gezocht met de volgende parameters
    | naam                | waarde              |
    | type                | RaadpleegMetPeriode |
    | burgerservicenummer | 000000024           |
    | datumVan            | 2010-06-26          |
    | datumTot            | 2020-01-01          |
    Dan heeft de response verblijfplaatsen met de volgende gegevens
    | adresseerbaarObjectIdentificatie | straat      | datumAanvangAdreshouding | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving |
    | 0800010000000002                 | Luttestraat | 00000000                 | 0800                         | Hoogeloon, Hapert en Casteren        |

  Scenario: De gevraagde persoon heeft meerdere verblijfplaats voorkomens met geheel onbekende datum aanvang adreshouding/adres buitenland en de gevraagde periode overlapt deze verblijfplaats voorkomens niet
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 00000000                           |
    En de persoon is vervolgens ingeschreven op adres 'A4' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100625                           |
    En de persoon is vervolgens ingeschreven op een buitenlands adres met de volgende gegevens
    | datum aanvang adres buitenland (13.20) | land adres buitenland (13.10) |
    | 20201201                               | 6014                          |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 00000000                           |
    Als gba verblijfplaatsen wordt gezocht met de volgende parameters
    | naam                | waarde              |
    | type                | RaadpleegMetPeriode |
    | burgerservicenummer | 000000024           |
    | datumVan            | 2010-07-01          |
    | datumTot            | 2020-07-01          |
    Dan heeft de response verblijfplaatsen met de volgende gegevens
    | locatiebeschrijving         | datumAanvangAdreshouding | datumAanvangVolgendeAdresBuitenland | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving |
    | Woonboot bij de Grote Sloot | 20100625                 | 20201201                            | 0800                         | Hoogeloon, Hapert en Casteren        |

Rule: Een verblijfplaats buitenland van een persoon wordt niet geleverd als de optionele 'exclusiefVerblijfplaatsBuitenland' parameter wordt opgegeven

  Scenario: De gevraagde persoon heeft een verblijfplaats met datum aanvang adres buitenland die in de gevraagde periode ligt
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100818                           |
    En de persoon is vervolgens ingeschreven op adres 'A4' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20160526                           |
    En de persoon is vervolgens ingeschreven op een buitenlands adres met de volgende gegevens
    | datum aanvang adres buitenland (13.20) | land adres buitenland (13.10) |
    | 20181201                               | 6014                          |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20200415                           |
    Als gba verblijfplaatsen wordt gezocht met de volgende parameters
    | naam                              | waarde              |
    | type                              | RaadpleegMetPeriode |
    | burgerservicenummer               | 000000024           |
    | datumVan                          | 2010-07-01          |
    | datumTot                          | 2020-07-01          |
    | exclusiefVerblijfplaatsBuitenland | true                |
    Dan heeft de response verblijfplaatsen met de volgende gegevens
    | straat      | adresseerbaarObjectIdentificatie | locatiebeschrijving         | datumAanvangAdreshouding | datumAanvangVolgendeAdreshouding | datumAanvangVolgdendeAdresBuitenland | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving |
    | Luttestraat | 0800010000000002                 |                             | 20200415                 |                                  |                                      | 0800                         | Hoogeloon, Hapert en Casteren        |
    |             |                                  | Woonboot bij de Grote Sloot | 20160526                 |                                  | 20181201                             | 0800                         | Hoogeloon, Hapert en Casteren        |
    | Laan        | 0800010000000001                 |                             | 20100818                 | 20160526                         |                                      | 0800                         | Hoogeloon, Hapert en Casteren        |
