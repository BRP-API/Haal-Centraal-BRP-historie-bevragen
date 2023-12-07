#language: nl

Functionaliteit: test voor raadplegen historie met periode dat opschorting bijhouding correct wordt geleverd

    Achtergrond:
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | straatnaam (11.10) |
      | 0800                 | Korte straatnaam   |

  Rule: Een persoonslijst met reden opschorting bijhouding "W" (wissen) wordt niet geleverd

    @fout-case
    Scenario: historie wordt gevraagd op burgerservicenummer van gewiste persoonslijst
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20220801                           |
      En de persoon heeft de volgende 'inschrijving' gegevens
      | naam                                 | waarde   |
      | reden opschorting bijhouding (67.20) | W        |
      | datum opschorting bijhouding (67.10) | 20220829 |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2022-01-01          |
      | datumTot            | 2023-01-01          |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                         |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.4    |
      | title    | Opgevraagde resource bestaat niet.                             |
      | status   | 404                                                            |
      | detail   | De persoon met burgerservicenummer 000000012 is niet gevonden. |
      | code     | notFound                                                       |
      | instance | /haalcentraal/api/brphistorie/verblijfplaatshistorie           |

  Rule: bij het raadplegen van een persoon met afgevoerde persoonslijst wordt alleen de reden en datum opschorting geleverd
    Overige gegevens op de afgevoerde persoonslijst worden niet geleverd

    Abstract Scenario: historie wordt gevraagd van persoon waarvoor de bijhouding is opgeschort met reden "F" (fout)
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20220801                           |
      En de persoon heeft de volgende 'inschrijving' gegevens
      | naam                                 | waarde   |
      | reden opschorting bijhouding (67.20) | F        |
      | datum opschorting bijhouding (67.10) | 20220829 |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | <datum van>         |
      | datumTot            | <datum tot>         |
      Dan heeft de response 0 verblijfplaatsen
      En heeft de response de volgende gegevens
      | naam                                     | waarde   |
      | opschortingBijhouding.reden.code         | F        |
      | opschortingBijhouding.reden.omschrijving | fout     |
      | opschortingBijhouding.datum              | 20220829 |

      Voorbeelden:
      | omschrijving                   | datum van  | datum tot  |
      | voor datum opschorting         | 2022-08-01 | 2022-08-11 |
      | na datum opschorting           | 2022-09-01 | 2022-10-01 |
      | overlapt met datum opschorting | 2022-08-01 | 2022-10-01 |

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
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2022-01-01          |
      | datumTot            | 2023-01-01          |
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

    Abstract Scenario: historie wordt gevraagd van persoon waarvoor de bijhouding is opgeschort met periode <omschrijving> opschorting (overlijden)
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20160801                           |
      En de persoon heeft de volgende 'inschrijving' gegevens
      | naam                                 | waarde   |
      | reden opschorting bijhouding (67.20) | O        |
      | datum opschorting bijhouding (67.10) | 20220829 |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | <datum van>         |
      | datumTot            | <datum tot>         |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | datumAanvangAdreshouding | straat           |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 20160801                 | Korte straatnaam |
      En heeft de response de volgende gegevens
      | naam                                     | waarde     |
      | opschortingBijhouding.reden.code         | O          |
      | opschortingBijhouding.reden.omschrijving | overlijden |
      | opschortingBijhouding.datum              | 20220829   |

      Voorbeelden:
      | omschrijving | datum van  | datum tot  |
      | voor         | 2020-01-01 | 2021-01-01 |
      | overlapt     | 2022-01-01 | 2023-01-01 |
      | na           | 2023-01-01 | 2023-07-01 |

    Abstract Scenario: historie wordt gevraagd van persoon waarvoor de bijhouding is opgeschort voor periode waarin geen verblijfplaats wordt gevonden
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20220801                           |
      En de persoon heeft de volgende 'inschrijving' gegevens
      | naam                                 | waarde                         |
      | reden opschorting bijhouding (67.20) | <reden opschorting bijhouding> |
      | datum opschorting bijhouding (67.10) | 20220829                       |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2021-01-01          |
      | datumTot            | 2022-01-01          |
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

    Scenario: historie wordt gevraagd met exclusiefVerblijfplaatsBuitenland van persoon waarvoor de bijhouding is opgeschort (emigratie >> RNI) over periode van verblijf buitenland
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20160801                           |
      En de persoon is vervolgens ingeschreven op een buitenlands adres met de volgende gegevens
      | datum aanvang adres buitenland (13.20) | land adres buitenland (13.10) |
      | 20221201                               | 6014                          |
      En de persoon heeft de volgende 'inschrijving' gegevens
      | naam                                 | waarde   |
      | reden opschorting bijhouding (67.20) | R        |
      | datum opschorting bijhouding (67.10) | 20230219 |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                              | waarde              |
      | type                              | RaadpleegMetPeriode |
      | burgerservicenummer               | 000000012           |
      | datumVan                          | 2023-01-01          |
      | datumTot                          | 2023-07-01          |
      | exclusiefVerblijfplaatsBuitenland | true                |
      Dan heeft de response 0 verblijfplaatsen
      En heeft de response de volgende gegevens
      | naam                                     | waarde                    |
      | opschortingBijhouding.reden.code         | R                         |
      | opschortingBijhouding.reden.omschrijving | pl is aangelegd in de rni |
      | opschortingBijhouding.datum              | 20230219                  |

    Scenario: historie wordt gevraagd met exclusiefVerblijfplaatsBuitenland van persoon waarvoor de bijhouding is opgeschort (emigratie >> RNI) over periode voor vertrek
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20160801                           |
      En de persoon is vervolgens ingeschreven op een buitenlands adres met de volgende gegevens
      | datum aanvang adres buitenland (13.20) | land adres buitenland (13.10) |
      | 20221201                               | 6014                          |
      En de persoon heeft de volgende 'inschrijving' gegevens
      | naam                                 | waarde   |
      | reden opschorting bijhouding (67.20) | R        |
      | datum opschorting bijhouding (67.10) | 20230219 |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                              | waarde              |
      | type                              | RaadpleegMetPeriode |
      | burgerservicenummer               | 000000012           |
      | datumVan                          | 2021-01-01          |
      | datumTot                          | 2022-01-01          |
      | exclusiefVerblijfplaatsBuitenland | true                |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | datumAanvangAdreshouding | datumAanvangVolgendeAdresBuitenland | straat           |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 20160801                 | 20221201                            | Korte straatnaam |
      En heeft de response de volgende gegevens
      | naam                                     | waarde                    |
      | opschortingBijhouding.reden.code         | R                         |
      | opschortingBijhouding.reden.omschrijving | pl is aangelegd in de rni |
      | opschortingBijhouding.datum              | 20230219                  |
