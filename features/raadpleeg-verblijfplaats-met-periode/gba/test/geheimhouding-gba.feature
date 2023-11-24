#language: nl

@gba
Functionaliteit: test voor raadplegen historie met periode dat geheimhoudingPersoonsgegevens correct wordt geleverd

    Achtergrond:
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | straatnaam (11.10) |
      | 0800                 | Korte straatnaam   |
      En de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20220801                           |

  Rule: indicatie geheim waarde 0 wordt niet geleverd

    Scenario: historie wordt gevraagd op burgerservicenummer met geheimhouding 0
      Gegeven de persoon heeft de volgende 'inschrijving' gegevens
      | naam                     | waarde |
      | indicatie geheim (70.10) | 0      |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2022-01-01          |
      | datumTot            | 2023-01-01          |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | datumAanvangAdreshouding | straat           |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 20220801                 | Korte straatnaam |

  Rule: indicatie geheim met waarde hoger dan 0 wordt ongevraagd meegeleverd

    Scenario: historie wordt gevraagd op burgerservicenummer met geheimhouding <geheimhouding persoonsgegevens>
      Gegeven de persoon heeft de volgende 'inschrijving' gegevens
      | naam                     | waarde                           |
      | indicatie geheim (70.10) | <geheimhouding persoonsgegevens> |
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
      | naam                          | waarde                           |
      | geheimhoudingPersoonsgegevens | <geheimhouding persoonsgegevens> |

      Voorbeelden:
      | geheimhouding persoonsgegevens |
      | 1                              |
      | 2                              |
      | 3                              |
      | 4                              |
      | 5                              |
      | 6                              |
      | 7                              |
