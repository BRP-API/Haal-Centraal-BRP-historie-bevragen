# language: nl

@gba
Functionaliteit: RNI-deelnemer gegevens leveren voor verblijfplaatshistorie met periode

    Achtergrond:
      #Gegeven landelijke tabel "RNI-deelnemerstabel" heeft de volgende waarden
      #| code | omschrijving                                                       |
      #| 0101 | Belastingdienst (inzake heffingen en toeslagen)                    |
      #| 0201 | Sociale Verzekeringsbank (inzake AOW, Anw en AKW)                  |
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | straatnaam (11.10) | huisnummer (11.20) | postcode (11.60) |
      | 0800                 | Teststraat         | 1                  | 1234AB           |
      En de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20021014                           |
      En de persoon is vervolgens ingeschreven op een buitenlands adres met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adres buitenland (13.20) | land adres buitenland (13.10) | regel 1 adres buitenland (13.30) | rni-deelnemer (88.10) | omschrijving verdrag (88.20)         |
      | 1999                              | 20070516                               | 6014                          | Die Straße                       | 0201                  | Artikel 45 EU-Werkingsverdrag (VWEU) |
      En de persoon is vervolgens ingeschreven op een buitenlands adres met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adres buitenland (13.20) | land adres buitenland (13.10) | rni-deelnemer (88.10) | omschrijving verdrag (88.20) |
      | 1999                              | 20230210                               | 0000                          | 0101                  | Belastingverdrag             |


  Rule: RNI-deelnemer gegevens op een geleverde verblijfplaats worden geleverd

    Scenario: In de periode heeft de persoon verblijfplaats buitenland met RNI-deelnemer gegevens 
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2022-01-01          |
      | datumTot            | 2023-01-01          |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | land.code | land.omschrijving            | regel1     | datumAanvangAdresBuitenland | datumAanvangVolgendeAdresBuitenland | rni.deelnemer.code | rni.deelnemer.omschrijving                        | rni.omschrijvingVerdrag              |
      | 1999                         | Registratie Niet Ingezetenen (RNI)   | 6014      | Verenigde Staten van Amerika | Die Straße | 20070516                    | 20230210                            | 0201               | Sociale Verzekeringsbank (inzake AOW, Anw en AKW) | Artikel 45 EU-Werkingsverdrag (VWEU) |
      
    Scenario: In de periode heeft de persoon onbekende verblijfplaats met RNI-deelnemer gegevens 
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2024-01-01          |
      | datumTot            | 2024-02-01          |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | land.code | land.omschrijving | datumAanvangAdresBuitenland | rni.deelnemer.code | rni.deelnemer.omschrijving                      | rni.omschrijvingVerdrag |
      | 1999                         | Registratie Niet Ingezetenen (RNI)   | 0000      | Onbekend          | 20230210                    | 0101               | Belastingdienst (inzake heffingen en toeslagen) | Belastingverdrag        |

    Scenario: In de periode heeft de persoon adres in Nederland en volgende verblijfplaats buitenland met RNI-deelnemer gegevens
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2005-01-01          |
      | datumTot            | 2006-01-01          |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | datumAanvangAdreshouding | straat     | huisnummer | postcode | datumAanvangVolgendeAdresBuitenland |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 20021014                 | Teststraat | 1          | 1234AB   | 20070516                            |

    Scenario: In de periode heeft de persoon meerdere verblijfplaatsen met RNI-deelnemer gegevens
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2005-01-01          |
      | datumTot            | 2024-01-01          |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | datumAanvangAdreshouding | datumAanvangAdresBuitenland | datumAanvangVolgendeAdresBuitenland | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | land.code | land.omschrijving            | regel1     | straat     | huisnummer | postcode | rni.deelnemer.code | rni.deelnemer.omschrijving                        | rni.omschrijvingVerdrag              |
      |                          | 20230210                    |                                     | 1999                         | Registratie Niet Ingezetenen (RNI)   | 0000      | Onbekend                     |            |            |            |          | 0101               | Belastingdienst (inzake heffingen en toeslagen)   | Belastingverdrag                     |
      |                          | 20070516                    | 20230210                            | 1999                         | Registratie Niet Ingezetenen (RNI)   | 6014      | Verenigde Staten van Amerika | Die Straße |            |            |          | 0201               | Sociale Verzekeringsbank (inzake AOW, Anw en AKW) | Artikel 45 EU-Werkingsverdrag (VWEU) |
      | 20021014                 |                             | 20070516                            | 0800                         | Hoogeloon, Hapert en Casteren        |           |                              |            | Teststraat | 1          | 1234AB   |                    |                                                   |                                      |
