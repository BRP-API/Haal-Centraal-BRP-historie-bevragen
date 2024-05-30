#language: nl

Functionaliteit: test voor raadplegen historie met peildatum dat opschorting bijhouding correct wordt geleverd

    Achtergrond:
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | straatnaam (11.10) |
      | 0800                 | Korte straatnaam   |

  Rule: Voor een persoon op een logisch verwijderde persoonslijst wordt geen verblijfplaatshistorie geleverd
    Een persoonslijst is logisch verwijderd wanneer reden opschorting bijhouding is gelijk aan "W" (wissen)

    Abstract Scenario: Gevraagde persoon heeft een logisch verwijderde persoonslijst en <sub scenario>
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20100818                           |
      En de persoon heeft de volgende 'inschrijving' gegevens
      | reden opschorting bijhouding (67.20) | datum opschorting bijhouding (67.10) |
      | W                                    | <datum opschorting bijhouding>       |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 000000024             |
      | peildatum           | 2016-07-31            |
      Dan heeft de response geen verblijfplaatsen

      Voorbeelden:
      | datum opschorting bijhouding | sub scenario                                           |
      | 20150401                     | datum opschorting ligt vóór de gevraagde peildatum     |
      | 20160731                     | datum opschorting is gelijk aan de gevraagde peildatum |
      | 20220829                     | datum opschorting ligt na de gevraagde peildatum       |

    Scenario: Gevraagde persoon heeft een logisch verwijderde persoonslijst en met zelfde burgerservicenummer een actuele persoonslijst
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20100818                           |
      En de persoon heeft de volgende 'inschrijving' gegevens
      | reden opschorting bijhouding (67.20) | datum opschorting bijhouding (67.10) |
      | W                                    | 20100823                             |
      En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20100818                           |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 000000024             |
      | peildatum           | 2024-01-01            |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | straat | adresseerbaarObjectIdentificatie | datumAanvangAdreshouding | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving |
      | Laan   | 0800010000000001                 | 20100818                 | 0800                         | Hoogeloon, Hapert en Casteren        |


  Rule: Voor een persoon met afgevoerde persoonslijst wordt geen verblijfplaatshistorie geleverd
    Een persoonslijst is afgevoerd wanneer reden opschorting bijhouding is gelijk aan "F" (fout)

    Abstract Scenario: Gevraagde persoon heeft een afgevoerde persoonslijst en <sub scenario>
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20100818                           |
      En de persoon heeft de volgende 'inschrijving' gegevens
      | reden opschorting bijhouding (67.20) | datum opschorting bijhouding (67.10) |
      | F                                    | <datum opschorting bijhouding>       |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 000000024             |
      | peildatum           | 2016-07-31            |
      Dan heeft de response geen verblijfplaatsen

      Voorbeelden:
      | datum opschorting bijhouding | sub scenario                                           |
      | 20150401                     | datum opschorting ligt vóór de gevraagde peildatum     |
      | 20160731                     | datum opschorting is gelijk aan de gevraagde peildatum |
      | 20220829                     | datum opschorting ligt na de gevraagde peildatum       |

    Scenario: Gevraagde persoon heeft een afgevoerde persoonslijst en met zelfde burgerservicenummer een actuele persoonslijst
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20100818                           |
      En de persoon heeft de volgende 'inschrijving' gegevens
      | reden opschorting bijhouding (67.20) | datum opschorting bijhouding (67.10) |
      | F                                    | 20100823                             |
      En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20100818                           |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 000000024             |
      | peildatum           | 2024-01-01            |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | straat | adresseerbaarObjectIdentificatie | datumAanvangAdreshouding | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving |
      | Laan   | 0800010000000001                 | 20100818                 | 0800                         | Hoogeloon, Hapert en Casteren        |

  
  Rule: opschortingBijhouding wordt geleverd

    Abstract Scenario: historie wordt gevraagd van persoon waarvoor de bijhouding is opgeschort
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20220801                           |
      En de persoon heeft de volgende 'inschrijving' gegevens
      | naam                                 | waarde                         |
      | reden opschorting bijhouding (67.20) | <reden opschorting bijhouding> |
      | datum opschorting bijhouding (67.10) | 20220829                       |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 000000012             |
      | peildatum           | 2022-08-15            |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | datumAanvangAdreshouding | straat           |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 20220801                 | Korte straatnaam |
      En heeft de response de volgende gegevens
      | naam                                     | waarde                           |
      | opschortingBijhouding.reden.code         | <reden opschorting bijhouding>   |
      | opschortingBijhouding.reden.omschrijving | <reden opschorting omschrijving> |
      | opschortingBijhouding.datum              | 20220829                         |

      Voorbeelden:
      | reden opschorting bijhouding | reden opschorting omschrijving |
      | O                            | overlijden                     |
      | E                            | emigratie                      |
      | M                            | ministerieel besluit           |
      | R                            | pl is aangelegd in de rni      |
      | .                            | onbekend                       |

    Abstract Scenario: historie wordt gevraagd van persoon waarvoor de bijhouding is opgeschort met peildatum <omschrijving> datum opschorting (overlijden)
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20160801                           |
      En de persoon heeft de volgende 'inschrijving' gegevens
      | naam                                 | waarde   |
      | reden opschorting bijhouding (67.20) | O        |
      | datum opschorting bijhouding (67.10) | 20220829 |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 000000012             |
      | peildatum           | <peildatum>           |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | datumAanvangAdreshouding | straat           |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 20160801                 | Korte straatnaam |
      En heeft de response de volgende gegevens
      | naam                                     | waarde     |
      | opschortingBijhouding.reden.code         | O          |
      | opschortingBijhouding.reden.omschrijving | overlijden |
      | opschortingBijhouding.datum              | 20220829   |

      Voorbeelden:
      | omschrijving | peildatum  |
      | voor         | 2020-01-01 |
      | gelijk aan   | 2022-08-29 |
      | na           | 2023-01-01 |

    Abstract Scenario: historie wordt gevraagd van persoon waarvoor de bijhouding is opgeschort voor peildatum waarop geen verblijfplaats wordt gevonden
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20220801                           |
      En de persoon heeft de volgende 'inschrijving' gegevens
      | naam                                 | waarde                         |
      | reden opschorting bijhouding (67.20) | <reden opschorting bijhouding> |
      | datum opschorting bijhouding (67.10) | 20220829                       |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 000000012             |
      | peildatum           | 2022-07-01            |
      Dan heeft de response 0 verblijfplaatsen
      En heeft de response de volgende gegevens
      | naam                                     | waarde                           |
      | opschortingBijhouding.reden.code         | <reden opschorting bijhouding>   |
      | opschortingBijhouding.reden.omschrijving | <reden opschorting omschrijving> |
      | opschortingBijhouding.datum              | 20220829                         |

      Voorbeelden:
      | reden opschorting bijhouding | reden opschorting omschrijving |
      | O                            | overlijden                     |
      | E                            | emigratie                      |
      | M                            | ministerieel besluit           |
      | R                            | pl is aangelegd in de rni      | 
      | .                            | onbekend                       |
