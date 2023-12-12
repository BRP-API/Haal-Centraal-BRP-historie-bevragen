#language: nl

@gba
Functionaliteit: test dat alleen de juiste verblijfplaatsen worden geleverd in geval van onbekende aanvang opeenvolgende verblijfplaatsen

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

      #| gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | adresseerbaarObjectIdentificatie | straat        | datumAanvangAdreshouding | datumAanvangVolgendeAdreshouding |
      #| 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000004                 | Vierde straat | <aanvang 4>              |                                  |
      #| 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000003                 | Derde straat  | <aanvang 3>              | <aanvang 4>                      |
      #| 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000002                 | Tweede straat | <aanvang 2>              | <aanvang 3>                      |
      #| 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000001                 | Eerste straat | <aanvang 1>              | <aanvang 2>                      |


  Rule: Een verblijfplaats met onbekende aanvang van het verblijf en onbekende aanvang vorige binnen de onzekerheidsperiode van het verblijf wordt niet geleverd wanneer de gevraagde periode eindigt op of voor de eerste dag van de onzekerheidsperiode van het vorige verblijf

    Abstract Scenario: lever geen enkele verblijfplaats, omdat <omschrijving>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <aanvang 1>                        |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <aanvang 2>                        |
      En de persoon is vervolgens ingeschreven op adres 'A3' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <aanvang 3>                        |
      En de persoon is vervolgens ingeschreven op adres 'A4' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <aanvang 4>                        |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | <datum van>         |
      | datumTot            | <datum tot>         |
      Dan heeft de response 0 verblijfplaatsen

      Voorbeelden:
      | aanvang 1 | aanvang 2 | aanvang 3 | aanvang 4 | datum van  | datum tot  | omschrijving                                                                          |
      # A1    |
      # A2 ???????????????
      # A3          ?????-------------
      #     pp:--
      | 20080918  | 00000000  | 20100000  | 20121014  | 2007-01-01 | 2008-01-01 | periode ligt in onzekerheidsperiode A2 voor aanvang A1                                |
      | 20080918  | 00000000  | 20100500  | 20121014  | 2007-01-01 | 2008-01-01 | periode ligt in onzekerheidsperiode A2 voor aanvang A1                                |
      | 20100219  | 20100000  | 20100500  | 20121014  | 2010-01-01 | 2010-02-01 | periode ligt in onzekerheidsperiode A2 voor aanvang A1                                |
      # A1         |
      # A2 ????????????????
      # A3      ???????-------------
      #     ppp:--
      | 20100516  | 00000000  | 20100000  | 20121014  | 2009-01-01 | 2010-01-01 | periode ligt in onzekerheidsperiode A2 voor onzekerheidsperiode A3                    |
      | 20100516  | 00000000  | 20100500  | 20121014  | 2010-01-01 | 2010-05-01 | periode ligt in onzekerheidsperiode A2 voor onzekerheidsperiode A3                    |
      | 20100516  | 20100000  | 20100500  | 20121014  | 2010-04-01 | 2010-05-01 | periode ligt in onzekerheidsperiode A2 voor onzekerheidsperiode A3                    |
      # A1       |-----
      # A2             ????????
      # A3 ?????????????????????????-------------
      #      ppp:--
      | 20090526  | 20100000  | 00000000  | 20121014  | 2009-01-01 | 2009-05-26 | periode ligt in onzekerheidsperiode A3 voor onzekerheidsperiode A2 en voor aanvang A1 |
      | 20100219  | 20100500  | 00000000  | 20121014  | 2010-01-01 | 2010-02-01 | periode ligt in onzekerheidsperiode A3 voor onzekerheidsperiode A2 en voor aanvang A1 |
      | 20100219  | 20100500  | 20100000  | 20121014  | 2010-01-01 | 2010-02-01 | periode ligt in onzekerheidsperiode A3 voor onzekerheidsperiode A2 en voor aanvang A1 |
      # A1         |
      # A2      ????????
      # A3 ???????????????????-------------
      #      ppp:--
      | 20100526  | 20100000  | 00000000  | 20121014  | 2009-01-01 | 2010-01-01 | periode ligt in onzekerheidsperiode A3 voor onzekerheidsperiode A2                    |
      | 20100526  | 20100500  | 00000000  | 20121014  | 2009-01-01 | 2010-05-01 | periode ligt in onzekerheidsperiode A3 voor onzekerheidsperiode A2                    |
      | 20100526  | 20100500  | 20100000  | 20121014  | 2009-01-01 | 2010-05-01 | periode ligt in onzekerheidsperiode A3 voor onzekerheidsperiode A2                    |
      # A1           |
      # A2     ???????????????
      # A3     ???????????????-------------
      #    ppp:--
      | 20100526  | 20100000  | 20100000  | 20121014  | 2009-01-01 | 2010-01-01 | periode ligt voor gelijke onzekerheidsperiodes A2 en A3                               |
      | 20100526  | 20100500  | 20100500  | 20121014  | 2009-01-01 | 2010-05-01 | periode ligt voor gelijke onzekerheidsperiodes A2 en A3                               |

    Abstract Scenario: lever alleen A1, omdat <omschrijving>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <aanvang 1>                        |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <aanvang 2>                        |
      En de persoon is vervolgens ingeschreven op adres 'A3' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <aanvang 3>                        |
      En de persoon is vervolgens ingeschreven op adres 'A4' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <aanvang 4>                        |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | <datum van>         |
      | datumTot            | <datum tot>         |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | adresseerbaarObjectIdentificatie | straat        | datumAanvangAdreshouding | datumAanvangVolgendeAdreshouding |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000001                 | Eerste straat | <aanvang 1>              | <aanvang 2>                      |

      Voorbeelden:
      | aanvang 1 | aanvang 2 | aanvang 3 | aanvang 4 | datum van  | datum tot  | omschrijving                                         |
      # A1    |
      # A2 ???????????????
      # A3          ?????-------------
      #     ppp:1
      | 20080918  | 00000000  | 20100000  | 20121014  | 2008-01-01 | 2008-09-19 | periode ligt in onzekerheidsperiode A2 tot dag na A1 |
      | 20080918  | 00000000  | 20100500  | 20121014  | 2008-01-01 | 2008-09-19 | periode ligt in onzekerheidsperiode A2 tot dag na A1 |
      | 20100219  | 20100000  | 20100500  | 20121014  | 2010-01-01 | 2010-02-20 | periode ligt in onzekerheidsperiode A2 tot dag na A1 |
      | 20080228  | 00000000  | 20100000  | 20121014  | 2008-01-01 | 2008-02-29 | periode ligt in onzekerheidsperiode A2 tot dag na A1 |
      # A1       |-----
      # A2             ????????
      # A3 ?????????????????????????-------------
      #          p:1 (datumVan>=A1, datumTot<=A2)
      | 20080918  | 20100000  | 00000000  | 20121014  | 2008-09-18 | 2010-01-01 | periode ligt in onzekerheidsperiode A3 van A1 tot A2 |
      | 20080918  | 20100500  | 00000000  | 20121014  | 2008-09-18 | 2010-05-01 | periode ligt in onzekerheidsperiode A3 van A1 tot A2 |
      | 20100219  | 20100500  | 20100000  | 20121014  | 2010-03-01 | 2010-05-01 | periode ligt in onzekerheidsperiode A3 van A1 tot A2 |
      # A1  |----
      # A2       ???????????????
      # A3       ???????????????-------------
      #      ppp:1
      | 20080918  | 20100000  | 20100000  | 20121014  | 2008-09-18 | 2010-01-01 | periode ligt van A1 tot A2=A3                        |
      | 20080918  | 20100500  | 20100500  | 20121014  | 2008-09-18 | 2010-05-01 | periode ligt van A1 tot A2=A3                        |

    Abstract Scenario: lever alleen A2, omdat <omschrijving>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <aanvang 1>                        |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <aanvang 2>                        |
      En de persoon is vervolgens ingeschreven op adres 'A3' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <aanvang 3>                        |
      En de persoon is vervolgens ingeschreven op adres 'A4' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <aanvang 4>                        |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | <datum van>         |
      | datumTot            | <datum tot>         |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | adresseerbaarObjectIdentificatie | straat        | datumAanvangAdreshouding | datumAanvangVolgendeAdreshouding |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000002                 | Tweede straat | <aanvang 2>              | <aanvang 3>                      |

      Voorbeelden:
      | aanvang 1 | aanvang 2 | aanvang 3 | aanvang 4 | datum van  | datum tot  | omschrijving                                                                |
      # A1 |-------
      # A2    ???????????????
      # A3          ?????-------------
      #          ppp:2
      | 20080918  | 20100000  | 20100500  | 20121014  | 2010-01-01 | 2010-05-01 | periode ligt in onzekerheidsperiode A2 voor A3                              |
      # A1    |
      # A2 ???????????????
      # A3          ?????-------------
      #         ppp:2
      | 20080918  | 00000000  | 20100000  | 20121014  | 2008-09-19 | 2010-01-01 | periode ligt in onzekerheidsperiode A2 na A1 en voor A3                     |
      | 20080918  | 00000000  | 20100500  | 20121014  | 2008-09-19 | 2010-05-01 | periode ligt in onzekerheidsperiode A2 na A1 en voor A3                     |
      | 20100219  | 20100000  | 20100500  | 20121014  | 2010-02-20 | 2010-05-01 | periode ligt in onzekerheidsperiode A2 na A1 en voor A3                     |
      | 20080227  | 20080000  | 20080500  | 20121014  | 2008-02-28 | 2008-05-01 | periode ligt in onzekerheidsperiode A2 na A1 en voor A3                     |
      # A1       |-----
      # A2             ????????
      # A3 ?????????????????????????-------------
      #                p:2 (datumVan=A2, datumTot=A2+1)
      | 20080918  | 20100000  | 00000000  | 20121014  | 2010-01-01 | 2010-01-02 | periode is eerste dag onzekerheidsperiode A2 in onzekerheidsperiode A3      |
      | 20080918  | 20100500  | 00000000  | 20121014  | 2010-05-01 | 2010-05-02 | periode is eerste dag onzekerheidsperiode A2 in onzekerheidsperiode A3      |
      | 20100219  | 20100500  | 20100000  | 20121014  | 2010-05-01 | 2010-05-02 | periode is eerste dag onzekerheidsperiode A2 in onzekerheidsperiode A3      |
      # A1  |----
      # A2       ???????????????
      # A3       ???????????????-------------
      #          p:2 (datumVan=A2, datumTot=A2+1)
      | 20080918  | 20100000  | 20100000  | 20121014  | 2010-01-01 | 2010-01-02 | periode is eerste dag onzekerheidsperiode A2 = onzekerheidsperiode A3       |
      | 20080918  | 20100500  | 20100500  | 20121014  | 2010-05-01 | 2010-05-02 | periode is eerste dag onzekerheidsperiode A2 = onzekerheidsperiode A3       |

    Abstract Scenario: lever alleen A3, omdat <omschrijving>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <aanvang 1>                        |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <aanvang 2>                        |
      En de persoon is vervolgens ingeschreven op adres 'A3' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <aanvang 3>                        |
      En de persoon is vervolgens ingeschreven op adres 'A4' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <aanvang 4>                        |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | <datum van>         |
      | datumTot            | <datum tot>         |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | adresseerbaarObjectIdentificatie | straat        | datumAanvangAdreshouding | datumAanvangVolgendeAdreshouding |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000003                 | Derde straat  | <aanvang 3>              | <aanvang 4>                      |

      Voorbeelden:
      | aanvang 1 | aanvang 2 | aanvang 3 | aanvang 4 | datum van  | datum tot  | omschrijving                                                                          |
      # A1 |--
      # A2    ???????????????
      # A3          ?????-------------
      #             ppp:3
      | 20080918  | 20100000  | 20100500  | 20121014  | 2010-05-01 | 2011-05-01 | periode vanaf eerste dag A3                                                           |
      # A1    |
      # A2 ???????????????
      # A3          ?????-------------
      #             ppp:3
      | 20080918  | 00000000  | 20100000  | 20121014  | 2010-05-01 | 2011-05-01 | periode vanaf eerste dag A3                                                           |
      | 20080918  | 00000000  | 20100500  | 20121014  | 2010-05-01 | 2011-05-01 | periode vanaf eerste dag A3                                                           |
      | 20100219  | 20100000  | 20100500  | 20121014  | 2010-05-01 | 2011-05-01 | periode vanaf eerste dag A3                                                           |
      # A1         |
      # A2 ????????????????
      # A3    ?????????-------------
      #              ppp:3
      | 20100516  | 00000000  | 20100000  | 20121014  | 2010-05-18 | 2011-05-17 | periode vanaf tweede dag na A1 in onzekerheidsperiode A3 en in onzekerheidsperiode A2 |
      | 20100516  | 00000000  | 20100500  | 20121014  | 2010-05-18 | 2011-05-17 | periode vanaf tweede dag na A1 in onzekerheidsperiode A3 en in onzekerheidsperiode A2 |
      | 20100516  | 20100000  | 20100500  | 20121014  | 2010-05-18 | 2011-05-17 | periode vanaf tweede dag na A1 in onzekerheidsperiode A3 en in onzekerheidsperiode A2 |
      # A1         |
      # A2 ????????????????
      # A3    ?????????-------------
      #        ppp:3 (in principe onjuist, maar gevolg van niet recursief terugkijken naar voor-vorige)
      | 20100516  | 00000000  | 20100000  | 20121014  | 2010-01-01 | 2010-05-16 | periode ligt voor A1 in onzekerheidsperiode A3 en in onzekerheidsperiode A2           |
      | 20100516  | 00000000  | 20100500  | 20121014  | 2010-05-01 | 2010-05-16 | periode ligt voor A1 in onzekerheidsperiode A3 en in onzekerheidsperiode A2           |
      | 20100516  | 20100000  | 20100500  | 20121014  | 2010-05-01 | 2010-05-16 | periode ligt voor A1 in onzekerheidsperiode A3 en in onzekerheidsperiode A2           |
      # A1       |
      # A2 ????????????????????????????
      # A3             ???????????
      # A4                   |-------
      #                  ppp:3 (datumTot<=A4)
      | 20080918  | 00000000  | 20100000  | 20101014  | 2010-01-01 | 2010-10-14 | periode in onzekerheidsperiode A3 tot A4                                              |
      | 20080918  | 00000000  | 20100500  | 20100526  | 2010-05-01 | 2010-05-26 | periode in onzekerheidsperiode A3 tot A4                                              |
      # A1       |-----
      # A2             ????????
      # A3 ?????????????????????????-------------
      #                 ppp:3 (datumVan>A2)
      | 20080918  | 20100000  | 00000000  | 20121014  | 2010-01-02 | 2012-10-14 | periode vanaf tweede dag onzekerheidsperiode A2 in A3                                 |
      | 20080918  | 20100500  | 00000000  | 20121014  | 2010-05-02 | 2012-10-14 | periode vanaf tweede dag onzekerheidsperiode A2 in A3                                 |
      | 20080918  | 20100500  | 20100000  | 20121014  | 2010-05-02 | 2012-10-14 | periode vanaf tweede dag onzekerheidsperiode A2 in A3                                 |
      # A1         |
      # A2      ????????
      # A3 ???????????????????-------------
      #         ppp:3 (in principe onjuist, maar gevolg van niet recursief terugkijken naar voor-vorige)
      | 20100516  | 20100000  | 00000000  | 20121014  | 2010-01-02 | 2010-05-16 | periode vanaf eerste dag onzekerheidsperiode A2 in A3 en voor A1                      |
      | 20100516  | 20100500  | 00000000  | 20121014  | 2010-05-02 | 2010-05-16 | periode vanaf eerste dag onzekerheidsperiode A2 in A3 en voor A1                      |
      | 20100516  | 20100500  | 20100000  | 20121014  | 2010-05-02 | 2010-05-16 | periode vanaf eerste dag onzekerheidsperiode A2 in A3 en voor A1                      |
      | 20100516  | 20100000  | 00000000  | 20121014  | 2009-11-01 | 2010-01-03 | periode tot derde dag onzekerheidsperiode A2 in A3 en voor A1                         |
      | 20100516  | 20100500  | 00000000  | 20121014  | 2009-11-01 | 2010-05-03 | periode tot derde dag onzekerheidsperiode A2 in A3 en voor A1                         |
      # A1         |
      # A2      ????????
      # A3 ???????????????????-------------
      #             ppp:3 (datumVan>A1)
      | 20100516  | 20100000  | 00000000  | 20121014  | 2010-05-18 | 2012-10-14 | periode vanaf tweede dag na A1 in onzekerheidsperiode A2 in onzekerheidsperiode A3    |
      | 20100516  | 20100500  | 00000000  | 20121014  | 2010-05-18 | 2012-10-14 | periode vanaf tweede dag na A1 in onzekerheidsperiode A2 in onzekerheidsperiode A3    |
      | 20100516  | 20100500  | 20100000  | 20121014  | 2010-05-18 | 2012-10-14 | periode vanaf tweede dag na A1 in onzekerheidsperiode A2 in onzekerheidsperiode A3    |
      | 20100516  | 20100000  | 00000000  | 20121014  | 2010-05-18 | 2011-05-18 | periode vanaf tweede dag na A1 in onzekerheidsperiode A2 in onzekerheidsperiode A3    |
      | 20100516  | 20100500  | 00000000  | 20121014  | 2010-05-18 | 2011-05-18 | periode vanaf tweede dag na A1 in onzekerheidsperiode A2 in onzekerheidsperiode A3    |
      | 20100516  | 20100500  | 20100000  | 20121014  | 2010-05-18 | 2011-05-18 | periode vanaf tweede dag na A1 in onzekerheidsperiode A2 in onzekerheidsperiode A3    |
      # A1       |-----
      # A2             ???????????
      # A3 ????????????????????????????-------------
      # A4                   |-------
      #                  ppp:3 (datumVan>A2, datumTot<=A4)
      | 20080918  | 20100000  | 00000000  | 20101014  | 2010-01-02 | 2010-10-14 | periode voor A4 in onzekerheidsperiode A2 en A3                                       |
      | 20080918  | 20100500  | 00000000  | 20100526  | 2010-05-02 | 2010-05-26 | periode voor A4 in onzekerheidsperiode A2 en A3                                       |
      | 20080918  | 20100500  | 20100000  | 20100526  | 2010-05-02 | 2010-05-26 | periode voor A4 in onzekerheidsperiode A2 en A3                                       |
      | 20080918  | 20100000  | 00000000  | 20101014  | 2010-10-13 | 2010-10-14 | periode is dag voor A4 in onzekerheidsperiode A2 en A3                                |
      | 20080918  | 20100500  | 00000000  | 20100526  | 2010-05-25 | 2010-05-26 | periode is dag voor A4 in onzekerheidsperiode A2 en A3                                |
      | 20080918  | 20100500  | 20100000  | 20100526  | 2010-05-25 | 2010-05-26 | periode is dag voor A4 in onzekerheidsperiode A2 en A3                                |
      # A1  |----
      # A2       ???????????????
      # A3       ???????????????-------------
      #           ppp:3 (datumVan>A2)
      | 20080918  | 20100000  | 20100000  | 20121014  | 2010-01-02 | 2010-10-14 | periode vanaf tweede dag onzekerheidsperiode A2=A3                                    |
      | 20080918  | 20100500  | 20100500  | 20121014  | 2010-05-02 | 2010-05-26 | periode vanaf tweede dag onzekerheidsperiode A2=A3                                    |
      | 20080918  | 20100000  | 20100000  | 20121014  | 2010-01-02 | 2010-01-03 | periode is tweede dag onzekerheidsperiode A2=A3                                       |
      | 20080918  | 20100500  | 20100500  | 20121014  | 2010-05-02 | 2010-05-03 | periode is tweede dag onzekerheidsperiode A2=A3                                       |
      # A1           |
      # A2     ???????????????
      # A3     ???????????????-------------
      #          ppp:3 (in principe onjuist, maar gevolg van niet recursief terugkijken naar voor-vorige)
      | 20100516  | 00000000  | 00000000  | 20121014  | 2010-01-01 | 2010-05-16 | periode in onzekerheidsperiode A2=A3 voor A1                                          |
      | 20100516  | 20100000  | 20100000  | 20121014  | 2010-01-01 | 2010-05-16 | periode in onzekerheidsperiode A2=A3 voor A1                                          |
      | 20100516  | 20100500  | 20100500  | 20121014  | 2010-01-01 | 2010-05-16 | periode in onzekerheidsperiode A2=A3 voor A1                                          |
      # A1           |
      # A2     ???????????????
      # A3     ???????????????-------------
      #                ppp:3
      | 20100516  | 00000000  | 00000000  | 20121014  | 2010-05-18 | 2012-10-14 | periode vanaf twee dagen na A1 in onzekerheidsperiode A2=A3                           |
      | 20100516  | 20100000  | 20100000  | 20121014  | 2010-05-18 | 2012-10-14 | periode vanaf twee dagen na A1 in onzekerheidsperiode A2=A3                           |
      | 20100516  | 20100500  | 20100500  | 20121014  | 2010-05-18 | 2012-10-14 | periode vanaf twee dagen na A1 in onzekerheidsperiode A2=A3                           |

    Abstract Scenario: lever alleen A4, omdat <omschrijving>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <aanvang 1>                        |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <aanvang 2>                        |
      En de persoon is vervolgens ingeschreven op adres 'A3' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <aanvang 3>                        |
      En de persoon is vervolgens ingeschreven op adres 'A4' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <aanvang 4>                        |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | <datum van>         |
      | datumTot            | <datum tot>         |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | adresseerbaarObjectIdentificatie | straat        | datumAanvangAdreshouding | datumAanvangVolgendeAdreshouding |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000004                 | Vierde straat | <aanvang 4>              |                                  |

      Voorbeelden:
      | aanvang 1 | aanvang 2 | aanvang 3 | aanvang 4 | datum van  | datum tot  | omschrijving                                                         |
      # A1       |
      # A2 ????????????????????????????
      # A3             ???????????
      # A4                   |-------
      #                       ppp:4 (datumVan>=A4)
      | 20080918  | 00000000  | 20100000  | 20100526  | 2010-05-30 | 2011-05-27 | periode na A4 in onzekerheidsperiode A3 in onzekerheidsperiode A2    |
      | 20080918  | 00000000  | 20100500  | 20100526  | 2010-05-30 | 2011-05-27 | periode na A4 in onzekerheidsperiode A3 in onzekerheidsperiode A2    |
      | 20100219  | 20100000  | 20100500  | 20100526  | 2010-05-30 | 2011-05-27 | periode na A4 in onzekerheidsperiode A3 in onzekerheidsperiode A2    |
      | 20080918  | 00000000  | 20100000  | 20100526  | 2010-05-26 | 2010-05-27 | periode is A4 in onzekerheidsperiode A3 in onzekerheidsperiode A2    |
      | 20080918  | 00000000  | 20100500  | 20100526  | 2010-05-26 | 2010-05-27 | periode is A4 in onzekerheidsperiode A3 in onzekerheidsperiode A2    |
      | 20100219  | 20100000  | 20100500  | 20100526  | 2010-05-26 | 2010-05-27 | periode is A4 in onzekerheidsperiode A3 in onzekerheidsperiode A2    |
      # A1       |-----
      # A2             ???????????
      # A3 ????????????????????????????-------------
      # A4                   |-------
      #                       ppp:4 (datumVan>=A4)
      | 20080918  | 20100000  | 00000000  | 20100526  | 2010-05-30 | 2010-06-03 | periode na A4 in onzekerheidsperiode A2 in onzekerheidsperiode A3 |
      | 20080918  | 20100500  | 00000000  | 20100526  | 2010-05-30 | 2010-06-03 | periode na A4 in onzekerheidsperiode A2 in onzekerheidsperiode A3 |
      | 20080918  | 20100500  | 20100000  | 20100526  | 2010-05-30 | 2010-06-03 | periode na A4 in onzekerheidsperiode A2 in onzekerheidsperiode A3 |
      | 20080918  | 20100000  | 00000000  | 20100526  | 2010-05-26 | 2010-05-27 | periode is A4 in onzekerheidsperiode A2 in onzekerheidsperiode A3 |
      | 20080918  | 20100500  | 00000000  | 20100526  | 2010-05-26 | 2010-05-27 | periode is A4 in onzekerheidsperiode A2 in onzekerheidsperiode A3 |
      | 20080918  | 20100500  | 20100000  | 20100526  | 2010-05-26 | 2010-05-27 | periode is A4 in onzekerheidsperiode A2 in onzekerheidsperiode A3 |

    Abstract Scenario: lever A1 + A3, omdat <omschrijving>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <aanvang 1>                        |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <aanvang 2>                        |
      En de persoon is vervolgens ingeschreven op adres 'A3' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <aanvang 3>                        |
      En de persoon is vervolgens ingeschreven op adres 'A4' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <aanvang 4>                        |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | <datum van>         |
      | datumTot            | <datum tot>         |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | adresseerbaarObjectIdentificatie | straat        | datumAanvangAdreshouding | datumAanvangVolgendeAdreshouding |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000003                 | Derde straat  | <aanvang 3>              | <aanvang 4>                      |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000001                 | Eerste straat | <aanvang 1>              | <aanvang 2>                      |

      Voorbeelden:
      | aanvang 1 | aanvang 2 | aanvang 3 | aanvang 4 | datum van  | datum tot  | omschrijving                                                            |
      # A1         |
      # A2 ????????????????
      # A3      ???????-------------
      #          ppp:1+3 (datumTot=A1+1, A3 wordt geleverd als gevolg van niet recursief terugkijken naar voor-vorige van A3)
      | 20100516  | 00000000  | 20100000  | 20121014  | 2010-05-14 | 2010-05-17 | periode overlapt A1 in onzekerheidsperiode A3 in onzekerheidsperiode A2 |
      | 20100516  | 00000000  | 20100500  | 20121014  | 2010-05-14 | 2010-05-17 | periode overlapt A1 in onzekerheidsperiode A3 in onzekerheidsperiode A2 |
      | 20100516  | 20100000  | 20100500  | 20121014  | 2010-05-14 | 2010-05-17 | periode overlapt A1 in onzekerheidsperiode A3 in onzekerheidsperiode A2 |
      # A1         |
      # A2      ????????
      # A3 ???????????????????-------------
      #           ppp:1+3 (in principe onjuist, A3 wordt geleverd als gevolg van niet recursief terugkijken naar voor-vorige van A3)
      | 20100516  | 20100000  | 00000000  | 20121014  | 2010-01-01 | 2010-05-17 | periode tot A1 in onzekerheidsperiode A2 in onzekerheidsperiode A3      |
      | 20100516  | 20100500  | 00000000  | 20121014  | 2010-05-01 | 2010-05-17 | periode tot A1 in onzekerheidsperiode A2 in onzekerheidsperiode A3      |
      | 20100516  | 20100500  | 20100000  | 20121014  | 2010-05-01 | 2010-05-17 | periode tot A1 in onzekerheidsperiode A2 in onzekerheidsperiode A3      |
      
    Abstract Scenario: lever A2 + A3, omdat <omschrijving>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <aanvang 1>                        |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <aanvang 2>                        |
      En de persoon is vervolgens ingeschreven op adres 'A3' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <aanvang 3>                        |
      En de persoon is vervolgens ingeschreven op adres 'A4' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <aanvang 4>                        |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | <datum van>         |
      | datumTot            | <datum tot>         |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | adresseerbaarObjectIdentificatie | straat        | datumAanvangAdreshouding | datumAanvangVolgendeAdreshouding |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000003                 | Derde straat  | <aanvang 3>              | <aanvang 4>                      |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000002                 | Tweede straat | <aanvang 2>              | <aanvang 3>                      |

      Voorbeelden:
      | aanvang 1 | aanvang 2 | aanvang 3 | aanvang 4 | datum van  | datum tot  | omschrijving                                                                 |
      # A1 |--
      # A2    ???????????????
      # A3          ?????-------------
      #           ppp:2+3
      | 20080918  | 20100000  | 20100500  | 20121014  | 2010-04-30 | 2010-05-02 | periode overlapt eerste dag onzekerheidsperiode A3 in onzekerheidsperiode A2 |
      # A1    |
      # A2 ???????????????
      # A3          ?????-------------
      #           ppp:2+3
      | 20080918  | 00000000  | 20100000  | 20121014  | 2009-12-31 | 2010-01-02 | periode overlapt eerste dag onzekerheidsperiode A3 in onzekerheidsperiode A2 |
      | 20100219  | 00000000  | 20100500  | 20121014  | 2010-04-30 | 2010-05-02 | periode overlapt eerste dag onzekerheidsperiode A3 in onzekerheidsperiode A2 |
      | 20100219  | 20100000  | 20100500  | 20121014  | 2010-04-30 | 2010-05-02 | periode overlapt eerste dag onzekerheidsperiode A3 in onzekerheidsperiode A2 |
      # A1         |
      # A2 ????????????????
      # A3    ?????????-------------
      #             p:2+3 (datumVan=A1+1, in principe onjuist, A3 wordt geleverd als gevolg van niet recursief terugkijken naar voor-vorige van A3)
      | 20100516  | 00000000  | 20100000  | 20121014  | 2010-05-17 | 2011-05-18 | periode is dag na A1 in onzekerheidsperiode A3 en in onzekerheidsperiode A2  |
      | 20100516  | 00000000  | 20100500  | 20121014  | 2010-05-17 | 2011-05-18 | periode is dag na A1 in onzekerheidsperiode A3 en in onzekerheidsperiode A2  |
      | 20100516  | 20100000  | 20100500  | 20121014  | 2010-05-17 | 2011-05-18 | periode is dag na A1 in onzekerheidsperiode A3 en in onzekerheidsperiode A2  |
      # A1           |
      # A2     ???????????????
      # A3     ???????????????-------------
      #               p:3 (datumVan=A1+1, in principe onjuist, A3 wordt geleverd als gevolg van niet recursief terugkijken naar voor-vorige van A3)
      | 20100516  | 20100500  | 20100500  | 20121014  | 2010-05-17 | 2010-05-18 | periode is eerste dag na A1 in onzekerheidsperiode A2=A3                              |

    Abstract Scenario: lever A1 + A2 + A3, omdat <omschrijving>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <aanvang 1>                        |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <aanvang 2>                        |
      En de persoon is vervolgens ingeschreven op adres 'A3' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <aanvang 3>                        |
      En de persoon is vervolgens ingeschreven op adres 'A4' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <aanvang 4>                        |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | <datum van>         |
      | datumTot            | <datum tot>         |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | adresseerbaarObjectIdentificatie | straat        | datumAanvangAdreshouding | datumAanvangVolgendeAdreshouding |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000003                 | Derde straat  | <aanvang 3>              | <aanvang 4>                      |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000002                 | Tweede straat | <aanvang 2>              | <aanvang 3>                      |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000001                 | Eerste straat | <aanvang 1>              | <aanvang 2>                      |
      Voorbeelden:
      | aanvang 1 | aanvang 2 | aanvang 3 | aanvang 4 | datum van  | datum tot  | omschrijving                                                            |
      # A1+A2+A3
      # A1         |
      # A2      ????????
      # A3 ???????????????????-------------
      #           ppp:1+3 (datumTot=A1+1, in principe onjuist, A3 wordt geleverd als gevolg van niet recursief terugkijken naar voor-vorige van A3)
      | 20100516  | 20100000  | 00000000  | 20121014  | 2010-05-14 | 2010-05-18 | periode overlapt A1 in onzekerheidsperiode A2 in onzekerheidsperiode A3 |
      | 20100516  | 20100500  | 00000000  | 20121014  | 2010-05-14 | 2010-05-18 | periode overlapt A1 in onzekerheidsperiode A2 in onzekerheidsperiode A3 |
      | 20100516  | 20100500  | 20100000  | 20121014  | 2010-05-14 | 2010-05-18 | periode overlapt A1 in onzekerheidsperiode A2 in onzekerheidsperiode A3 |
      # A1           |
      # A2     ???????????????
      # A3     ???????????????-------------
      #              p:1+3 (datumTot=A1+1, in principe onjuist, A3 wordt geleverd als gevolg van niet recursief terugkijken naar voor-vorige van A3)
      | 20100516  | 00000000  | 00000000  | 20121014  | 2010-05-14 | 2010-05-18 | periode overlapt A1 in onzekerheidsperiode A2=A3                        |
      | 20100516  | 20100000  | 20100000  | 20121014  | 2010-05-14 | 2010-05-18 | periode overlapt A1 in onzekerheidsperiode A2=A3                        |
      | 20100516  | 20100500  | 20100500  | 20121014  | 2010-05-14 | 2010-05-18 | periode overlapt A1 in onzekerheidsperiode A2=A3                        |