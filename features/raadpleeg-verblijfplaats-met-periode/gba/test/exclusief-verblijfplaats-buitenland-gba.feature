#language: nl

@gba
Functionaliteit: test dat bij gebruik van parameter exclusiefVerblijfplaatsBuitenland alleen binnenlandse adressen worden geleverd voor gevraagde een periode
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
      En adres 'L1' heeft de volgende gegevens
      | gemeentecode (92.10) | locatiebeschrijving (12.10) |
      | 0800                 | De eerste locatie           |


  Rule: Een verblijfplaats buitenland van een persoon wordt niet geleverd als de optionele 'exclusiefVerblijfplaatsBuitenland' parameter wordt opgegeven

    Scenario: verblijfplaats buitenland niet geleverd bij exclusiefVerblijfplaatsBuitenland:true
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20100818                           |
      En de persoon is vervolgens ingeschreven op adres 'L1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20160526                           |
      En de persoon is vervolgens ingeschreven op een buitenlands adres met de volgende gegevens
      | datum aanvang adres buitenland (13.20) | land adres buitenland (13.10) |
      | 20181201                               | 6014                          |
      En de persoon is vervolgens ingeschreven op adres 'A4' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20200415                           |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                              | waarde              |
      | type                              | RaadpleegMetPeriode |
      | burgerservicenummer               | 000000012           |
      | datumVan                          | 2010-07-01          |
      | datumTot                          | 2020-07-01          |
      | exclusiefVerblijfplaatsBuitenland | true                |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | straat        | adresseerbaarObjectIdentificatie | locatiebeschrijving | datumAanvangAdreshouding | datumAanvangVolgendeAdreshouding | datumAanvangVolgendeAdresBuitenland | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving |
      | Vierde straat | 0800010000000004                 |                     | 20200415                 |                                  |                                     | 0800                         | Hoogeloon, Hapert en Casteren        |
      |               |                                  | De eerste locatie   | 20160526                 |                                  | 20181201                            | 0800                         | Hoogeloon, Hapert en Casteren        |
      | Eerste straat | 0800010000000001                 |                     | 20100818                 | 20160526                         |                                     | 0800                         | Hoogeloon, Hapert en Casteren        |

    Scenario: verblijfplaats buitenland niet geleverd bij exclusiefVerblijfplaatsBuitenland:true en periode tijdens verblijf buitenland
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20100818                           |
      En de persoon is vervolgens ingeschreven op adres 'L1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20160526                           |
      En de persoon is vervolgens ingeschreven op een buitenlands adres met de volgende gegevens
      | datum aanvang adres buitenland (13.20) | land adres buitenland (13.10) |
      | 20181201                               | 6014                          |
      En de persoon is vervolgens ingeschreven op adres 'A4' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20200415                           |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                              | waarde              |
      | type                              | RaadpleegMetPeriode |
      | burgerservicenummer               | 000000012           |
      | datumVan                          | 2019-01-01          |
      | datumTot                          | 2020-01-01          |
      | exclusiefVerblijfplaatsBuitenland | true                |
      Dan heeft de response 0 verblijfplaatsen

    Scenario: verblijfplaats buitenland wel geleverd bij exclusiefVerblijfplaatsBuitenland:false
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20100818                           |
      En de persoon is vervolgens ingeschreven op adres 'L1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20160526                           |
      En de persoon is vervolgens ingeschreven op een buitenlands adres met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adres buitenland (13.20) | land adres buitenland (13.10) |
      | 1999                              | 20181201                               | 6014                          |
      En de persoon is vervolgens ingeschreven op adres 'A4' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20200415                           |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                              | waarde              |
      | type                              | RaadpleegMetPeriode |
      | burgerservicenummer               | 000000012           |
      | datumVan                          | 2010-07-01          |
      | datumTot                          | 2020-07-01          |
      | exclusiefVerblijfplaatsBuitenland | false               |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | straat        | adresseerbaarObjectIdentificatie | locatiebeschrijving | land.code | land.omschrijving            | datumAanvangAdreshouding | datumAanvangAdresBuitenland | datumAanvangVolgendeAdreshouding | datumAanvangVolgendeAdresBuitenland | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving |
      | Vierde straat | 0800010000000004                 |                     |           |                              | 20200415                 |                             |                                  |                                     | 0800                         | Hoogeloon, Hapert en Casteren        |
      |               |                                  |                     | 6014      | Verenigde Staten van Amerika |                          | 20181201                    | 20200415                         |                                     | 1999                         | Registratie Niet Ingezetenen (RNI)   |
      |               |                                  | De eerste locatie   |           |                              | 20160526                 |                             |                                  | 20181201                            | 0800                         | Hoogeloon, Hapert en Casteren        |
      | Eerste straat | 0800010000000001                 |                     |           |                              | 20100818                 |                             | 20160526                         |                                     | 0800                         | Hoogeloon, Hapert en Casteren        |

    Scenario: verblijfplaats buitenland wel geleverd zonder parameter exclusiefVerblijfplaatsBuitenland (default is false)
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20100818                           |
      En de persoon is vervolgens ingeschreven op adres 'L1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20160526                           |
      En de persoon is vervolgens ingeschreven op een buitenlands adres met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adres buitenland (13.20) | land adres buitenland (13.10) |
      | 1999                              | 20181201                               | 6014                          |
      En de persoon is vervolgens ingeschreven op adres 'A4' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20200415                           |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                              | waarde              |
      | type                              | RaadpleegMetPeriode |
      | burgerservicenummer               | 000000012           |
      | datumVan                          | 2010-07-01          |
      | datumTot                          | 2020-07-01          |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | straat        | adresseerbaarObjectIdentificatie | locatiebeschrijving | land.code | land.omschrijving            | datumAanvangAdreshouding | datumAanvangAdresBuitenland | datumAanvangVolgendeAdreshouding | datumAanvangVolgendeAdresBuitenland | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving |
      | Vierde straat | 0800010000000004                 |                     |           |                              | 20200415                 |                             |                                  |                                     | 0800                         | Hoogeloon, Hapert en Casteren        |
      |               |                                  |                     | 6014      | Verenigde Staten van Amerika |                          | 20181201                    | 20200415                         |                                     | 1999                         | Registratie Niet Ingezetenen (RNI)   |
      |               |                                  | De eerste locatie   |           |                              | 20160526                 |                             |                                  | 20181201                            | 0800                         | Hoogeloon, Hapert en Casteren        |
      | Eerste straat | 0800010000000001                 |                     |           |                              | 20100818                 |                             | 20160526                         |                                     | 0800                         | Hoogeloon, Hapert en Casteren        |

    Scenario: volledig onbekende verblijfplaats (VOW) niet geleverd bij exclusiefVerblijfplaatsBuitenland:true
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20100818                           |
      En de persoon is vervolgens ingeschreven op adres 'L1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20160526                           |
      En de persoon is vervolgens ingeschreven op een buitenlands adres met de volgende gegevens
      | datum aanvang adres buitenland (13.20) | land adres buitenland (13.10) |
      | 20181201                               | 0000                          |
      En de persoon is vervolgens ingeschreven op adres 'A4' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20200415                           |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                              | waarde              |
      | type                              | RaadpleegMetPeriode |
      | burgerservicenummer               | 000000012           |
      | datumVan                          | 2010-07-01          |
      | datumTot                          | 2020-07-01          |
      | exclusiefVerblijfplaatsBuitenland | true                |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | straat        | adresseerbaarObjectIdentificatie | locatiebeschrijving | datumAanvangAdreshouding | datumAanvangVolgendeAdreshouding | datumAanvangVolgendeAdresBuitenland | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving |
      | Vierde straat | 0800010000000004                 |                     | 20200415                 |                                  |                                     | 0800                         | Hoogeloon, Hapert en Casteren        |
      |               |                                  | De eerste locatie   | 20160526                 |                                  | 20181201                            | 0800                         | Hoogeloon, Hapert en Casteren        |
      | Eerste straat | 0800010000000001                 |                     | 20100818                 | 20160526                         |                                     | 0800                         | Hoogeloon, Hapert en Casteren        |

    Scenario: meerdere verblijfplaatsen buitenland niet geleverd bij exclusiefVerblijfplaatsBuitenland:true
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20100818                           |
      En de persoon is vervolgens ingeschreven op een buitenlands adres met de volgende gegevens
      | datum aanvang adres buitenland (13.20) | land adres buitenland (13.10) |
      | 20181201                               | 6014                          |
      En de persoon is vervolgens ingeschreven op een buitenlands adres met de volgende gegevens
      | datum aanvang adres buitenland (13.20) | land adres buitenland (13.10) |
      | 20190219                               | 5003                          |
      En de persoon is vervolgens ingeschreven op adres 'A4' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20200415                           |
      En de persoon is vervolgens ingeschreven op een buitenlands adres met de volgende gegevens
      | datum aanvang adres buitenland (13.20) | land adres buitenland (13.10) |
      | 20211014                               | 5003                          |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                              | waarde              |
      | type                              | RaadpleegMetPeriode |
      | burgerservicenummer               | 000000012           |
      | datumVan                          | 2010-07-01          |
      | datumTot                          | 2020-07-01          |
      | exclusiefVerblijfplaatsBuitenland | true                |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | straat        | adresseerbaarObjectIdentificatie | locatiebeschrijving | datumAanvangAdreshouding | datumAanvangVolgendeAdreshouding | datumAanvangVolgendeAdresBuitenland | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving |
      | Vierde straat | 0800010000000004                 |                     | 20200415                 |                                  | 20211014                            | 0800                         | Hoogeloon, Hapert en Casteren        |
      | Eerste straat | 0800010000000001                 |                     | 20100818                 |                                  | 20181201                            | 0800                         | Hoogeloon, Hapert en Casteren        |

    Scenario: geen verblijfplaatsen geleverd wanneer periode tijdens verblijf buitenland met exclusiefVerblijfplaatsBuitenland:true
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20100818                           |
      En de persoon is vervolgens ingeschreven op een buitenlands adres met de volgende gegevens
      | datum aanvang adres buitenland (13.20) | land adres buitenland (13.10) |
      | 20181201                               | 6014                          |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                              | waarde              |
      | type                              | RaadpleegMetPeriode |
      | burgerservicenummer               | 000000012           |
      | datumVan                          | 2020-01-01          |
      | datumTot                          | 2020-07-01          |
      | exclusiefVerblijfplaatsBuitenland | true                |
      Dan heeft de response 0 verblijfplaatsen

    Scenario: vorige is verblijf buitenland in onzekerheidsperiode met exclusiefVerblijfplaatsBuitenland:true
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20100818                           |
      En de persoon is vervolgens ingeschreven op een buitenlands adres met de volgende gegevens
      | datum aanvang adres buitenland (13.20) | land adres buitenland (13.10) |
      | 20181201                               | 6014                          |
      En de persoon is vervolgens ingeschreven op adres 'A4' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20180000                           |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                              | waarde              |
      | type                              | RaadpleegMetPeriode |
      | burgerservicenummer               | 000000012           |
      | datumVan                          | 2018-01-01          |
      | datumTot                          | 2018-07-01          |
      | exclusiefVerblijfplaatsBuitenland | true                |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | straat        | adresseerbaarObjectIdentificatie | locatiebeschrijving | datumAanvangAdreshouding | datumAanvangVolgendeAdreshouding | datumAanvangVolgendeAdresBuitenland | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving |
      | Eerste straat | 0800010000000001                 |                     | 20100818                 |                                  | 20181201                            | 0800                         | Hoogeloon, Hapert en Casteren        |

    Scenario: volgende is verblijf buitenland met onbekende datum aanvang met exclusiefVerblijfplaatsBuitenland:true
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20100818                           |
      En de persoon is vervolgens ingeschreven op een buitenlands adres met de volgende gegevens
      | datum aanvang adres buitenland (13.20) | land adres buitenland (13.10) |
      | 20180000                               | 6014                          |
      En de persoon is vervolgens ingeschreven op adres 'A4' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20201014                           |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                              | waarde              |
      | type                              | RaadpleegMetPeriode |
      | burgerservicenummer               | 000000012           |
      | datumVan                          | 2018-01-01          |
      | datumTot                          | 2018-07-01          |
      | exclusiefVerblijfplaatsBuitenland | true                |
      Dan heeft de response 0 verblijfplaatsen    

    Scenario: verblijfplaats buitenland met onderzoek en rni niet geleverd bij exclusiefVerblijfplaatsBuitenland:true
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20100818                           |
      En de persoon is vervolgens ingeschreven op een buitenlands adres met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adres buitenland (13.20) | land adres buitenland (13.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | rni-deelnemer (88.10) | omschrijving verdrag (88.20)         |
      | 1999                              | 20181201                               | 6014                          | 580000                          | 20190526                       | 0201                  | Artikel 45 EU-Werkingsverdrag (VWEU) |
      En de persoon is vervolgens ingeschreven op adres 'A3' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20200415                           |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                              | waarde              |
      | type                              | RaadpleegMetPeriode |
      | burgerservicenummer               | 000000012           |
      | datumVan                          | 2010-07-01          |
      | datumTot                          | 2020-07-01          |
      | exclusiefVerblijfplaatsBuitenland | true                |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | straat        | adresseerbaarObjectIdentificatie | locatiebeschrijving | datumAanvangAdreshouding | datumAanvangVolgendeAdreshouding | datumAanvangVolgendeAdresBuitenland | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving |
      | Derde straat  | 0800010000000003                 |                     | 20200415                 |                                  |                                     | 0800                         | Hoogeloon, Hapert en Casteren        |
      | Eerste straat | 0800010000000001                 |                     | 20100818                 |                                  | 20181201                            | 0800                         | Hoogeloon, Hapert en Casteren        |
