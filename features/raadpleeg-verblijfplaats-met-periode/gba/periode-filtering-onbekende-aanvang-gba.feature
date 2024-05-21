#language: nl

@gba
Functionaliteit: test dat alleen verblijfplaatsen met onbekende datum aanvang die binnen de gevraagde periode vallen worden geleverd

    Achtergrond:
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | straatnaam (11.10) |
      | 0800                 | 0800010000000001                         | Eerste straat      |
      En adres 'A2' heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | straatnaam (11.10) |
      | 0800                 | 0800010000000002                         | Tweede straat      |
      En adres 'A3' heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | straatnaam (11.10) |
      | 0800                 | 0800010000000003                         | Derde straat       |
      En adres 'A4' heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | straatnaam (11.10) |
      | 0800                 | 0800010000000004                         | Vierde straat      |

  Rule: De verblijfplaats wordt niet geleverd wanneer gevraagde periode eindigt voor de 1e dag van de onzekerheidsperiode van de aanvang
    # Dit is het geval wanneer de 1e dag van de onzekerheidsperiode ≥ parameter datumTot

    Abstract Scenario: verblijf met aanvang adreshouding <soort datum> wordt geleverd, omdat <omschrijving>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20080818                           |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <aanvang adreshouding>             |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2008-01-01          |
      | datumTot            | <datum tot>         |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | adresseerbaarObjectIdentificatie | straat        | datumAanvangAdreshouding | datumAanvangVolgendeAdreshouding |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000002                 | Tweede straat | <aanvang adreshouding>   |                                  |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000001                 | Eerste straat | 20080818                 | <aanvang adreshouding>           |

      Voorbeelden:
      | soort datum               | aanvang adreshouding | omschrijving                                      | datum tot  |
      | volledig onbekend         | 00000000             | datumTot ligt in onzekerheidsperiode              | 2010-05-26 |
      | alleen jaar is bekend     | 20100000             | datumTot ligt in onzekerheidsperiode              | 2010-05-26 |
      | alleen jaar is bekend     | 20100000             | datumTot is dag na eerste dag onzekerheidsperiode | 2010-01-02 |
      | alleen jaar is bekend     | 20100000             | datumTot is eerste dag na onzekerheidsperiode     | 2011-01-01 |
      | jaar en maand zijn bekend | 20100500             | datumTot ligt in onzekerheidsperiode              | 2010-05-26 |
      | jaar en maand zijn bekend | 20100500             | datumTot is dag na eerste dag onzekerheidsperiode | 2010-05-02 |
      | jaar en maand zijn bekend | 20100500             | datumTot is eerste dag na onzekerheidsperiode     | 2010-06-01 |
      | alleen jaar is bekend     | 20100000             | datumTot ligt na onzekerheidsperiode              | 2011-07-30 |
      | jaar en maand zijn bekend | 20100500             | datumTot ligt na onzekerheidsperiode              | 2010-07-30 |

    Abstract Scenario: verblijf met aanvang adreshouding <soort datum> wordt niet geleverd, omdat <omschrijving>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20080818                           |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <aanvang adreshouding>             |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2009-01-01          |
      | datumTot            | <datum tot>         |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | adresseerbaarObjectIdentificatie | straat        | datumAanvangAdreshouding | datumAanvangVolgendeAdreshouding |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000001                 | Eerste straat | 20080818                 | <aanvang adreshouding>           |

      Voorbeelden:
      | soort datum               | aanvang adreshouding | omschrijving                                          | datum tot  |
      | alleen jaar is bekend     | 20100000             | datumTot ligt voor begin onzekerheidsperiode          | 2009-07-01 |
      | jaar en maand zijn bekend | 20100500             | datumTot ligt voor begin onzekerheidsperiode          | 2010-03-01 |
      | alleen jaar is bekend     | 20100000             | datumTot is gelijk aan eerste dag onzekerheidsperiode | 2010-01-01 |
      | jaar en maand zijn bekend | 20100500             | datumTot is gelijk aan eerste dag onzekerheidsperiode | 2010-05-01 |

    Abstract Scenario: verblijf buitenland met aanvang <soort datum> wordt geleverd, omdat <omschrijving>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20080818                           |
      En de persoon is vervolgens ingeschreven op een buitenlands adres met de volgende gegevens
      | datum aanvang adres buitenland (13.20) | land adres buitenland (13.10) |
      | <aanvang adreshouding>                 | 6014                          |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20160526                           |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2008-01-01          |
      | datumTot            | <datum tot>         |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | adresseerbaarObjectIdentificatie | straat        | land.code | land.omschrijving            | datumAanvangAdreshouding | datumAanvangAdresBuitenland | datumAanvangVolgendeAdreshouding | datumAanvangVolgendeAdresBuitenland |
      |                              |                                      |                                  |               | 6014      | Verenigde Staten van Amerika |                          | <aanvang adreshouding>      | 20160526                         |                                     |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000001                 | Eerste straat |           |                              | 20080818                 |                             |                                  | <aanvang adreshouding>              |

      Voorbeelden:
      | soort datum               | aanvang adreshouding | omschrijving                                      | datum tot  |
      | volledig onbekend         | 00000000             | datumTot ligt in onzekerheidsperiode              | 2010-05-26 |
      | alleen jaar is bekend     | 20100000             | datumTot ligt in onzekerheidsperiode              | 2010-05-26 |
      | alleen jaar is bekend     | 20100000             | datumTot is dag na eerste dag onzekerheidsperiode | 2010-01-02 |
      | alleen jaar is bekend     | 20100000             | datumTot is eerste dag na onzekerheidsperiode     | 2011-01-01 |
      | jaar en maand zijn bekend | 20100500             | datumTot ligt in onzekerheidsperiode              | 2010-05-26 |
      | jaar en maand zijn bekend | 20100500             | datumTot is dag na eerste dag onzekerheidsperiode | 2010-05-02 |
      | jaar en maand zijn bekend | 20100500             | datumTot is eerste dag na onzekerheidsperiode     | 2010-06-01 |
      | alleen jaar is bekend     | 20100000             | datumTot ligt na onzekerheidsperiode              | 2011-07-30 |
      | jaar en maand zijn bekend | 20100500             | datumTot ligt na onzekerheidsperiode              | 2010-07-30 |

    Abstract Scenario: verblijf buitenland met aanvang <soort datum> wordt niet geleverd, omdat <omschrijving>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20080818                           |
      En de persoon is vervolgens ingeschreven op een buitenlands adres met de volgende gegevens
      | datum aanvang adres buitenland (13.20) | land adres buitenland (13.10) |
      | <aanvang adreshouding>                 | 6014                          |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20160526                           |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2009-01-01          |
      | datumTot            | <datum tot>         |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | adresseerbaarObjectIdentificatie | straat        | datumAanvangAdreshouding | datumAanvangVolgendeAdresBuitenland |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000001                 | Eerste straat | 20080818                 | <aanvang adreshouding>              |

      Voorbeelden:
      | soort datum               | aanvang adreshouding | omschrijving                                          | datum tot  |
      | alleen jaar is bekend     | 20100000             | datumTot ligt voor begin onzekerheidsperiode          | 2009-07-01 |
      | jaar en maand zijn bekend | 20100500             | datumTot ligt voor begin onzekerheidsperiode          | 2010-03-01 |
      | alleen jaar is bekend     | 20100000             | datumTot is gelijk aan eerste dag onzekerheidsperiode | 2010-01-01 |
      | jaar en maand zijn bekend | 20100500             | datumTot is gelijk aan eerste dag onzekerheidsperiode | 2010-05-01 |

  Rule: Een verblijfplaats met onbekende aanvang van het verblijf en (bekende) aanvang vorige verblijf binnen de onzekerheidsperiode wordt niet geleverd wanneer de gevraagde periode eindigt op of voor de aanvang vorige verblijf
    # Dit is het geval wanneer de dag na aanvang vorige ≥ parameter datumTot

    # Op dag aanvang vorige verblijft de persoon zeker op het vorige verblijf, en dus niet op het betreffende adres
    # Op de dag na aanvang vorige en binnen onzekerheidsperiode, verblijft de persoon mogelijk op het vorige en mogeijk op het betreffende adres
    # Met datumTot wordt gevraagd tot de dag voor datumTot, dus:
    #   met datumTot=aanvang vorige wordt periode gevraagd t/m dag voor aanvang vorige en verblijft persoon op voor-vorige adres
    #   met datumTot=dag na aanvang vorige wordt periode gevraagd t/m aanvang vorige en verblijft persoon op de laatste dag van de gevraagde periode op vorige adres
    #   met datumTot=2 dagen na aanvang vorige wordt periode gevraagd t/m dag na aanvang vorige en verblijft persoon op laatste dag gevraagde periode mogelijk op vorige en mogelijk op betreffende adres

    Abstract Scenario: verblijf met aanvang adreshouding <soort datum> wordt geleverd, omdat er geen vorige verblijfplaats is
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <aanvang adreshouding>             |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2010-05-16          |
      | datumTot            | 2010-05-26          |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | adresseerbaarObjectIdentificatie | straat        | datumAanvangAdreshouding |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000001                 | Eerste straat | <aanvang adreshouding>   |

      Voorbeelden:
      | soort datum               | aanvang adreshouding |
      | volledig onbekend         | 00000000             |
      | alleen jaar is bekend     | 20100000             |
      | jaar en maand zijn bekend | 20100500             |

    Abstract Scenario: verblijf met aanvang adreshouding <soort datum> wordt geleverd, omdat de aanvang vorige verblijfplaats voor de onzekerheidsperiode ligt
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20080818                           |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <aanvang adreshouding>             |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2010-05-16          |
      | datumTot            | 2010-05-26          |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | adresseerbaarObjectIdentificatie | straat        | datumAanvangAdreshouding | datumAanvangVolgendeAdreshouding |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000002                 | Tweede straat | <aanvang adreshouding>   |                                  |

      Voorbeelden:
      | soort datum               | aanvang adreshouding |
      | alleen jaar is bekend     | 20100000             |
      | jaar en maand zijn bekend | 20100500             |

    Abstract Scenario: verblijf met aanvang adreshouding <soort datum> en (bekende) aanvang vorige in de onzekerheidsperiode wordt geleverd, omdat <omschrijving>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20100526                           |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <aanvang adreshouding>             |
      En de persoon is vervolgens ingeschreven op adres 'A3' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20161014                           |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2010-02-19          |
      | datumTot            | <datum tot>         |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | adresseerbaarObjectIdentificatie | straat        | datumAanvangAdreshouding | datumAanvangVolgendeAdreshouding |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000002                 | Tweede straat | <aanvang adreshouding>   | 20161014                         |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000001                 | Eerste straat | 20100526                 | <aanvang adreshouding>           |

      Voorbeelden:
      | soort datum               | aanvang adreshouding | omschrijving                                              | datum tot  |
      | volledig onbekend         | 00000000             | datumTot ligt in onzekerheidsperiode en na aanvang vorige | 2012-01-01 |
      | alleen jaar is bekend     | 20100000             | datumTot ligt in onzekerheidsperiode en na aanvang vorige | 2010-08-01 |
      | jaar en maand zijn bekend | 20100500             | datumTot ligt in onzekerheidsperiode en na aanvang vorige | 2010-05-31 |
      | volledig onbekend         | 00000000             | datumTot is 2 dagen na aanvang vorige                     | 2010-05-28 |
      | alleen jaar is bekend     | 20100000             | datumTot is 2 dagen na aanvang vorige                     | 2010-05-28 |
      | jaar en maand zijn bekend | 20100500             | datumTot is 2 dagen na aanvang vorige                     | 2010-05-28 |
      | alleen jaar is bekend     | 20100000             | datumTot ligt na onzekerheidsperiode                      | 2011-03-14 |
      | jaar en maand zijn bekend | 20100500             | datumTot ligt na onzekerheidsperiode                      | 2010-07-01 |

    Abstract Scenario: verblijf met aanvang adreshouding <soort datum> en (bekende) aanvang vorige in de onzekerheidsperiode wordt niet geleverd, omdat <omschrijving>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20071014                           |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20100526                           |
      En de persoon is vervolgens ingeschreven op adres 'A3' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <aanvang adreshouding>             |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2009-02-19          |
      | datumTot            | <datum tot>         |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | adresseerbaarObjectIdentificatie | straat        | datumAanvangAdreshouding | datumAanvangVolgendeAdreshouding |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000001                 | Eerste straat | 20071014                 | 20100526                         |

      Voorbeelden:
      | soort datum               | aanvang adreshouding | omschrijving                                                | datum tot  |
      | volledig onbekend         | 00000000             | datumTot ligt in onzekerheidsperiode en voor aanvang vorige | 2010-01-01 |
      | alleen jaar is bekend     | 20100000             | datumTot ligt in onzekerheidsperiode en voor aanvang vorige | 2010-04-01 |
      | jaar en maand zijn bekend | 20100500             | datumTot ligt in onzekerheidsperiode en voor aanvang vorige | 2010-05-10 |
      | volledig onbekend         | 00000000             | datumTot is gelijk aan aanvang vorige                       | 2010-05-26 |
      | alleen jaar is bekend     | 20100000             | datumTot is gelijk aan aanvang vorige                       | 2010-05-26 |
      | jaar en maand zijn bekend | 20100500             | datumTot is gelijk aan aanvang vorige                       | 2010-05-26 |

    Abstract Scenario: verblijf met aanvang adreshouding <soort datum> en (bekende) aanvang vorige in de onzekerheidsperiode wordt niet geleverd, omdat <omschrijving>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20071014                           |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20100526                           |
      En de persoon is vervolgens ingeschreven op adres 'A3' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <aanvang adreshouding>             |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2009-02-19          |
      | datumTot            | <datum tot>         |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | adresseerbaarObjectIdentificatie | straat        | datumAanvangAdreshouding | datumAanvangVolgendeAdreshouding |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000002                 | Tweede straat | 20100526                 | <aanvang adreshouding>           |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000001                 | Eerste straat | 20071014                 | 20100526                         |

      Voorbeelden:
      | soort datum               | aanvang adreshouding | omschrijving                                                | datum tot  |
      | volledig onbekend         | 00000000             | datumTot is de dag na aanvang vorige                        | 2010-05-27 |
      | alleen jaar is bekend     | 20100000             | datumTot is de dag na aanvang vorige                        | 2010-05-27 |
      | jaar en maand zijn bekend | 20100500             | datumTot is de dag na aanvang vorige                        | 2010-05-27 |

    Abstract Scenario: verblijf buitenland met aanvang adreshouding <soort datum> en (bekende) aanvang vorige in de onzekerheidsperiode wordt niet geleverd, omdat <omschrijving>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20071014                           |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20100526                           |
      En de persoon is vervolgens ingeschreven op een buitenlands adres met de volgende gegevens
      | datum aanvang adres buitenland (13.20) | land adres buitenland (13.10) |
      | <aanvang adreshouding>                 | 6014                          |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2009-02-19          |
      | datumTot            | <datum tot>         |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | adresseerbaarObjectIdentificatie | straat        | datumAanvangAdreshouding | datumAanvangVolgendeAdreshouding | datumAanvangVolgendeAdresBuitenland |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000002                 | Tweede straat | 20100526                 |                                  | <aanvang adreshouding>              |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000001                 | Eerste straat | 20071014                 | 20100526                         |                                     |

      Voorbeelden:
      | soort datum               | aanvang adreshouding | omschrijving                                                | datum tot  |
      | volledig onbekend         | 00000000             | datumTot is de dag na aanvang vorige                        | 2010-05-27 |
      | alleen jaar is bekend     | 20100000             | datumTot is de dag na aanvang vorige                        | 2010-05-27 |
      | jaar en maand zijn bekend | 20100500             | datumTot is de dag na aanvang vorige                        | 2010-05-27 |

    Abstract Scenario: verblijf met aanvang adreshouding <soort datum> en (bekende) aanvang vorige verblijf buitenland in de onzekerheidsperiode wordt niet geleverd, omdat <omschrijving>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20071014                           |
      En de persoon is vervolgens ingeschreven op een buitenlands adres met de volgende gegevens
      | datum aanvang adres buitenland (13.20) | land adres buitenland (13.10) |
      | 20100526                               | 6014                          |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <aanvang adreshouding>             |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2009-02-19          |
      | datumTot            | <datum tot>         |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | adresseerbaarObjectIdentificatie | straat        | land.code | land.omschrijving            | datumAanvangAdreshouding | datumAanvangAdresBuitenland | datumAanvangVolgendeAdreshouding | datumAanvangVolgendeAdresBuitenland |
      |                              |                                      |                                  |               | 6014      | Verenigde Staten van Amerika |                          | 20100526                    | <aanvang adreshouding>           |                                     |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000001                 | Eerste straat |           |                              | 20071014                 |                             |                                  | 20100526                            |

      Voorbeelden:
      | soort datum               | aanvang adreshouding | omschrijving                                                | datum tot  |
      | volledig onbekend         | 00000000             | datumTot is de dag na aanvang vorige                        | 2010-05-27 |
      | alleen jaar is bekend     | 20100000             | datumTot is de dag na aanvang vorige                        | 2010-05-27 |
      | jaar en maand zijn bekend | 20100500             | datumTot is de dag na aanvang vorige                        | 2010-05-27 |
