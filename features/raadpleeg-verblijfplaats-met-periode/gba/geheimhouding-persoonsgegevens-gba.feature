#language: nl

@gba
Functionaliteit: raadplegen verblijfplaatshistorie met periode levert geheimhoudingPersoonsgegevens


  Rule: Indicatie geheim met waarde hoger dan 0 wordt altijd meegeleverd

    Abstract Scenario: gevraagde persoon heeft indicatie geheim met waarde <indicatie geheim>
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0800                 | 0800010000000001                         |
      En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20100818                           |
      En de persoon heeft de volgende 'inschrijving' gegevens
      | indicatie geheim (70.10) |
      | <indicatie geheim>       |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000024           |
      | datumVan            | 2010-07-01          |
      | datumTot            | 2020-07-01          |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | datumAanvangAdreshouding | adresseerbaarObjectIdentificatie | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving |
      | 20100818                 | 0800010000000001                 | 0800                         | Hoogeloon, Hapert en Casteren        |
      En heeft de response de volgende gegevens
      | geheimhoudingPersoonsgegevens |
      | <indicatie geheim>            |

      Voorbeelden:
      | indicatie geheim |
      | 1                |
      | 2                |
      | 3                |
      | 4                |
      | 5                |
      | 6                |
      | 7                |

    Abstract Scenario: gevraagde persoon heeft indicatie geheim met waarde <indicatie geheim> en afnemer vraag periode waarin geen verblijfplaats wordt gevonden
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0800                 | 0800010000000001                         |
      En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20230818                           |
      En de persoon heeft de volgende 'inschrijving' gegevens
      | indicatie geheim (70.10) |
      | <indicatie geheim>       |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000024           |
      | datumVan            | 2021-01-01          |
      | datumTot            | 2023-07-01          |
      Dan heeft de response 0 verblijfplaatsen
      En heeft de response de volgende gegevens
      | geheimhoudingPersoonsgegevens |
      | <indicatie geheim>            |

      Voorbeelden:
      | indicatie geheim |
      | 1                |
      | 2                |
      | 3                |
      | 4                |
      | 5                |
      | 6                |
      | 7                |

    Scenario: indicatie geheim met waarde 0 wordt niet geleverd
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0800                 | 0800010000000001                         |
      En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20100818                           |
      En de persoon heeft de volgende 'inschrijving' gegevens
      | indicatie geheim (70.10) |
      | 0                        |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000024           |
      | datumVan            | 2010-07-01          |
      | datumTot            | 2020-07-01          |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | datumAanvangAdreshouding | adresseerbaarObjectIdentificatie | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving |
      | 20100818                 | 0800010000000001                 | 0800                         | Hoogeloon, Hapert en Casteren        |
