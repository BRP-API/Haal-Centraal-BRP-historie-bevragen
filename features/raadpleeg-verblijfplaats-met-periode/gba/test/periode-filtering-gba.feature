#language: nl

@gba
Functionaliteit: test dat alleen verblijfplaatsen die binnen de gevraagde periode vallen worden geleverd

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


  Rule: Een verblijfplaats wordt niet geleverd, wanneer de gevraagde periode ligt voor het betreffende verblijf
    # Dit is het geval wanneer de (bekende) aanvang adreshouding ≥ parameter datumTot

    Abstract Scenario: periode ligt voor eerste verblijf met <omschrijving>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20100818                           |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20160526                           |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2009-01-01          |
      | datumTot            | <datum tot>         |
      Dan heeft de response 0 verblijfplaatsen

      Voorbeelden:
      | omschrijving                                      | datum tot  |
      | datumTot ligt voor datum aanvang adreshouding     | 2010-01-01 |
      | datumTot is gelijk aan datum aanvang adreshouding | 2010-08-18 |

    Abstract Scenario: verblijf wordt geleverd, omdat <omschrijving>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20100818                           |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2010-01-01          |
      | datumTot            | <datum tot>         |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | adresseerbaarObjectIdentificatie | straat        | datumAanvangAdreshouding |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000001                 | Eerste straat | 20100818                 |

      Voorbeelden:
      | omschrijving                     | datum tot  |
      | datumTot is dag na datum aanvang | 2010-08-19 |
      | datumTot ligt na datum aanvang   | 2014-01-01 |

    Abstract Scenario: tweede verblijf wordt niet geleverd, omdat <omschrijving>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20100818                           |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20160526                           |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2010-01-01          |
      | datumTot            | <datum tot>         |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | adresseerbaarObjectIdentificatie | straat        | datumAanvangAdreshouding | datumAanvangVolgendeAdreshouding |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000001                 | Eerste straat | 20100818                 | 20160526                         |

      Voorbeelden:
      | omschrijving                         | datum tot  |
      | datumTot ligt voor datum aanvang     | 2014-01-01 |
      | datumTot is gelijk aan datum aanvang | 2016-05-26 |

    Abstract Scenario: verblijf buitenland wordt geleverd, omdat <omschrijving>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20041014                           |
      En de persoon is vervolgens ingeschreven op een buitenlands adres met de volgende gegevens
      | datum aanvang adres buitenland (13.20) | land adres buitenland (13.10) |
      | 20100818                               | 6014                          |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20160526                           |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2010-01-01          |
      | datumTot            | <datum tot>         |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | adresseerbaarObjectIdentificatie | straat        | land.code | land.omschrijving            | datumAanvangAdreshouding | datumAanvangAdresBuitenland | datumAanvangVolgendeAdreshouding | datumAanvangVolgendeAdresBuitenland |
      |                              |                                      |                                  |               | 6014      | Verenigde Staten van Amerika |                          | 20100818                    | 20160526                         |                                     |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000001                 | Eerste straat |           |                              | 20041014                 |                             |                                  | 20100818                            |

      Voorbeelden:
      | omschrijving                                                 | datum tot  |
      | datumTot is dag na datum aanvang                             | 2010-08-19 |
      | datumTot ligt tussen datum aanvang en datum aanvang volgende | 2014-01-01 |

    Abstract Scenario: verblijf buitenland wordt niet geleverd, omdat <omschrijving>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20041014                           |
      En de persoon is vervolgens ingeschreven op een buitenlands adres met de volgende gegevens
      | datum aanvang adres buitenland (13.20) | land adres buitenland (13.10) |
      | 20100818                               | 6014                          |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20160526                           |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2010-01-01          |
      | datumTot            | <datum tot>         |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | adresseerbaarObjectIdentificatie | straat        | datumAanvangAdreshouding | datumAanvangVolgendeAdresBuitenland |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000001                 | Eerste straat | 20041014                 | 20100818                            |

      Voorbeelden:
      | omschrijving                                               | datum tot  |
      | datumTot ligt voor datum aanvang en datum aanvang volgende | 2010-05-26 |
      | datumTot is gelijk aan datum aanvang                       | 2010-08-18 |

  Rule: Een verblijfplaats wordt niet geleverd, wanneer de gevraagde periode begint na vertrek uit betreffende verblijf
    # Dit is het geval wanneer de (bekende) aanvang volgende adreshouding ≤ parameter datumVan

    Scenario: verblijf wordt geleverd, omdat er geen volgende verblijf is
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20100818                           |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2010-01-01          |
      | datumTot            | 2020-01-01          |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | adresseerbaarObjectIdentificatie | straat        | datumAanvangAdreshouding |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000001                 | Eerste straat | 20100818                 |

    Abstract Scenario: verblijf wordt geleverd, omdat <omschrijving>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20100818                           |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20160526                           |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | <datum van>         |
      | datumTot            | 2020-01-01          |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | adresseerbaarObjectIdentificatie | straat        | datumAanvangAdreshouding | datumAanvangVolgendeAdreshouding |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000002                 | Tweede straat | 20160526                 |                                  |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000001                 | Eerste straat | 20100818                 | 20160526                         |

      Voorbeelden:
      | omschrijving                                                 | datum van  |
      | datumVan is datum aanvang                                    | 2010-08-18 |
      | datumVan is dag na datum aanvang                             | 2010-08-19 |
      | datumVan ligt tussen datum aanvang en datum aanvang volgende | 2014-01-01 |
      | datumVan is dag voor datum aanvang volgende                  | 2016-05-25 |

    Abstract Scenario: verblijf wordt niet geleverd, omdat <omschrijving>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20100818                           |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20160526                           |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | <datum van>         |
      | datumTot            | 2020-01-01          |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | adresseerbaarObjectIdentificatie | straat        | datumAanvangAdreshouding |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000002                 | Tweede straat | 20160526                 |

      Voorbeelden:
      | omschrijving                            | datum van  |
      | datumVan ligt na datum aanvang volgende | 2016-06-01 |
      | datumVan is datum aanvang volgende      | 2016-05-26 |

    Abstract Scenario: verblijf wordt geleverd bij volgende is verblijf buitenland, omdat <omschrijving>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20100818                           |
      En de persoon is vervolgens ingeschreven op een buitenlands adres met de volgende gegevens
      | datum aanvang adres buitenland (13.20) | land adres buitenland (13.10) |
      | 20160526                               | 6014                          |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | <datum van>         |
      | datumTot            | 2020-01-01          |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | adresseerbaarObjectIdentificatie | straat        | land.code | land.omschrijving            | datumAanvangAdreshouding | datumAanvangAdresBuitenland | datumAanvangVolgendeAdreshouding | datumAanvangVolgendeAdresBuitenland |
      |                              |                                      |                                  |               | 6014      | Verenigde Staten van Amerika |                          | 20160526                    |                                  |                                     |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000001                 | Eerste straat |           |                              | 20100818                 |                             |                                  | 20160526                            |

      Voorbeelden:
      | omschrijving                                                 | datum van  |
      | datumVan ligt tussen datum aanvang en datum aanvang volgende | 2014-01-01 |
      | datumVan is dag voor datum aanvang volgende                  | 2016-05-25 |

    Abstract Scenario: verblijf wordt niet geleverd bij volgende is verblijf buitenland, omdat <omschrijving>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20100818                           |
      En de persoon is vervolgens ingeschreven op een buitenlands adres met de volgende gegevens
      | datum aanvang adres buitenland (13.20) | land adres buitenland (13.10) |
      | 20160526                               | 6014                          |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20211014                           |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | <datum van>         |
      | datumTot            | 2020-01-01          |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | land.code | land.omschrijving            | datumAanvangAdresBuitenland | datumAanvangVolgendeAdreshouding |
      | 6014      | Verenigde Staten van Amerika | 20160526                    | 20211014                         |

      Voorbeelden:
      | omschrijving                            | datum van  |
      | datumVan ligt na datum aanvang volgende | 2016-06-01 |
      | datumVan is datum aanvang volgende      | 2016-05-26 |

    Scenario: periode overlapt meerdere verblijfplaatsen
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20100818                           |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20160526                           |
      En de persoon is vervolgens ingeschreven op adres 'A3' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20181014                           |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2008-10-14          |
      | datumTot            | 2020-07-30          |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | adresseerbaarObjectIdentificatie | straat        | datumAanvangAdreshouding | datumAanvangVolgendeAdreshouding |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000003                 | Derde straat  | 20181014                 |                                  |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000002                 | Tweede straat | 20160526                 | 20181014                         |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000001                 | Eerste straat | 20100818                 | 20160526                         |

    Scenario: periode ligt geheel tussen datum aanvang en datum aanvang volgende
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20100818                           |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20160526                           |
      En de persoon is vervolgens ingeschreven op adres 'A3' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20181014                           |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2016-07-01          |
      | datumTot            | 2017-01-01          |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | adresseerbaarObjectIdentificatie | straat        | datumAanvangAdreshouding | datumAanvangVolgendeAdreshouding |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000002                 | Tweede straat | 20160526                 | 20181014                         |

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
      | jaar en maand zijn bekend | 20100500             | datumTot ligt voor voor begin onzekerheidsperiode     | 2010-03-01 |
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
      | jaar en maand zijn bekend | 20100500             | datumTot ligt voor voor begin onzekerheidsperiode     | 2010-03-01 |
      | alleen jaar is bekend     | 20100000             | datumTot is gelijk aan eerste dag onzekerheidsperiode | 2010-01-01 |
      | jaar en maand zijn bekend | 20100500             | datumTot is gelijk aan eerste dag onzekerheidsperiode | 2010-05-01 |

  Rule: Een verblijfplaats met onbekende aanvang volgende verblijf wordt niet geleverd wanneer de gevraagde periode begint op of na de eerste dag van de onzekerheidsperiode van het volgende verblijf
    # Dit is het geval wanneer de 1e dag van de onzekerheidsperiode volgende ≤ parameter datumVan
  
    Abstract Scenario: verblijf met aanvang adreshouding volgende verblijf <soort datum> wordt geleverd, omdat <omschrijving>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20080818                           |
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
      | datumVan            | <datum van>         |
      | datumTot            | 2012-07-30          |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | adresseerbaarObjectIdentificatie | straat        | datumAanvangAdreshouding | datumAanvangVolgendeAdreshouding |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000002                 | Tweede straat | <aanvang adreshouding>   | 20161014                         |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000001                 | Eerste straat | 20080818                 | <aanvang adreshouding>              |

      Voorbeelden:
      | soort datum               | aanvang adreshouding | omschrijving                                                       | datum van  |
      | alleen jaar is bekend     | 20100000             | datumVan ligt voor de onzekerheidsperiode volgende                 | 2009-11-30 |
      | jaar en maand zijn bekend | 20100500             | datumVan ligt voor de onzekerheidsperiode volgende                 | 2010-02-19 |
      | alleen jaar is bekend     | 20100000             | datumVan is gelijk aan de dag voor de onzekerheidsperiode volgende | 2009-12-31 |
      | jaar en maand zijn bekend | 20100500             | datumVan is gelijk aan de dag voor de onzekerheidsperiode volgende | 2010-04-30 |
      | jaar en maand zijn bekend | 20100100             | datumVan is gelijk aan de dag voor de onzekerheidsperiode volgende | 2009-12-31 |
      | jaar en maand zijn bekend | 20100300             | datumVan is gelijk aan de eerste dag voor de onzekerheidsperiode   | 2010-02-28 |
      | jaar en maand zijn bekend | 20120300             | datumVan is gelijk aan de eerste dag voor de onzekerheidsperiode   | 2012-02-29 |

    Abstract Scenario: verblijf met aanvang adreshouding volgende verblijf <soort datum> wordt niet geleverd, omdat <omschrijving>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20080818                           |
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
      | datumVan            | <datum van>         |
      | datumTot            | 2012-07-30          |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | adresseerbaarObjectIdentificatie | straat        | datumAanvangAdreshouding | datumAanvangVolgendeAdreshouding |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000002                 | Tweede straat | <aanvang adreshouding>   | 20161014                         |

      Voorbeelden:
      | soort datum               | aanvang adreshouding | omschrijving                                                    | datum van  |
      | volledig onbekend         | 00000000             | datumVan ligt in de onzekerheidsperiode                         | 2010-05-26 |
      | alleen jaar is bekend     | 20100000             | datumVan ligt in de onzekerheidsperiode                         | 2010-05-26 |
      | jaar en maand zijn bekend | 20100500             | datumVan ligt in de onzekerheidsperiode                         | 2010-05-26 |
      | alleen jaar is bekend     | 20100000             | datumVan is gelijk aan de eerste dag van de onzekerheidsperiode | 2010-01-01 |
      | jaar en maand zijn bekend | 20100500             | datumVan is gelijk aan de eerste dag van de onzekerheidsperiode | 2010-05-01 |
      | alleen jaar is bekend     | 20100000             | datumVan is laatste dag van de onzekerheidsperiode              | 2010-12-31 |
      | jaar en maand zijn bekend | 20100500             | datumVan is laatste dag van de onzekerheidsperiode              | 2010-05-31 |
      | jaar en maand zijn bekend | 20101200             | datumVan is laatste dag van de onzekerheidsperiode              | 2010-12-31 |
      | jaar en maand zijn bekend | 20120200             | datumVan is laatste dag van de onzekerheidsperiode              | 2012-02-29 |
      | jaar en maand zijn bekend | 20100200             | datumVan is laatste dag van de onzekerheidsperiode              | 2010-02-28 |
      | alleen jaar is bekend     | 20100000             | datumVan ligt na de onzekerheidsperiode                         | 2011-02-19 |
      | alleen jaar is bekend     | 20100000             | datumVan is gelijk aan de eerste dag na de onzekerheidsperiode  | 2011-01-01 |
      | jaar en maand zijn bekend | 20100500             | datumVan ligt na de onzekerheidsperiode                         | 2011-02-19 |
      | jaar en maand zijn bekend | 20100500             | datumVan is gelijk aan de eerste dag na de onzekerheidsperiode  | 2010-06-01 |

    Abstract Scenario: verblijf wordt geleverd bij volgende is verblijf buitenland met aanvang <soort datum>, omdat <omschrijving>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20080818                           |
      En de persoon is vervolgens ingeschreven op een buitenlands adres met de volgende gegevens
      | datum aanvang adres buitenland (13.20) | land adres buitenland (13.10) |
      | <aanvang adreshouding>                 | 6014                          |
      En de persoon is vervolgens ingeschreven op adres 'A3' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20161014                           |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | <datum van>         |
      | datumTot            | 2012-07-30          |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | adresseerbaarObjectIdentificatie | straat        | land.code | land.omschrijving            | datumAanvangAdreshouding | datumAanvangAdresBuitenland | datumAanvangVolgendeAdreshouding | datumAanvangVolgendeAdresBuitenland |
      |                              |                                      |                                  |               | 6014      | Verenigde Staten van Amerika |                          | <aanvang adreshouding>      | 20161014                         |                                     |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000001                 | Eerste straat |           |                              | 20080818                 |                             |                                  | <aanvang adreshouding>              |

      Voorbeelden:
      | soort datum               | aanvang adreshouding | omschrijving                                                       | datum van  |
      | alleen jaar is bekend     | 20100000             | datumVan ligt voor de onzekerheidsperiode volgende                 | 2009-11-30 |
      | jaar en maand zijn bekend | 20100500             | datumVan ligt voor de onzekerheidsperiode volgende                 | 2010-02-19 |
      | alleen jaar is bekend     | 20100000             | datumVan is gelijk aan de dag voor de onzekerheidsperiode volgende | 2009-12-31 |
      | jaar en maand zijn bekend | 20100500             | datumVan is gelijk aan de dag voor de onzekerheidsperiode volgende | 2010-04-30 |
      | jaar en maand zijn bekend | 20100100             | datumVan is gelijk aan de dag voor de onzekerheidsperiode volgende | 2009-12-31 |
      | jaar en maand zijn bekend | 20100300             | datumVan is gelijk aan de dag voor de onzekerheidsperiode          | 2010-02-28 |
      | jaar en maand zijn bekend | 20120300             | datumVan is gelijk aan de dag voor de onzekerheidsperiode          | 2012-02-29 |

    Abstract Scenario: verblijf wordt niet geleverd bij volgende is verblijf buitenland met aanvang <soort datum>, omdat <omschrijving>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20080818                           |
      En de persoon is vervolgens ingeschreven op een buitenlands adres met de volgende gegevens
      | datum aanvang adres buitenland (13.20) | land adres buitenland (13.10) |
      | <aanvang adreshouding>                 | 6014                          |
      En de persoon is vervolgens ingeschreven op adres 'A3' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20161014                           |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | <datum van>         |
      | datumTot            | 2012-07-30          |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | land.code | land.omschrijving            | datumAanvangAdresBuitenland | datumAanvangVolgendeAdreshouding |
      | 6014      | Verenigde Staten van Amerika | <aanvang adreshouding>      | 20161014                         |
      
      Voorbeelden:
      | soort datum               | aanvang adreshouding | omschrijving                                                             | datum van  |
      | volledig onbekend         | 00000000             | datumVan ligt in de onzekerheidsperiode volgende                         | 2010-05-26 |
      | alleen jaar is bekend     | 20100000             | datumVan ligt in de onzekerheidsperiode volgende                         | 2010-05-26 |
      | jaar en maand zijn bekend | 20100500             | datumVan ligt in de onzekerheidsperiode volgende                         | 2010-05-26 |
      | alleen jaar is bekend     | 20100000             | datumVan is gelijk aan de eerste dag van de onzekerheidsperiode volgende | 2010-01-01 |
      | jaar en maand zijn bekend | 20100500             | datumVan is gelijk aan de eerste dag van de onzekerheidsperiode volgende | 2010-05-01 |
      | alleen jaar is bekend     | 20100000             | datumVan is laatste dag van de onzekerheidsperiode volgende              | 2010-12-31 |
      | jaar en maand zijn bekend | 20100500             | datumVan is laatste dag van de onzekerheidsperiode volgende              | 2010-05-31 |
      | jaar en maand zijn bekend | 20101200             | datumVan is laatste dag van de onzekerheidsperiode volgende              | 2010-12-31 |
      | jaar en maand zijn bekend | 20120200             | datumVan is laatste dag van de onzekerheidsperiode volgende              | 2012-02-29 |
      | jaar en maand zijn bekend | 20100200             | datumVan is laatste dag van de onzekerheidsperiode volgende              | 2010-02-28 |
      | alleen jaar is bekend     | 20100000             | datumVan ligt na de onzekerheidsperiode volgende                         | 2011-02-19 |
      | alleen jaar is bekend     | 20100000             | datumVan is gelijk aan de eerste dag na de onzekerheidsperiode volgende  | 2011-01-01 |
      | jaar en maand zijn bekend | 20100500             | datumVan ligt na de onzekerheidsperiode volgende                         | 2011-02-19 |
      | jaar en maand zijn bekend | 20100500             | datumVan is gelijk aan de eerste dag na de onzekerheidsperiode volgende  | 2010-06-01 |

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
