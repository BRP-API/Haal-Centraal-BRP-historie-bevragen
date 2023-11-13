#language: nl

@gba
Functionaliteit: raadpleeg verblijfplaats voorkomens in een periode

  Als consumer van de Historie bevragen API
  wil ik kunnen opvragen waar een persoon in een periode heeft verbleven
  zodat ik deze informatie kan gebruiken in mijn proces

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

Rule: Een verblijfplaats van een persoon met bekend datum aanvang adreshouding/adres buitenland wordt geleverd als datumTot van de gevraagde periode groter is dan datum aanvang adreshouding/adres buitenland en in het geval van een volgende adreshouding/adres buitenland is de datumVan kleiner dan datum aanvang volgende adreshouding/adres buitenland

  De verblijfplaatsen worden aflopend gesorteerd geleverd. De eerste verblijfplaats in de verblijfplaatsen lijst is de meest recente verblijfplaats in de gevraagde periode.
  Komt er in de gevraagde periode alleen verblijfplaatsen voor met bekend datum aanvang adreshouding/adres buitenland, dan is de sortering gelijk aan het aflopend sorteren op datum aanvang adreshouding/adres buitenland.

  Abstract Scenario: <scenario> (geen vorige en geen volgende verblijfplaats)
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
    | adresseerbaarObjectIdentificatie | straat | datumAanvangAdreshouding |
    | 0800010000000001                 | Laan   | 20100818                 |

    Voorbeelden:
    | datum van  | datum tot  | scenario                                                                             |
    | 2010-09-01 | 2011-09-01 | De gevraagde periode ligt na datum aanvang adreshouding                              |
    | 2010-01-01 | 2010-08-19 | datumTot van de gevraagde periode is gelijk aan de dag na datum aanvang adreshouding |
    # 24 |--A1--     |--A1--
    #      |---| |---|

  Abstract Scenario: <scenario> (wel vorige en geen volgende verblijfplaats)
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
    | datumVan            | 2016-09-01          |
    | datumTot            | 2020-01-01          |
    Dan heeft de response verblijfplaatsen met de volgende gegevens
    | adresseerbaarObjectIdentificatie | straat      | datumAanvangAdreshouding |
    | 0800010000000002                 | Luttestraat | 20160526                 |

    Voorbeelden:
    | datum van  | scenario                                                  |
    | 2016-05-26 | De gevraagde periode begint op datum aanvang adreshouding |
    | 2016-09-01 | De gevraagde periode begint na datum aanvang adreshouding |
    # 24 |-A1-|--A2--  |-A1-|--A2--
    #         |---|           |---|

  Abstract Scenario: <scenario> (geen vorige verblijfplaats en wel volgende verblijfplaats)
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
    | adresseerbaarObjectIdentificatie | straat | datumAanvangAdreshouding | datumAanvangVolgendeAdreshouding |
    | 0800010000000001                 | Laan   | 20100818                 | 20160526                         |

    Voorbeelden:
    | datum tot  | scenario                                                                             |
    | 2016-05-26 | datumTot van de gevraagde periode is gelijk aan datum aanvang volgende adreshouding  |
    | 2010-08-19 | datumTot van de gevraagde periode is gelijk aan de dag na datum aanvang adreshouding |
    # 24  |--A1--|--A2--     |--A1--|--A2--
    #   |--------|       |---|

  Scenario: De gevraagde periode ligt tussen datum aanvang adreshouding en datum aanvang volgende adreshouding (wel vorige verblijfplaats en wel volgende verblijfplaats)
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
    | adresseerbaarObjectIdentificatie | straat      | datumAanvangAdreshouding | datumAanvangVolgendeAdreshouding |
    | 0800010000000002                 | Luttestraat | 20160526                 | 20201008                         |
    # 24 |--A1--|--A2--|--A3--
    #            |---|

  Scenario: De gevraagde periode ligt tussen datum aanvang adreshouding op een locatie en datum aanvang volgende adreshouding
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
    | locatiebeschrijving         | datumAanvangAdreshouding | datumAanvangVolgendeAdreshouding |
    | Woonboot bij de Grote Sloot | 20100818                 | 20201008                         |

  Scenario: De gevraagde periode ligt na datum aanvang adres buitenland
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

  Scenario: De gevraagde persoon heeft meerdere verblijfplaatsen met bekend datum aanvang adreshouding/adres buitenland die in de gevraagde periode liggen
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
    | land.code | land.omschrijving            | straat      | adresseerbaarObjectIdentificatie | locatiebeschrijving         | datumAanvangAdreshouding | datumAanvangVolgendeAdreshouding | datumAanvangAdresBuitenland | datumAanvangVolgendeAdresBuitenland |
    |           |                              | Luttestraat | 0800010000000002                 |                             | 20200415                 |                                  |                             |                                     |
    | 6014      | Verenigde Staten van Amerika |             |                                  |                             |                          | 20200415                         | 20181201                    |                                     |
    |           |                              |             |                                  | Woonboot bij de Grote Sloot | 20160526                 |                                  |                             | 20181201                            |
    |           |                              | Laan        | 0800010000000001                 |                             | 20100818                 | 20160526                         |                             |                                     |

Rule: Een verblijfplaats van een persoon met deels onbekende datum aanvang adreshouding/adres buitenland wordt geleverd als datumTot van de gevraagde periode groter is dan de eerste dag van de deels onbekende datum aanvang adreshouding/adres buitenland en in het geval van een volgende adreshouding/adres buitenland is de datumVan kleiner dan datum aanvang volgende adreshouding/adres buitenland

  Bij een datum aanvang adreshouding/adres buitenland waarvan de dag onbekend is, wordt de eerste dag van de betreffende maand als datum aanvang adreshouding/adres buitenland gehanteerd. Bijvoorbeeld bij 20100800 wordt 20100801 gehanteerd.
  Analoog wordt, bij een datum aanvang adreshouding/adres buitenland waarvan de dag en maand onbekend is, de eerste dag van het betreffende jaar als datum aanvang adreshouding/adres buitenland gehanteerd. Bijvoorbeeld bij 20100000 wordt 20100101 gehanteerd.

  De verblijfplaatsen worden aflopend gesorteerd geleverd. De eerste verblijfplaats in de verblijfplaatsen lijst is de meest recente verblijfplaats in de gevraagde periode.
  In tegenstelling tot verblijfplaatsen met bekend datum aanvang adreshouding/adres buitenland, hoeft de sortering niet overeen te komen met het aflopend sorteren op datum aanvang adreshouding/adres buitenland.
  Dit is bijvoorbeeld het geval bij een verblijfplaats met datum aanvang adreshouding die in de onzekerheidsperiode ligt van een volgende verblijfplaats met deels onbekende datum aanvang adreshouding en de datum aanvang adreshouding ligt in de gevraagde periode.

  Abstract Scenario: datumTot van de gevraagde periode is gelijk aan de tweede dag van de deels onbekende datum aanvang adreshouding (geen vorige en geen volgende verblijfplaats)
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
    | adresseerbaarObjectIdentificatie | straat | datumAanvangAdreshouding     |
    | 0800010000000001                 | Laan   | <datum aanvang adreshouding> |

    Voorbeelden:
    | datum aanvang adreshouding | datum tot  |
    | 20100800                   | 2010-08-02 |
    | 20100000                   | 2010-01-02 |

  Abstract Scenario: <scenario> (wel vorige en geen volgende verblijfplaats)
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
    | adresseerbaarObjectIdentificatie | straat | datumAanvangAdreshouding     |
    | 0800010000000001                 | Laan   | <datum aanvang adreshouding> |

    Voorbeelden:
    | datum van  | datum tot  | scenario                                                                                               |
    | 2016-02-02 | 2016-12-02 | de gevraagde periode ligt in de onzekerheidsperiode van de adreshouding                                |
    | 2016-07-01 | 2017-07-01 | datumVan ligt in de onzekerheidsperiode en datumTot ligt na de onzekerheidsperiode van de adreshouding |
    | 2017-01-01 | 2020-01-01 | de gevraagde periode ligt na de onzekerheidsperiode van de adreshouding                                |

  Abstract Scenario: datumVan van de gevraagde periode ligt tussen de eerste dag van de deels onbekende datum aanvang adreshouding en datum aanvang volgende adreshouding (geen vorige en wel volgende verblijfplaats)
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
    | adresseerbaarObjectIdentificatie | straat      | datumAanvangAdreshouding | datumAanvangVolgendeAdreshouding |
    | 0800010000000002                 | Luttestraat | 20160526                 |                                  |
    | 0800010000000001                 | Laan        | 20100000                 | 20160526                         |

    Voorbeelden:
    | datum van  |
    | 2010-01-01 |
    | 2016-05-25 |
    # 24 |~~A1--|--A2--  |~~A1--|--A2--
    #    |----------|           |---|

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
    | land.code | land.omschrijving            | straat      | adresseerbaarObjectIdentificatie | locatiebeschrijving         | datumAanvangAdreshouding | datumAanvangVolgendeAdreshouding | datumAanvangAdresBuitenland | datumAanvangVolgendeAdresBuitenland |
    |           |                              | Luttestraat | 0800010000000002                 |                             | 20200415                 |                                  |                             |                                     |
    | 6014      | Verenigde Staten van Amerika |             |                                  |                             |                          | 20200415                         | 20101026                    |                                     |
    |           |                              |             |                                  | Woonboot bij de Grote Sloot | 20100000                 |                                  |                             | 20101026                            |
    |           |                              | Laan        | 0800010000000001                 |                             | 20100600                 | 20100000                         |                             |                                     |

Rule: Een verblijfplaats van een persoon met geheel onbekende datum aanvang adreshouding/adres buitenland wordt altijd geleverd

  Bij een geheel onbekende datum aanvang adreshouding/adres buitenland wordt de eerste dag van jaar 1 (00010101) als datum aanvang adreshouding/adres buitenland gehanteerd.

  Scenario: De gevraagde persoon heeft meerdere verblijfplaatsen met geheel onbekende datum aanvang adreshouding/adres buitenland
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
    | land.code | land.omschrijving | straat      | adresseerbaarObjectIdentificatie | locatiebeschrijving         | datumAanvangAdreshouding | datumAanvangVolgendeAdreshouding | datumAanvangVolgendeAdresBuitenland |
    |           |                   | Luttestraat | 0800010000000002                 |                             | 00000000                 |                                  |                                     |
    |           |                   |             |                                  | Woonboot bij de Grote Sloot | 20100625                 |                                  | 20201201                            |
    |           |                   | Laan        | 0800010000000001                 |                             | 00000000                 | 20100625                         |                                     |

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
    | straat      | adresseerbaarObjectIdentificatie | locatiebeschrijving         | datumAanvangAdreshouding | datumAanvangVolgendeAdreshouding | datumAanvangVolgdendeAdresBuitenland |
    | Luttestraat | 0800010000000002                 |                             | 20200415                 |                                  |                                      |
    |             |                                  | Woonboot bij de Grote Sloot | 20160526                 |                                  | 20181201                             |
    | Laan        | 0800010000000001                 |                             | 20100818                 | 20160526                         |                                      |
