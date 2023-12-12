#language: nl

@gba
Functionaliteit: test dat alleen de juiste verblijfplaats(en) wordt geleverd in geval van onbekende aanvang opeenvolgende verblijfplaatsen en vragen met peildatum

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


  Rule: Een verblijfplaats met onbekende aanvang van het verblijf en onbekende aanvang vorige binnen de onzekerheidsperiode van het verblijf wordt niet geleverd wanneer de gevraagde peildatum ligt op of voor de eerste dag van de onzekerheidsperiode van het vorige verblijf
    # de testgevallen gaan er vanuit dat er steeds alleen naar de vorige verblijfplaats wordt gekeken, niet naar de voor-vorige
    # dus niet eerst de vorige begrenzen door de vorige-van-de-vorige
    # gevolg is dat het resultaat op een aantal plekken functioneel onjuist is, maar wel exact voldoet aan de beschreven regel
    # op een later moment kunnen we kijken of dit op te lossen is (mogelijk ondersteunt de code van de API namelijk al kijken naar de voor-vorige)

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
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 000000012             |
      | peildatum           | <peildatum>           |
      Dan heeft de response 0 verblijfplaatsen

      Voorbeelden:
      | aanvang 1 | aanvang 2 | aanvang 3 | aanvang 4 | peildatum  | omschrijving                                                                            |
      # A1    |
      # A2 ???????????????
      # A3          ?????-------------
      #     pp:--
      | 20080918  | 00000000  | 20100000  | 20121014  | 2008-09-17 | peildatum ligt in onzekerheidsperiode A2 voor aanvang A1                                |
      | 20080918  | 00000000  | 20100500  | 20121014  | 2008-09-17 | peildatum ligt in onzekerheidsperiode A2 voor aanvang A1                                |
      | 20100219  | 20100000  | 20100500  | 20121014  | 2010-02-18 | peildatum ligt in onzekerheidsperiode A2 voor aanvang A1                                |
      # A1         |
      # A2 ????????????????
      # A3      ???????-------------
      #     ppp:--
      | 20100516  | 00000000  | 20100000  | 20121014  | 2009-12-31 | peildatum ligt in onzekerheidsperiode A2 voor onzekerheidsperiode A3                    |
      | 20100516  | 00000000  | 20100500  | 20121014  | 2010-04-30 | peildatum ligt in onzekerheidsperiode A2 voor onzekerheidsperiode A3                    |
      | 20100516  | 20100000  | 20100500  | 20121014  | 2010-04-30 | peildatum ligt in onzekerheidsperiode A2 voor onzekerheidsperiode A3                    |
      # A1       |-----
      # A2             ????????
      # A3 ?????????????????????????-------------
      #      ppp:--
      | 20090526  | 20100000  | 00000000  | 20121014  | 2009-05-25 | peildatum ligt in onzekerheidsperiode A3 voor onzekerheidsperiode A2 en voor aanvang A1 |
      | 20100219  | 20100500  | 00000000  | 20121014  | 2010-02-18 | peildatum ligt in onzekerheidsperiode A3 voor onzekerheidsperiode A2 en voor aanvang A1 |
      | 20100219  | 20100500  | 20100000  | 20121014  | 2010-02-18 | peildatum ligt in onzekerheidsperiode A3 voor onzekerheidsperiode A2 en voor aanvang A1 |
      # A1         |
      # A2      ????????
      # A3 ???????????????????-------------
      #      ppp:--
      | 20100526  | 20100000  | 00000000  | 20121014  | 2009-12-31 | peildatum ligt in onzekerheidsperiode A3 voor onzekerheidsperiode A2                    |
      | 20100526  | 20100500  | 00000000  | 20121014  | 2010-04-30 | peildatum ligt in onzekerheidsperiode A3 voor onzekerheidsperiode A2                    |
      | 20100526  | 20100500  | 20100000  | 20121014  | 2010-04-30 | peildatum ligt in onzekerheidsperiode A3 voor onzekerheidsperiode A2                    |
      # A1           |
      # A2     ???????????????
      # A3     ???????????????-------------
      #    ppp:--
      | 20100526  | 20100000  | 20100000  | 20121014  | 2009-12-31 | peildatum ligt voor gelijke onzekerheidsperiodes A2 en A3                               |
      | 20100526  | 20100500  | 20100500  | 20121014  | 2010-04-30 | peildatum ligt voor gelijke onzekerheidsperiodes A2 en A3                               |

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
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 000000012             |
      | peildatum           | <peildatum>           |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | adresseerbaarObjectIdentificatie | straat        | datumAanvangAdreshouding | datumAanvangVolgendeAdreshouding |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000001                 | Eerste straat | <aanvang 1>              | <aanvang 2>                      |

      Voorbeelden:
      | aanvang 1 | aanvang 2 | aanvang 3 | aanvang 4 | peildatum  | omschrijving                                      |
      # A1    |
      # A2 ???????????????
      # A3          ?????-------------
      #       p:1
      | 20080918  | 00000000  | 20100000  | 20121014  | 2008-09-18 | peildatum is A1 in onzekerheidsperiode A2         |
      | 20080918  | 00000000  | 20100500  | 20121014  | 2008-09-18 | peildatum is A1 in onzekerheidsperiode A2         |
      | 20100219  | 20100000  | 20100500  | 20121014  | 2010-02-19 | peildatum is A1 in onzekerheidsperiode A2         |
      | 20080229  | 00000000  | 20100000  | 20121014  | 2008-02-29 | peildatum is A1 in onzekerheidsperiode A2         |
      # A1       |-----
      # A2             ????????
      # A3 ?????????????????????????-------------
      #          p:1
      | 20080918  | 20100000  | 00000000  | 20121014  | 2008-09-18 | peildatum is A1 in onzekerheidsperiode A3 voor A2 |
      | 20080918  | 20100500  | 00000000  | 20121014  | 2008-09-18 | peildatum is A1 in onzekerheidsperiode A3 voor A2 |
      | 20100219  | 20100500  | 20100000  | 20121014  | 2010-02-19 | peildatum is A1 in onzekerheidsperiode A3 voor A2 |
      # A1  |----
      # A2       ???????????????
      # A3       ???????????????-------------
      #      ppp:1
      | 20080918  | 20100000  | 20100000  | 20121014  | 2008-09-18 | peildatum is A1 voor A2=A3                        |
      | 20080918  | 20100500  | 20100500  | 20121014  | 2008-09-18 | peildatum is A1 voor A2=A3                        |
      | 20080918  | 20100000  | 20100000  | 20121014  | 2009-07-30 | peildatum na A1 voor A2=A3                        |
      | 20080918  | 20100500  | 20100500  | 20121014  | 2009-07-30 | peildatum na A1 voor A2=A3                        |
      | 20080918  | 20100000  | 20100000  | 20121014  | 2009-12-31 | peildatum na A1 dag voor A2=A3                    |
      | 20080918  | 20100500  | 20100500  | 20121014  | 2010-04-30 | peildatum na A1 dag voor A2=A3                    |

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
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 000000012             |
      | peildatum           | <peildatum>           |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | adresseerbaarObjectIdentificatie | straat        | datumAanvangAdreshouding | datumAanvangVolgendeAdreshouding |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000002                 | Tweede straat | <aanvang 2>              | <aanvang 3>                      |

      Voorbeelden:
      | aanvang 1 | aanvang 2 | aanvang 3 | aanvang 4 | peildatum  | omschrijving                                                             |
      # A1 |-------
      # A2    ???????????????
      # A3          ?????-------------
      #          ppp:2
      | 20080918  | 20100000  | 20100500  | 20121014  | 2010-01-01 | peildatum ligt in onzekerheidsperiode A2 voor A3                         |
      | 20080918  | 20100000  | 20100500  | 20121014  | 2010-04-30 | peildatum ligt in onzekerheidsperiode A2 voor A3                         |
      # A1    |
      # A2 ???????????????
      # A3          ?????-------------
      #         ppp:2
      | 20080918  | 00000000  | 20100000  | 20121014  | 2008-09-19 | peildatum ligt in onzekerheidsperiode A2 na A1 en voor A3                |
      | 20080918  | 00000000  | 20100000  | 20121014  | 2009-01-01 | peildatum ligt in onzekerheidsperiode A2 na A1 en voor A3                |
      | 20080918  | 00000000  | 20100000  | 20121014  | 2009-12-31 | peildatum ligt in onzekerheidsperiode A2 na A1 en voor A3                |
      | 20080918  | 00000000  | 20100500  | 20121014  | 2010-04-30 | peildatum ligt in onzekerheidsperiode A2 na A1 en voor A3                |
      | 20100219  | 20100000  | 20100500  | 20121014  | 2010-02-20 | peildatum ligt in onzekerheidsperiode A2 na A1 en voor A3                |
      | 20100219  | 20100000  | 20100500  | 20121014  | 2010-04-30 | peildatum ligt in onzekerheidsperiode A2 na A1 en voor A3                |
      | 20100219  | 20100000  | 20100500  | 20121014  | 2010-03-14 | peildatum ligt in onzekerheidsperiode A2 na A1 en voor A3                |
      | 20080227  | 20080000  | 20080500  | 20121014  | 2008-02-28 | peildatum ligt in onzekerheidsperiode A2 na A1 en voor A3                |
      | 20080227  | 20080000  | 20080500  | 20121014  | 2008-04-30 | peildatum ligt in onzekerheidsperiode A2 na A1 en voor A3                |
      # A1       |-----
      # A2             ????????
      # A3 ?????????????????????????-------------
      #                p:2 (datumVan=A2, datumTot=A2+1)
      | 20080918  | 20100000  | 00000000  | 20121014  | 2010-01-01 | peildatum is eerste dag onzekerheidsperiode A2 in onzekerheidsperiode A3 |
      | 20080918  | 20100500  | 00000000  | 20121014  | 2010-05-01 | peildatum is eerste dag onzekerheidsperiode A2 in onzekerheidsperiode A3 |
      | 20100219  | 20100500  | 20100000  | 20121014  | 2010-05-01 | peildatum is eerste dag onzekerheidsperiode A2 in onzekerheidsperiode A3 |
      # A1  |----
      # A2       ???????????????
      # A3       ???????????????-------------
      #          p:2 (datumVan=A2, datumTot=A2+1)
      | 20080918  | 20100000  | 20100000  | 20121014  | 2010-01-01 | peildatum is eerste dag onzekerheidsperiode A2 = onzekerheidsperiode A3  |
      | 20080918  | 20100500  | 20100500  | 20121014  | 2010-05-01 | peildatum is eerste dag onzekerheidsperiode A2 = onzekerheidsperiode A3  |

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
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 000000012             |
      | peildatum           | <peildatum>           |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | adresseerbaarObjectIdentificatie | straat        | datumAanvangAdreshouding | datumAanvangVolgendeAdreshouding |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000003                 | Derde straat  | <aanvang 3>              | <aanvang 4>                      |

      Voorbeelden:
      | aanvang 1 | aanvang 2 | aanvang 3 | aanvang 4 | peildatum  | omschrijving                                                                             |
      # A1 |--
      # A2    ???????????????
      # A3          ?????-------------
      #             ppp:3
      | 20080918  | 20100000  | 20100500  | 20121014  | 2010-05-01 | peildatum is eerste dag A3                                                               |
      | 20080918  | 20100000  | 20100500  | 20121014  | 2010-05-16 | peildatum na eerste dag A3 in onzekerheidsperiode A3                                     |
      | 20080918  | 20100000  | 20100500  | 20121014  | 2010-07-01 | peildatum na eerste dag A3 na onzekerheidsperiode A3                                     |
      # A1    |
      # A2 ???????????????
      # A3        ?????-------------
      #           pppppp:3
      | 20080918  | 00000000  | 20100000  | 20121014  | 2010-01-01 | peildatum is eerste dag A3                                                               |
      | 20080918  | 00000000  | 20100500  | 20121014  | 2010-05-01 | peildatum is eerste dag A3                                                               |
      | 20100219  | 20100000  | 20100500  | 20121014  | 2010-05-01 | peildatum is eerste dag A3                                                               |
      | 20080918  | 00000000  | 20100000  | 20121014  | 2010-07-01 | peildatum na eerste dag A3 in onzekerheidsperiode A3                                     |
      | 20080918  | 00000000  | 20100500  | 20121014  | 2010-05-16 | peildatum na eerste dag A3 in onzekerheidsperiode A3                                     |
      | 20100219  | 20100000  | 20100500  | 20121014  | 2010-05-16 | peildatum na eerste dag A3 in onzekerheidsperiode A3                                     |
      | 20080918  | 00000000  | 20100000  | 20121014  | 2011-05-01 | peildatum na eerste dag A3 na onzekerheidsperiode A3                                     |
      | 20080918  | 00000000  | 20100500  | 20121014  | 2011-05-01 | peildatum na eerste dag A3 na onzekerheidsperiode A3                                     |
      | 20100219  | 20100000  | 20100500  | 20121014  | 2011-05-01 | peildatum na eerste dag A3 na onzekerheidsperiode A3                                     |
      # A1         |
      # A2 ????????????????
      # A3    ?????????-------------
      #              ppp:3
      | 20100516  | 00000000  | 20100000  | 20121014  | 2010-05-18 | peildatum is tweede dag na A1 in onzekerheidsperiode A3 en in onzekerheidsperiode A2     |
      | 20100516  | 00000000  | 20100500  | 20121014  | 2010-05-18 | peildatum is tweede dag na A1 in onzekerheidsperiode A3 en in onzekerheidsperiode A2     |
      | 20100516  | 20100000  | 20100500  | 20121014  | 2010-05-18 | peildatum is tweede dag na A1 in onzekerheidsperiode A3 en in onzekerheidsperiode A2     |
      | 20100516  | 00000000  | 20100000  | 20121014  | 2010-05-26 | peildatum na tweede dag na A1 in onzekerheidsperiode A3 en in onzekerheidsperiode A2     |
      | 20100516  | 00000000  | 20100500  | 20121014  | 2010-05-26 | peildatum na tweede dag na A1 in onzekerheidsperiode A3 en in onzekerheidsperiode A2     |
      | 20100516  | 20100000  | 20100500  | 20121014  | 2010-05-26 | peildatum na tweede dag na A1 in onzekerheidsperiode A3 en in onzekerheidsperiode A2     |
      | 20100516  | 00000000  | 20100000  | 20121014  | 2011-05-26 | peildatum na tweede dag na A1 in onzekerheidsperiode A3 en na onzekerheidsperiode A2     |
      | 20100516  | 00000000  | 20100500  | 20121014  | 2011-05-26 | peildatum na tweede dag na A1 in onzekerheidsperiode A3 en na onzekerheidsperiode A2     |
      | 20100516  | 20100000  | 20100500  | 20121014  | 2011-05-26 | peildatum na tweede dag na A1 in onzekerheidsperiode A3 en na onzekerheidsperiode A2     |
      # A1         |
      # A2 ????????????????
      # A3    ?????????-------------
      #        ppp:3 (in principe onjuist, maar gevolg van niet recursief terugkijken naar voor-vorige)
      | 20100516  | 00000000  | 20100000  | 20121014  | 2010-01-01 | peildatum ligt voor A1 op eerste dag onzekerheidsperiode A3 en in onzekerheidsperiode A2 |
      | 20100516  | 00000000  | 20100500  | 20121014  | 2010-05-01 | peildatum ligt voor A1 op eerste dag onzekerheidsperiode A3 en in onzekerheidsperiode A2 |
      | 20100516  | 20100000  | 20100500  | 20121014  | 2010-05-01 | peildatum ligt voor A1 op eerste dag onzekerheidsperiode A3 en in onzekerheidsperiode A2 |
      | 20100516  | 00000000  | 20100000  | 20121014  | 2010-05-15 | peildatum ligt voor A1 in onzekerheidsperiode A3 en in onzekerheidsperiode A2            |
      | 20100516  | 00000000  | 20100500  | 20121014  | 2010-05-15 | peildatum ligt voor A1 in onzekerheidsperiode A3 en in onzekerheidsperiode A2            |
      | 20100516  | 20100000  | 20100500  | 20121014  | 2010-05-15 | peildatum ligt voor A1 in onzekerheidsperiode A3 en in onzekerheidsperiode A2            |
      # A1       |
      # A2 ????????????????????????????
      # A3             ???????????
      # A4                   |-------
      #                ppp:3 (datumTot<=A4)
      | 20080918  | 00000000  | 20100000  | 20101014  | 2010-01-01 | peildatum is eerste dag onzekerheidsperiode A3                                           |
      | 20080918  | 00000000  | 20100500  | 20100526  | 2010-05-01 | peildatum is eerste dag onzekerheidsperiode A3                                           |
      | 20080918  | 00000000  | 20100000  | 20101014  | 2010-10-13 | peildatum in onzekerheidsperiode A3 voor A4                                              |
      | 20080918  | 00000000  | 20100500  | 20100526  | 2010-05-25 | peildatum in onzekerheidsperiode A3 voor A4                                              |
      # A1       |-----
      # A2             ????????
      # A3 ?????????????????????????-------------
      #                 ppp:3 (datumVan>A2)
      | 20080918  | 20100000  | 00000000  | 20121014  | 2010-01-02 | peildatum is tweede dag onzekerheidsperiode A2 in A3                                     |
      | 20080918  | 20100500  | 00000000  | 20121014  | 2010-05-02 | peildatum is tweede dag onzekerheidsperiode A2 in A3                                     |
      | 20080918  | 20100500  | 20100000  | 20121014  | 2010-05-02 | peildatum is tweede dag onzekerheidsperiode A2 in A3                                     |
      | 20080918  | 20100000  | 00000000  | 20121014  | 2010-07-30 | peildatum in onzekerheidsperiode A2 in A3                                                |
      | 20080918  | 20100500  | 00000000  | 20121014  | 2010-05-16 | peildatum in onzekerheidsperiode A2 in A3                                                |
      | 20080918  | 20100500  | 20100000  | 20121014  | 2010-05-16 | peildatum in onzekerheidsperiode A2 in A3                                                |
      | 20080918  | 20100000  | 00000000  | 20121014  | 2011-07-30 | peildatum na onzekerheidsperiode A2 in A3                                                |
      | 20080918  | 20100500  | 00000000  | 20121014  | 2010-10-14 | peildatum na onzekerheidsperiode A2 in A3                                                |
      | 20080918  | 20100500  | 20100000  | 20121014  | 2010-10-14 | peildatum na onzekerheidsperiode A2 in A3                                                |
      # A1           |
      # A2      ????????
      # A3 ???????????????????-------------
      #          ppp:3 (in principe onjuist, maar gevolg van niet recursief terugkijken naar voor-vorige)
      | 20100516  | 20100000  | 00000000  | 20121014  | 2010-01-02 | peildatum is tweede dag onzekerheidsperiode A2 in A3 en voor A1                          |
      | 20100516  | 20100500  | 00000000  | 20121014  | 2010-05-02 | peildatum is tweede dag onzekerheidsperiode A2 in A3 en voor A1                          |
      | 20100516  | 20100500  | 20100000  | 20121014  | 2010-05-02 | peildatum is tweede dag onzekerheidsperiode A2 in A3 en voor A1                          |
      | 20100516  | 20100000  | 00000000  | 20121014  | 2010-05-15 | peildatum is dag voor A1                                                                 |
      | 20100516  | 20100500  | 00000000  | 20121014  | 2010-05-15 | peildatum is dag voor A1                                                                 |
      | 20100516  | 20100500  | 20100000  | 20121014  | 2010-05-15 | peildatum is dag voor A1                                                                 |
      # A1         |
      # A2      ????????
      # A3 ???????????????????-------------
      #             ppp:3 (datumVan>A1)
      | 20100516  | 20100000  | 00000000  | 20121014  | 2010-05-18 | peildatum is tweede dag na A1 in onzekerheidsperiode A2 in onzekerheidsperiode A3        |
      | 20100516  | 20100500  | 00000000  | 20121014  | 2010-05-18 | peildatum is tweede dag na A1 in onzekerheidsperiode A2 in onzekerheidsperiode A3        |
      | 20100516  | 20100500  | 20100000  | 20121014  | 2010-05-18 | peildatum is tweede dag na A1 in onzekerheidsperiode A2 in onzekerheidsperiode A3        |
      | 20100516  | 20100000  | 00000000  | 20121014  | 2010-10-14 | peildatum na A1 in onzekerheidsperiode A2 in onzekerheidsperiode A3                      |
      | 20100516  | 20100500  | 00000000  | 20121014  | 2010-05-26 | peildatum na A1 in onzekerheidsperiode A2 in onzekerheidsperiode A3                      |
      | 20100516  | 20100500  | 20100000  | 20121014  | 2010-05-26 | peildatum na A1 in onzekerheidsperiode A2 in onzekerheidsperiode A3                      |
      | 20100516  | 20100000  | 00000000  | 20121014  | 2011-02-19 | peildatum na onzekerheidsperiode A2 in onzekerheidsperiode A3                            |
      | 20100516  | 20100500  | 00000000  | 20121014  | 2010-07-30 | peildatum na onzekerheidsperiode A2 in onzekerheidsperiode A3                            |
      | 20100516  | 20100500  | 20100000  | 20121014  | 2010-07-30 | peildatum na onzekerheidsperiode A2 in onzekerheidsperiode A3                            |
      # A1       |-----
      # A2             ???????????
      # A3 ????????????????????????????-------------
      # A4                   |-------
      #                  ppp:3 (datumVan>A2, datumTot<=A4)
      | 20080918  | 20100000  | 00000000  | 20101014  | 2010-01-02 | peildatum voor A4 in onzekerheidsperiode A2 en A3                                        |
      | 20080918  | 20100500  | 00000000  | 20100526  | 2010-05-02 | peildatum voor A4 in onzekerheidsperiode A2 en A3                                        |
      | 20080918  | 20100500  | 20100000  | 20100526  | 2010-05-02 | peildatum voor A4 in onzekerheidsperiode A2 en A3                                        |
      | 20080918  | 20100000  | 00000000  | 20101014  | 2010-10-13 | peildatum is dag voor A4 in onzekerheidsperiode A2 en A3                                 |
      | 20080918  | 20100500  | 00000000  | 20100526  | 2010-05-25 | peildatum is dag voor A4 in onzekerheidsperiode A2 en A3                                 |
      | 20080918  | 20100500  | 20100000  | 20100526  | 2010-05-25 | peildatum is dag voor A4 in onzekerheidsperiode A2 en A3                                 |
      # A1  |----
      # A2       ???????????????
      # A3       ???????????????-------------
      #           ppp:3 (datumVan>A2)
      | 20080918  | 20100000  | 20100000  | 20121014  | 2010-01-02 | peildatum is tweede dag onzekerheidsperiode A2=A3                                        |
      | 20080918  | 20100500  | 20100500  | 20121014  | 2010-05-02 | peildatum is tweede dag onzekerheidsperiode A2=A3                                        |
      | 20080918  | 20100000  | 20100000  | 20121014  | 2010-10-14 | peildatum in onzekerheidsperiode A2=A3                                                   |
      | 20080918  | 20100500  | 20100500  | 20121014  | 2010-05-02 | peildatum in onzekerheidsperiode A2=A3                                                   |
      | 20080918  | 20100000  | 20100000  | 20121014  | 2011-02-19 | peildatum na onzekerheidsperiode A2=A3                                                   |
      | 20080918  | 20100500  | 20100500  | 20121014  | 2010-07-30 | peildatum na onzekerheidsperiode A2=A3                                                   |
      # A1           |
      # A2     ???????????????
      # A3     ???????????????-------------
      #          ppp:3 (in principe onjuist, maar gevolg van niet recursief terugkijken naar voor-vorige)
      | 20100516  | 00000000  | 00000000  | 20121014  | 1950-01-01 | peildatum in onzekerheidsperiode A2=A3 voor A1                                           |
      | 20100516  | 20100000  | 20100000  | 20121014  | 2010-01-02 | peildatum in onzekerheidsperiode A2=A3 voor A1                                           |
      | 20100516  | 20100500  | 20100500  | 20121014  | 2010-05-02 | peildatum in onzekerheidsperiode A2=A3 voor A1                                           |
      # A1           |
      # A2     ???????????????
      # A3     ???????????????-------------
      #                ppp:3
      | 20100516  | 00000000  | 00000000  | 20121014  | 2010-05-18 | peildatum is twee dagen na A1 in onzekerheidsperiode A2=A3                               |
      | 20100516  | 20100000  | 20100000  | 20121014  | 2010-05-18 | peildatum is twee dagen na A1 in onzekerheidsperiode A2=A3                               |
      | 20100516  | 20100500  | 20100500  | 20121014  | 2010-05-18 | peildatum is twee dagen na A1 in onzekerheidsperiode A2=A3                               |
      | 20100516  | 00000000  | 00000000  | 20121014  | 2011-01-01 | peildatum na A1 in onzekerheidsperiode A2=A3                                             |
      | 20100516  | 20100000  | 20100000  | 20121014  | 2010-10-14 | peildatum na A1 in onzekerheidsperiode A2=A3                                             |
      | 20100516  | 20100500  | 20100500  | 20121014  | 2010-05-26 | peildatum na A1 in onzekerheidsperiode A2=A3                                             |

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
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 000000012             |
      | peildatum           | <peildatum>           |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | adresseerbaarObjectIdentificatie | straat        | datumAanvangAdreshouding | datumAanvangVolgendeAdreshouding |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000004                 | Vierde straat | <aanvang 4>              |                                  |

      Voorbeelden:
      | aanvang 1 | aanvang 2 | aanvang 3 | aanvang 4 | peildatum  | omschrijving                                                           |
      # A1       |
      # A2 ????????????????????????????
      # A3             ???????????
      # A4                   |-------
      #                       ppp:4 (datumVan>=A4)
      | 20080918  | 00000000  | 20100000  | 20100526  | 2010-05-30 | peildatum na A4 in onzekerheidsperiode A3 in onzekerheidsperiode A2    |
      | 20080918  | 00000000  | 20100500  | 20100526  | 2010-05-30 | peildatum na A4 in onzekerheidsperiode A3 in onzekerheidsperiode A2    |
      | 20100219  | 20100000  | 20100500  | 20100526  | 2010-05-30 | peildatum na A4 in onzekerheidsperiode A3 in onzekerheidsperiode A2    |
      | 20080918  | 00000000  | 20100000  | 20100526  | 2010-05-26 | peildatum is A4 in onzekerheidsperiode A3 in onzekerheidsperiode A2    |
      | 20080918  | 00000000  | 20100500  | 20100526  | 2010-05-26 | peildatum is A4 in onzekerheidsperiode A3 in onzekerheidsperiode A2    |
      | 20100219  | 20100000  | 20100500  | 20100526  | 2010-05-26 | peildatum is A4 in onzekerheidsperiode A3 in onzekerheidsperiode A2    |
      # A1       |-----
      # A2             ???????????
      # A3 ????????????????????????????-------------
      # A4                   |-------
      #                       ppp:4 (datumVan>=A4)
      | 20080918  | 20100000  | 00000000  | 20100526  | 2010-05-26 | peildatum is A4 in onzekerheidsperiode A2 in onzekerheidsperiode A3    |
      | 20080918  | 20100500  | 00000000  | 20100526  | 2010-05-26 | peildatum is A4 in onzekerheidsperiode A2 in onzekerheidsperiode A3    |
      | 20080918  | 20100500  | 20100000  | 20100526  | 2010-05-26 | peildatum is A4 in onzekerheidsperiode A2 in onzekerheidsperiode A3    |
      | 20080918  | 20100000  | 00000000  | 20100526  | 2010-05-30 | peildatum na A4 in onzekerheidsperiode A2 in onzekerheidsperiode A3    |
      | 20080918  | 20100500  | 00000000  | 20100526  | 2010-05-30 | peildatum na A4 in onzekerheidsperiode A2 in onzekerheidsperiode A3    |
      | 20080918  | 20100500  | 20100000  | 20100526  | 2010-05-30 | peildatum na A4 in onzekerheidsperiode A2 in onzekerheidsperiode A3    |
      | 20080918  | 20100000  | 00000000  | 20100526  | 2011-02-19 | peildatum na A4 na onzekerheidsperiode A2 in onzekerheidsperiode A3    |
      | 20080918  | 20100500  | 00000000  | 20100526  | 2011-02-19 | peildatum na A4 na onzekerheidsperiode A2 in onzekerheidsperiode A3    |
      | 20080918  | 20100500  | 20100000  | 20100526  | 2011-02-19 | peildatum na A4 na onzekerheidsperiode A2 en na onzekerheidsperiode A3 |

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
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 000000012             |
      | peildatum           | <peildatum>           |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | adresseerbaarObjectIdentificatie | straat        | datumAanvangAdreshouding | datumAanvangVolgendeAdreshouding |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000003                 | Derde straat  | <aanvang 3>              | <aanvang 4>                      |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000001                 | Eerste straat | <aanvang 1>              | <aanvang 2>                      |

      Voorbeelden:
      | aanvang 1 | aanvang 2 | aanvang 3 | aanvang 4 | peildatum  | omschrijving                                                        |
      # A1         |
      # A2 ????????????????
      # A3      ???????-------------
      #            p:1+3 (datumTot=A1+1, A3 wordt geleverd als gevolg van niet recursief terugkijken naar voor-vorige van A3)
      | 20100516  | 00000000  | 20100000  | 20121014  | 2010-05-16 | peildatum is A1 in onzekerheidsperiode A3 in onzekerheidsperiode A2 |
      | 20100516  | 00000000  | 20100500  | 20121014  | 2010-05-16 | peildatum is A1 in onzekerheidsperiode A3 in onzekerheidsperiode A2 |
      | 20100516  | 20100000  | 20100500  | 20121014  | 2010-05-16 | peildatum is A1 in onzekerheidsperiode A3 in onzekerheidsperiode A2 |
      # A1         |
      # A2      ????????
      # A3 ???????????????????-------------
      #            p:1+3 (in principe onjuist, A3 wordt geleverd als gevolg van niet recursief terugkijken naar voor-vorige van A3)
      | 20100516  | 20100000  | 00000000  | 20121014  | 2010-05-16 | peildatum is A1 in onzekerheidsperiode A2 in onzekerheidsperiode A3 |
      | 20100516  | 20100500  | 00000000  | 20121014  | 2010-05-16 | peildatum is A1 in onzekerheidsperiode A2 in onzekerheidsperiode A3 |
      | 20100516  | 20100500  | 20100000  | 20121014  | 2010-05-16 | peildatum is A1 in onzekerheidsperiode A2 in onzekerheidsperiode A3 |
