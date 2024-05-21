#language: nl

@gba
Functionaliteit: alleen verblijfplaatsen die binnen de gevraagde periode vallen worden geleverd

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
      | omschrijving                         | datum tot  |
      | datumTot ligt voor datum aanvang     | 2010-05-26 |
      | datumTot is gelijk aan datum aanvang | 2010-08-18 |

  Rule: Een verblijfplaats wordt niet geleverd, wanneer de gevraagde periode begint na vertrek uit betreffende verblijf
    # Dit is het geval wanneer de (bekende) aanvang volgende adreshouding ≤ parameter datumVan

    Scenario: actuele verblijf wordt geleverd, omdat er geen volgende verblijf is
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

    Abstract Scenario: historische verblijf wordt geleverd, omdat <omschrijving>
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
      | datumVan ligt voor datum aanvang                             | 2010-08-01 |
      | datumVan is datum aanvang                                    | 2010-08-18 |
      | datumVan is dag na datum aanvang                             | 2010-08-19 |
      | datumVan ligt tussen datum aanvang en datum aanvang volgende | 2014-01-01 |
      | datumVan is dag voor datum aanvang volgende                  | 2016-05-25 |

    Abstract Scenario: historische verblijf wordt niet geleverd, omdat <omschrijving>
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

    Abstract Scenario: historische verblijf wordt geleverd bij volgende is verblijf buitenland, omdat <omschrijving>
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
