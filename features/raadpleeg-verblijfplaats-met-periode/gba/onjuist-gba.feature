#language: nl

@gba
Functionaliteit: verblijfplaatshistorie met periode negeert onjuiste en inmiddels gecorrigeerde historische verblijfplaatsvoorkomens volledig

  
    Achtergrond:
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | straatnaam (11.10) |
      | 0800                 | De Eerste straat   |
      En adres 'A2' heeft de volgende gegevens
      | gemeentecode (92.10) | straatnaam (11.10) |
      | 0800                 | Het Tweede adres   |


  Rule: gecorrigeerde gegevens worden niet gebruikt

    Scenario: datum aanvang adreshouding is gecorrigeerd en de gevraagde periode eindigt vóór de correcte datum maar na de onjuiste datum aanvang
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20160516                           |
      En de 'verblijfplaats' is gecorrigeerd naar de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20160601                           |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2016-05-01          |
      | datumTot            | 2016-06-01          |
      Dan heeft de response 0 verblijfplaatsen

    Scenario: datum aanvang adreshouding is gecorrigeerd en de gevraagde periode eindigt na de correcte datum maar vóór de onjuiste datum aanvang
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20160601                           |
      En de 'verblijfplaats' is gecorrigeerd naar de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20160516                           |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2016-05-01          |
      | datumTot            | 2016-05-28          |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | datumAanvangAdreshouding | straat           |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 20160516                 | De Eerste straat |

    Scenario: datum aanvang volgende adreshouding is gecorrigeerd en de gevraagde periode begint na de correcte datum maar vóór de onjuiste datum aanvang volgende adreshouding
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20100818                           |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20160601                           |
      En de 'verblijfplaats' is gecorrigeerd naar de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20160516                           |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2016-05-18          |
      | datumTot            | 2016-05-28          |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | datumAanvangAdreshouding | straat           |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 20160516                 | Het Tweede adres |

    Scenario: datum aanvang volgende adreshouding is gecorrigeerd en de gevraagde periode eindigt vóór de correcte datum maar na de onjuiste datum aanvang volgende adreshouding
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20100818                           |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20160516                           |
      En de 'verblijfplaats' is gecorrigeerd naar de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20160601                           |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2016-01-01          |
      | datumTot            | 2016-05-28          |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | datumAanvangAdreshouding | datumAanvangVolgendeAdreshouding | straat           |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 20100818                 | 20160601                         | De Eerste straat |

    Abstract Scenario: verblijf met onbekende aanvang adreshouding en gecorrigeerde datum aanvang vorige in de onzekerheidsperiode en de gevraagde periode eindigt voor de correcte datum maar na de onjuiste datum aanvang vorige adreshouding
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20160516                           |
      En de 'verblijfplaats' is gecorrigeerd naar de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20160601                           |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20160000                           |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2016-04-30          |
      | datumTot            | 2016-05-30          |
      Dan heeft de response 0 verblijfplaatsen

    Abstract Scenario: verblijf met onbekende aanvang adreshouding en gecorrigeerde datum aanvang vorige in de onzekerheidsperiode en de gevraagde periode ligt na de correcte datum maar voor de onjuiste datum aanvang vorige adreshouding
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20160601                           |
      En de 'verblijfplaats' is gecorrigeerd naar de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20160516                           |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20160000                           |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2016-05-18          |
      | datumTot            | 2016-05-28          |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | datumAanvangAdreshouding | straat           |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 20160000                 | Het Tweede adres |
