#language: nl

@gba
Functionaliteit: test dat bij verblijfplaatshistorie met peildatum een gecorrigeerde historische verblijfplaats volledig wordt genegeerd

  
    Achtergrond:
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | straatnaam (11.10) |
      | 0800                 | De Eerste straat   |
      En adres 'A2' heeft de volgende gegevens
      | gemeentecode (92.10) | straatnaam (11.10) |
      | 0800                 | Het Tweede adres   |

  Rule: gecorrigeerde gegevens worden niet gebruikt

    Abstract Scenario: datum aanvang adreshouding is gecorrigeerd en de gevraagde peildatum ligt vóór de correcte datum maar na de onjuiste datum aanvang
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20160516                           |
      En de 'verblijfplaats' is gecorrigeerd naar de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20160601                           |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 000000012             |
      | peildatum           | <peildatum>           |
      Dan heeft de response 0 verblijfplaatsen

      Voorbeelden:
      | peildatum  |
      | 2016-05-16 |
      | 2016-05-31 |

    Abstract Scenario: datum aanvang adreshouding is gecorrigeerd en de gevraagde peildatum ligt na de correcte datum maar vóór de onjuiste datum aanvang
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20160601                           |
      En de 'verblijfplaats' is gecorrigeerd naar de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20160516                           |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 000000012             |
      | peildatum           | <peildatum>           |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | datumAanvangAdreshouding | straat           |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 20160516                 | De Eerste straat |

      Voorbeelden:
      | peildatum  |
      | 2016-05-16 |
      | 2016-05-26 |
      | 2016-05-31 |

    Abstract Scenario: datum aanvang volgende adreshouding is gecorrigeerd en de gevraagde peildatum begint na de correcte datum maar vóór de onjuiste datum aanvang volgende adreshouding
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
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 000000012             |
      | peildatum           | <peildatum>           |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | datumAanvangAdreshouding | straat           |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 20160516                 | Het Tweede adres |
      
      Voorbeelden:
      | peildatum  |
      | 2016-05-16 |
      | 2016-05-26 |
      | 2016-05-31 |

    Abstract Scenario: datum aanvang volgende adreshouding is gecorrigeerd en de gevraagde peildatum ligt vóór de correcte datum maar na de onjuiste datum aanvang volgende adreshouding
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
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 000000012             |
      | peildatum           | <peildatum>           |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | datumAanvangAdreshouding | datumAanvangVolgendeAdreshouding | straat           |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 20100818                 | 20160601                         | De Eerste straat |

      Voorbeelden:
      | peildatum  |
      | 2016-05-16 |
      | 2016-05-26 |
      | 2016-05-31 |

    Abstract Scenario: verblijf met onbekende aanvang adreshouding en gecorrigeerde datum aanvang vorige in de onzekerheidsperiode en de gevraagde peildatum ligt voor de correcte datum maar na de onjuiste datum aanvang vorige adreshouding
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
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 000000012             |
      | peildatum           | <peildatum>           |
      Dan heeft de response 0 verblijfplaatsen

      Voorbeelden:
      | peildatum  |
      | 2016-05-16 |
      | 2016-05-26 |
      | 2016-05-31 |

    Abstract Scenario: verblijf met onbekende aanvang adreshouding en gecorrigeerde datum aanvang vorige in de onzekerheidsperiode en de gevraagde peildatum ligt na de correcte datum maar voor de onjuiste datum aanvang vorige adreshouding
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
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 000000012             |
      | peildatum           | <peildatum>           |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | datumAanvangAdreshouding | straat           |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 20160000                 | Het Tweede adres |

      Voorbeelden:
      | peildatum  |
      | 2016-05-17 |
      | 2016-05-26 |
      | 2016-05-31 |
