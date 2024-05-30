#language: nl

@gba
Functionaliteit: test dat alleen de verblijfplaats(en) waar persoon verbleef op peildatum wordt geleverd

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


  Rule: Een verblijfplaats wordt niet geleverd, wanneer de gevraagde peildatum ligt voor het betreffende verblijf
    # Dit is het geval wanneer de (bekende) aanvang adreshouding > parameter peildatum

    Abstract Scenario: verblijf wordt niet geleverd, omdat <omschrijving>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20100818                           |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20160526                           |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 000000012             |
      | peildatum           | <peildatum>           |
      Dan heeft de response 0 verblijfplaatsen

      Voorbeelden:
      | omschrijving                                     | peildatum  |
      | peildatum ligt voor datum aanvang adreshouding   | 2010-01-01 |
      | peildatum is dag voor datum aanvang adreshouding | 2010-08-17 |

    Abstract Scenario: verblijf wordt geleverd, omdat <omschrijving>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20100818                           |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 000000012             |
      | peildatum           | <peildatum>           |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | adresseerbaarObjectIdentificatie | straat        | datumAanvangAdreshouding |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000001                 | Eerste straat | 20100818                 |

      Voorbeelden:
      | omschrijving                    | peildatum  |
      | peildatum is datum aanvang      | 2010-08-18 |
      | peildatum ligt na datum aanvang | 2014-01-01 |

    Abstract Scenario: tweede verblijf wordt niet geleverd, omdat <omschrijving>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20100818                           |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20160526                           |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 000000012             |
      | peildatum           | <peildatum>           |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | adresseerbaarObjectIdentificatie | straat        | datumAanvangAdreshouding | datumAanvangVolgendeAdreshouding |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000001                 | Eerste straat | 20100818                 | 20160526                         |

      Voorbeelden:
      | omschrijving                        | peildatum  |
      | peildatum ligt voor datum aanvang   | 2014-01-01 |
      | peildatum is dag voor datum aanvang | 2016-05-25 |

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
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 000000012             |
      | peildatum           | <peildatum>           |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | land.code | land.omschrijving            | datumAanvangAdresBuitenland | datumAanvangVolgendeAdreshouding |
      | 6014      | Verenigde Staten van Amerika | 20100818                    | 20160526                         |

      Voorbeelden:
      | omschrijving                                                  | peildatum  |
      | peildatum is datum aanvang                                    | 2010-08-18 |
      | peildatum ligt tussen datum aanvang en datum aanvang volgende | 2014-01-01 |

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
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 000000012             |
      | peildatum           | <peildatum>           |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | adresseerbaarObjectIdentificatie | straat        | datumAanvangAdreshouding | datumAanvangVolgendeAdresBuitenland |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000001                 | Eerste straat | 20041014                 | 20100818                            |

      Voorbeelden:
      | omschrijving                                                | peildatum  |
      | peildatum ligt voor datum aanvang en datum aanvang volgende | 2010-05-26 |
      | peildatum is dag voor datum aanvang                         | 2010-08-17 |

  Rule: Een verblijfplaats wordt niet geleverd, wanneer de gevraagde peildatum ligt na vertrek uit betreffende verblijf
    # Dit is het geval wanneer de (bekende) aanvang volgende adreshouding ≤ parameter peildatum

    Scenario: verblijf wordt geleverd, omdat er geen volgende verblijf is
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20100818                           |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 000000012             |
      | peildatum           | 2020-01-01            |
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
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 000000012             |
      | peildatum           | <peildatum>           |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | adresseerbaarObjectIdentificatie | straat        | datumAanvangAdreshouding | datumAanvangVolgendeAdreshouding |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000001                 | Eerste straat | 20100818                 | 20160526                         |

      Voorbeelden:
      | omschrijving                                                  | peildatum  |
      | peildatum is datum aanvang                                    | 2010-08-18 |
      | peildatum is dag na datum aanvang                             | 2010-08-19 |
      | peildatum ligt tussen datum aanvang en datum aanvang volgende | 2014-01-01 |
      | peildatum is dag voor datum aanvang volgende                  | 2016-05-25 |

    Abstract Scenario: verblijf wordt niet geleverd, omdat <omschrijving>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20100818                           |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20160526                           |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 000000012             |
      | peildatum           | <peildatum>           |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | adresseerbaarObjectIdentificatie | straat        | datumAanvangAdreshouding |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000002                 | Tweede straat | 20160526                 |

      Voorbeelden:
      | omschrijving                             | peildatum  |
      | peildatum ligt na datum aanvang volgende | 2016-06-01 |
      | peildatum is datum aanvang volgende      | 2016-05-26 |

    Abstract Scenario: verblijf wordt geleverd bij volgende is verblijf buitenland, omdat <omschrijving>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20100818                           |
      En de persoon is vervolgens ingeschreven op een buitenlands adres met de volgende gegevens
      | datum aanvang adres buitenland (13.20) | land adres buitenland (13.10) |
      | 20160526                               | 6014                          |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 000000012             |
      | peildatum           | <peildatum>           |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | adresseerbaarObjectIdentificatie | straat        | datumAanvangAdreshouding | datumAanvangVolgendeAdresBuitenland |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000001                 | Eerste straat | 20100818                 | 20160526                            |

      Voorbeelden:
      | omschrijving                                                  | peildatum  |
      | peildatum ligt tussen datum aanvang en datum aanvang volgende | 2014-01-01 |
      | peildatum is dag voor datum aanvang volgende                  | 2016-05-25 |

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
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 000000012             |
      | peildatum           | <peildatum>           |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | land.code | land.omschrijving            | datumAanvangAdresBuitenland | datumAanvangVolgendeAdreshouding |
      | 6014      | Verenigde Staten van Amerika | 20160526                    | 20211014                         |

      Voorbeelden:
      | omschrijving                             | peildatum  |
      | peildatum ligt na datum aanvang volgende | 2016-06-01 |
      | peildatum is datum aanvang volgende      | 2016-05-26 |

  Rule: De verblijfplaats wordt niet geleverd wanneer gevraagde peildatum ligt voor de 1e dag van de onzekerheidsperiode van de aanvang
    # Dit is het geval wanneer de 1e dag van de onzekerheidsperiode > parameter peildatum

    Abstract Scenario: verblijf met aanvang adreshouding <soort datum> wordt geleverd, omdat <omschrijving>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20080818                           |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <aanvang adreshouding>             |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 000000012             |
      | peildatum           | <peildatum>           |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | adresseerbaarObjectIdentificatie | straat        | datumAanvangAdreshouding | datumAanvangVolgendeAdreshouding |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000002                 | Tweede straat | <aanvang adreshouding>   |                                  |

      Voorbeelden:
      | soort datum               | aanvang adreshouding | omschrijving                                   | peildatum  |
      | volledig onbekend         | 00000000             | peildatum ligt in onzekerheidsperiode          | 2010-05-26 |
      | alleen jaar is bekend     | 20100000             | peildatum ligt in onzekerheidsperiode          | 2010-05-26 |
      | alleen jaar is bekend     | 20100000             | peildatum is eerste dag onzekerheidsperiode    | 2010-01-01 |
      | alleen jaar is bekend     | 20100000             | peildatum is eerste dag na onzekerheidsperiode | 2011-01-01 |
      | alleen jaar is bekend     | 20100000             | peildatum ligt na onzekerheidsperiode          | 2011-07-30 |
      | jaar en maand zijn bekend | 20100500             | peildatum ligt in onzekerheidsperiode          | 2010-05-26 |
      | jaar en maand zijn bekend | 20100500             | peildatum is eerste dag onzekerheidsperiode    | 2010-05-01 |
      | jaar en maand zijn bekend | 20100500             | peildatum is eerste dag na onzekerheidsperiode | 2010-06-01 |
      | jaar en maand zijn bekend | 20100500             | peildatum ligt na onzekerheidsperiode          | 2010-07-30 |

    Abstract Scenario: verblijf met aanvang adreshouding <soort datum> wordt niet geleverd, omdat <omschrijving>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20080818                           |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <aanvang adreshouding>             |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 000000012             |
      | peildatum           | <peildatum>           |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | adresseerbaarObjectIdentificatie | straat        | datumAanvangAdreshouding | datumAanvangVolgendeAdreshouding |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000001                 | Eerste straat | 20080818                 | <aanvang adreshouding>           |

      Voorbeelden:
      | soort datum               | aanvang adreshouding | omschrijving                                         | peildatum  |
      | alleen jaar is bekend     | 20100000             | peildatum ligt voor begin onzekerheidsperiode        | 2009-07-01 |
      | jaar en maand zijn bekend | 20100500             | peildatum ligt voor voor begin onzekerheidsperiode   | 2010-03-01 |
      | alleen jaar is bekend     | 20100000             | peildatum is dag voor eerste dag onzekerheidsperiode | 2009-12-31 |
      | jaar en maand zijn bekend | 20100500             | peildatum is dag voor eerste dag onzekerheidsperiode | 2010-04-30 |
      | jaar en maand zijn bekend | 20120300             | peildatum is dag voor eerste dag onzekerheidsperiode | 2012-02-29 |

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
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 000000012             |
      | peildatum           | <peildatum>           |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | land.code | land.omschrijving            | datumAanvangAdresBuitenland | datumAanvangVolgendeAdreshouding |
      | 6014      | Verenigde Staten van Amerika | <aanvang adreshouding>      | 20160526                         |

      Voorbeelden:
      | soort datum               | aanvang adreshouding | omschrijving                                   | peildatum  |
      | volledig onbekend         | 00000000             | peildatum ligt in onzekerheidsperiode          | 2010-05-26 |
      | alleen jaar is bekend     | 20100000             | peildatum ligt in onzekerheidsperiode          | 2010-05-26 |
      | alleen jaar is bekend     | 20100000             | peildatum is eerste dag onzekerheidsperiode    | 2010-01-01 |
      | alleen jaar is bekend     | 20100000             | peildatum is eerste dag na onzekerheidsperiode | 2011-01-01 |
      | alleen jaar is bekend     | 20100000             | peildatum ligt na onzekerheidsperiode          | 2011-07-30 |
      | jaar en maand zijn bekend | 20100500             | peildatum ligt in onzekerheidsperiode          | 2010-05-26 |
      | jaar en maand zijn bekend | 20100500             | peildatum is eerste dag onzekerheidsperiode    | 2010-05-01 |
      | jaar en maand zijn bekend | 20100500             | peildatum is eerste dag na onzekerheidsperiode | 2010-06-01 |
      | jaar en maand zijn bekend | 20100500             | peildatum ligt na onzekerheidsperiode          | 2010-07-30 |

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
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 000000012             |
      | peildatum           | <peildatum>           |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | adresseerbaarObjectIdentificatie | straat        | datumAanvangAdreshouding | datumAanvangVolgendeAdresBuitenland |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000001                 | Eerste straat | 20080818                 | <aanvang adreshouding>              |

      Voorbeelden:
      | soort datum               | aanvang adreshouding | omschrijving                                         | peildatum  |
      | alleen jaar is bekend     | 20100000             | peildatum ligt voor begin onzekerheidsperiode        | 2009-07-01 |
      | jaar en maand zijn bekend | 20100500             | peildatum ligt voor voor begin onzekerheidsperiode   | 2010-03-01 |
      | alleen jaar is bekend     | 20100000             | peildatum is dag voor eerste dag onzekerheidsperiode | 2009-12-31 |
      | jaar en maand zijn bekend | 20100500             | peildatum is dag voor eerste dag onzekerheidsperiode | 2010-04-30 |

  Rule: Een verblijfplaats met onbekende aanvang volgende verblijf wordt niet geleverd wanneer de gevraagde periode begint op of na de eerste dag van de onzekerheidsperiode van het volgende verblijf
    # Dit is het geval wanneer de 1e dag van de onzekerheidsperiode volgende ≤ parameter peildatum
  
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
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 000000012             |
      | peildatum           | <peildatum>           |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | adresseerbaarObjectIdentificatie | straat        | datumAanvangAdreshouding | datumAanvangVolgendeAdreshouding |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000001                 | Eerste straat | 20080818                 | <aanvang adreshouding>              |

      Voorbeelden:
      | soort datum               | aanvang adreshouding | omschrijving                                                        | peildatum  |
      | alleen jaar is bekend     | 20100000             | peildatum ligt voor de onzekerheidsperiode volgende                 | 2009-11-30 |
      | jaar en maand zijn bekend | 20100500             | peildatum ligt voor de onzekerheidsperiode volgende                 | 2010-02-19 |
      | alleen jaar is bekend     | 20100000             | peildatum is gelijk aan de dag voor de onzekerheidsperiode volgende | 2009-12-31 |
      | jaar en maand zijn bekend | 20100500             | peildatum is gelijk aan de dag voor de onzekerheidsperiode volgende | 2010-04-30 |
      | jaar en maand zijn bekend | 20100100             | peildatum is gelijk aan de dag voor de onzekerheidsperiode volgende | 2009-12-31 |
      | jaar en maand zijn bekend | 20100300             | peildatum is gelijk aan de eerste dag voor de onzekerheidsperiode   | 2010-02-28 |
      | jaar en maand zijn bekend | 20120300             | peildatum is gelijk aan de eerste dag voor de onzekerheidsperiode   | 2012-02-29 |

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
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 000000012             |
      | peildatum           | <peildatum>           |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | adresseerbaarObjectIdentificatie | straat        | datumAanvangAdreshouding | datumAanvangVolgendeAdreshouding |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000002                 | Tweede straat | <aanvang adreshouding>   | 20161014                         |

      Voorbeelden:
      | soort datum               | aanvang adreshouding | omschrijving                                                     | peildatum  |
      | volledig onbekend         | 00000000             | peildatum ligt in de onzekerheidsperiode                         | 2010-05-26 |
      | alleen jaar is bekend     | 20100000             | peildatum ligt in de onzekerheidsperiode                         | 2010-05-26 |
      | jaar en maand zijn bekend | 20100500             | peildatum ligt in de onzekerheidsperiode                         | 2010-05-26 |
      | alleen jaar is bekend     | 20100000             | peildatum is gelijk aan de eerste dag van de onzekerheidsperiode | 2010-01-01 |
      | jaar en maand zijn bekend | 20100500             | peildatum is gelijk aan de eerste dag van de onzekerheidsperiode | 2010-05-01 |
      | alleen jaar is bekend     | 20100000             | peildatum is laatste dag van de onzekerheidsperiode              | 2010-12-31 |
      | jaar en maand zijn bekend | 20100500             | peildatum is laatste dag van de onzekerheidsperiode              | 2010-05-31 |
      | jaar en maand zijn bekend | 20101200             | peildatum is laatste dag van de onzekerheidsperiode              | 2010-12-31 |
      | jaar en maand zijn bekend | 20120200             | peildatum is laatste dag van de onzekerheidsperiode              | 2012-02-29 |
      | jaar en maand zijn bekend | 20100200             | peildatum is laatste dag van de onzekerheidsperiode              | 2010-02-28 |
      | alleen jaar is bekend     | 20100000             | peildatum ligt na de onzekerheidsperiode                         | 2011-02-19 |
      | alleen jaar is bekend     | 20100000             | peildatum is gelijk aan de eerste dag na de onzekerheidsperiode  | 2011-01-01 |
      | jaar en maand zijn bekend | 20100500             | peildatum ligt na de onzekerheidsperiode                         | 2011-02-19 |
      | jaar en maand zijn bekend | 20100500             | peildatum is gelijk aan de eerste dag na de onzekerheidsperiode  | 2010-06-01 |

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
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 000000012             |
      | peildatum           | <peildatum>           |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | adresseerbaarObjectIdentificatie | straat        | datumAanvangAdreshouding | datumAanvangVolgendeAdresBuitenland |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000001                 | Eerste straat | 20080818                 | <aanvang adreshouding>              |

      Voorbeelden:
      | soort datum               | aanvang adreshouding | omschrijving                                                        | peildatum  |
      | alleen jaar is bekend     | 20100000             | peildatum ligt voor de onzekerheidsperiode volgende                 | 2009-11-30 |
      | jaar en maand zijn bekend | 20100500             | peildatum ligt voor de onzekerheidsperiode volgende                 | 2010-02-19 |
      | alleen jaar is bekend     | 20100000             | peildatum is gelijk aan de dag voor de onzekerheidsperiode volgende | 2009-12-31 |
      | jaar en maand zijn bekend | 20100500             | peildatum is gelijk aan de dag voor de onzekerheidsperiode volgende | 2010-04-30 |
      | jaar en maand zijn bekend | 20100100             | peildatum is gelijk aan de dag voor de onzekerheidsperiode volgende | 2009-12-31 |
      | jaar en maand zijn bekend | 20100300             | peildatum is gelijk aan de dag voor de onzekerheidsperiode          | 2010-02-28 |
      | jaar en maand zijn bekend | 20120300             | peildatum is gelijk aan de dag voor de onzekerheidsperiode          | 2012-02-29 |

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
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 000000012             |
      | peildatum           | <peildatum>           |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | land.code | land.omschrijving            | datumAanvangAdresBuitenland | datumAanvangVolgendeAdreshouding |
      | 6014      | Verenigde Staten van Amerika | <aanvang adreshouding>      | 20161014                         |
      
      Voorbeelden:
      | soort datum               | aanvang adreshouding | omschrijving                                                              | peildatum  |
      | volledig onbekend         | 00000000             | peildatum ligt in de onzekerheidsperiode volgende                         | 2010-05-26 |
      | alleen jaar is bekend     | 20100000             | peildatum ligt in de onzekerheidsperiode volgende                         | 2010-05-26 |
      | jaar en maand zijn bekend | 20100500             | peildatum ligt in de onzekerheidsperiode volgende                         | 2010-05-26 |
      | alleen jaar is bekend     | 20100000             | peildatum is gelijk aan de eerste dag van de onzekerheidsperiode volgende | 2010-01-01 |
      | jaar en maand zijn bekend | 20100500             | peildatum is gelijk aan de eerste dag van de onzekerheidsperiode volgende | 2010-05-01 |
      | alleen jaar is bekend     | 20100000             | peildatum is laatste dag van de onzekerheidsperiode volgende              | 2010-12-31 |
      | jaar en maand zijn bekend | 20100500             | peildatum is laatste dag van de onzekerheidsperiode volgende              | 2010-05-31 |
      | jaar en maand zijn bekend | 20101200             | peildatum is laatste dag van de onzekerheidsperiode volgende              | 2010-12-31 |
      | jaar en maand zijn bekend | 20120200             | peildatum is laatste dag van de onzekerheidsperiode volgende              | 2012-02-29 |
      | jaar en maand zijn bekend | 20100200             | peildatum is laatste dag van de onzekerheidsperiode volgende              | 2010-02-28 |
      | alleen jaar is bekend     | 20100000             | peildatum ligt na de onzekerheidsperiode volgende                         | 2011-02-19 |
      | alleen jaar is bekend     | 20100000             | peildatum is gelijk aan de eerste dag na de onzekerheidsperiode volgende  | 2011-01-01 |
      | jaar en maand zijn bekend | 20100500             | peildatum ligt na de onzekerheidsperiode volgende                         | 2011-02-19 |
      | jaar en maand zijn bekend | 20100500             | peildatum is gelijk aan de eerste dag na de onzekerheidsperiode volgende  | 2010-06-01 |

  Rule: Een verblijfplaats met onbekende aanvang van het verblijf en (bekende) aanvang vorige verblijf binnen de onzekerheidsperiode wordt niet geleverd wanneer de gevraagde peildatum ligt op of voor de aanvang vorige verblijf
    # Dit is het geval wanneer de dag na aanvang vorige ≥ parameter peildatum

    Abstract Scenario: verblijf met aanvang adreshouding <soort datum> wordt geleverd, omdat er geen vorige verblijfplaats is
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <aanvang adreshouding>             |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 000000012             |
      | peildatum           | 2010-05-26            |
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
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 000000012             |
      | peildatum           | 2010-05-26            |
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
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 000000012             |
      | peildatum           | <peildatum>           |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | adresseerbaarObjectIdentificatie | straat        | datumAanvangAdreshouding | datumAanvangVolgendeAdreshouding |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000002                 | Tweede straat | <aanvang adreshouding>   | 20161014                         |
      
      Voorbeelden:
      | soort datum               | aanvang adreshouding | omschrijving                                               | peildatum  |
      | volledig onbekend         | 00000000             | peildatum ligt in onzekerheidsperiode en na aanvang vorige | 2012-01-01 |
      | alleen jaar is bekend     | 20100000             | peildatum ligt in onzekerheidsperiode en na aanvang vorige | 2010-08-01 |
      | jaar en maand zijn bekend | 20100500             | peildatum ligt in onzekerheidsperiode en na aanvang vorige | 2010-05-29 |
      | alleen jaar is bekend     | 20100000             | peildatum is dag na aanvang vorige                         | 2010-05-27 |
      | jaar en maand zijn bekend | 20100500             | peildatum is dag na aanvang vorige                         | 2010-05-27 |
      | alleen jaar is bekend     | 20100000             | peildatum ligt na onzekerheidsperiode                      | 2011-03-14 |
      | jaar en maand zijn bekend | 20100500             | peildatum ligt na onzekerheidsperiode                      | 2010-07-01 |

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
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 000000012             |
      | peildatum           | <peildatum>           |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | adresseerbaarObjectIdentificatie | straat        | datumAanvangAdreshouding | datumAanvangVolgendeAdreshouding |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000002                 | Tweede straat | 20100526                 | <aanvang adreshouding>           |

      Voorbeelden:
      | soort datum               | aanvang adreshouding | omschrijving                                                 | peildatum  |
      | volledig onbekend         | 00000000             | peildatum is gelijk aan aanvang vorige                       | 2010-05-26 |
      | alleen jaar is bekend     | 20100000             | peildatum is gelijk aan aanvang vorige                       | 2010-05-26 |
      | jaar en maand zijn bekend | 20100500             | peildatum is gelijk aan aanvang vorige                       | 2010-05-26 |

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
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 000000012             |
      | peildatum           | <peildatum>           |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | adresseerbaarObjectIdentificatie | straat        | datumAanvangAdreshouding | datumAanvangVolgendeAdreshouding |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000001                 | Eerste straat | 20071014                 | 20100526                         |

      Voorbeelden:
      | soort datum               | aanvang adreshouding | omschrijving                                                 | peildatum  |
      | volledig onbekend         | 00000000             | peildatum ligt in onzekerheidsperiode en voor aanvang vorige | 2010-01-01 |
      | alleen jaar is bekend     | 20100000             | peildatum ligt in onzekerheidsperiode en voor aanvang vorige | 2010-04-01 |
      | jaar en maand zijn bekend | 20100500             | peildatum ligt in onzekerheidsperiode en voor aanvang vorige | 2010-05-10 |

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
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 000000012             |
      | peildatum           | <peildatum>           |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | adresseerbaarObjectIdentificatie | straat        | datumAanvangAdreshouding | datumAanvangVolgendeAdreshouding | datumAanvangVolgendeAdresBuitenland |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000002                 | Tweede straat | 20100526                 |                                  | <aanvang adreshouding>              |

      Voorbeelden:
      | soort datum               | aanvang adreshouding | omschrijving                                             | peildatum  |
      | volledig onbekend         | 00000000             | peildatum is datum aanvang vorige                        | 2010-05-26 |
      | alleen jaar is bekend     | 20100000             | peildatum is datum aanvang vorige                        | 2010-05-26 |
      | jaar en maand zijn bekend | 20100500             | peildatum is datum aanvang vorige                        | 2010-05-26 |

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
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 000000012             |
      | peildatum           | <peildatum>           |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | land.code | land.omschrijving            | datumAanvangAdresBuitenland | datumAanvangVolgendeAdreshouding |
      | 6014      | Verenigde Staten van Amerika | 20100526                    | <aanvang adreshouding>           |

      Voorbeelden:
      | soort datum               | aanvang adreshouding | omschrijving                                                 | peildatum  |
      | volledig onbekend         | 00000000             | peildatum is de dag na aanvang vorige                        | 2010-05-26 |
      | alleen jaar is bekend     | 20100000             | peildatum is de dag na aanvang vorige                        | 2010-05-26 |
      | jaar en maand zijn bekend | 20100500             | peildatum is de dag na aanvang vorige                        | 2010-05-26 |
