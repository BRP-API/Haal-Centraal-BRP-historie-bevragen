#language: nl

@gba
Functionaliteit: test dat bij gebruik van parameter exclusiefVerblijfplaatsBuitenland alleen binnenlandse adressen worden geleverd op peildatum
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

    Abstract Scenario: verblijfplaats buitenland niet geleverd bij exclusiefVerblijfplaatsBuitenland:true
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
      | naam                              | waarde                |
      | type                              | RaadpleegMetPeildatum |
      | burgerservicenummer               | 000000012             |
      | peildatum                         | <peildatum>           |
      | exclusiefVerblijfplaatsBuitenland | true                  |
      Dan heeft de response 0 verblijfplaatsen

      Voorbeelden:
      | omschrijving                    | peildatum  |
      | eerste dag verblijf buitenland  | 2018-12-01 |
      | tijdens verblijf buitenland     | 2019-07-01 |
      | laatste dag verblijf buitenland | 2020-04-14 |

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
      | naam                              | waarde                |
      | type                              | RaadpleegMetPeildatum |
      | burgerservicenummer               | 000000012             |
      | peildatum                         | <peildatum>           |
      | exclusiefVerblijfplaatsBuitenland | false                 |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | land.code | land.omschrijving            | datumAanvangAdresBuitenland | datumAanvangVolgendeAdreshouding | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving |
      | 6014      | Verenigde Staten van Amerika | 20181201                    | 20200415                         | 1999                         | Registratie Niet Ingezetenen (RNI)   |

      Voorbeelden:
      | omschrijving                    | peildatum  |
      | eerste dag verblijf buitenland  | 2018-12-01 |
      | tijdens verblijf buitenland     | 2019-07-01 |
      | laatste dag verblijf buitenland | 2020-04-14 |

    Abstract Scenario: verblijfplaats buitenland wel geleverd zonder parameter exclusiefVerblijfplaatsBuitenland (default is false)
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
      | naam                              | waarde                |
      | type                              | RaadpleegMetPeildatum |
      | burgerservicenummer               | 000000012             |
      | peildatum                         | <peildatum>           |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | land.code | land.omschrijving            | datumAanvangAdresBuitenland | datumAanvangVolgendeAdreshouding | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving |
      | 6014      | Verenigde Staten van Amerika | 20181201                    | 20200415                         | 1999                         | Registratie Niet Ingezetenen (RNI)   |

      Voorbeelden:
      | omschrijving                    | peildatum  |
      | eerste dag verblijf buitenland  | 2018-12-01 |
      | tijdens verblijf buitenland     | 2019-07-01 |
      | laatste dag verblijf buitenland | 2020-04-14 |

    Abstract Scenario: verblijfplaats in Nederland geleverd bij exclusiefVerblijfplaatsBuitenland <waarde>
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
      | naam                              | waarde                |
      | type                              | RaadpleegMetPeildatum |
      | burgerservicenummer               | 000000012             |
      | peildatum                         | 2020-07-01            |
      | exclusiefVerblijfplaatsBuitenland | <waarde>              |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | straat        | adresseerbaarObjectIdentificatie | datumAanvangAdreshouding | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving |
      | Vierde straat | 0800010000000004                 | 20200415                 | 0800                         | Hoogeloon, Hapert en Casteren        |

      Voorbeelden:
      | waarde |
      | true   |
      | false  |

    Abstract Scenario: locatiebeschrijving in Nederland geleverd bij exclusiefVerblijfplaatsBuitenland <waarde>
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
      | naam                              | waarde                |
      | type                              | RaadpleegMetPeildatum |
      | burgerservicenummer               | 000000012             |
      | peildatum                         | 2017-01-01            |
      | exclusiefVerblijfplaatsBuitenland | <waarde>              |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | locatiebeschrijving | datumAanvangAdreshouding | datumAanvangVolgendeAdresBuitenland | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving |
      | De eerste locatie   | 20160526                 | 20181201                            | 0800                         | Hoogeloon, Hapert en Casteren        |

      Voorbeelden:
      | waarde |
      | true   |
      | false  |

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
      | naam                              | waarde                |
      | type                              | RaadpleegMetPeildatum |
      | burgerservicenummer               | 000000012             |
      | peildatum                         | 2019-07-01            |
      | exclusiefVerblijfplaatsBuitenland | true                  |
      Dan heeft de response 0 verblijfplaatsen

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
      | naam                              | waarde                |
      | type                              | RaadpleegMetPeildatum |
      | burgerservicenummer               | 000000012             |
      | peildatum                         | 2018-01-01            |
      | exclusiefVerblijfplaatsBuitenland | true                  |
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
      | naam                              | waarde                |
      | type                              | RaadpleegMetPeildatum |
      | burgerservicenummer               | 000000012             |
      | peildatum                         | 2019-01-01            |
      | exclusiefVerblijfplaatsBuitenland | true                  |
      Dan heeft de response 0 verblijfplaatsen
