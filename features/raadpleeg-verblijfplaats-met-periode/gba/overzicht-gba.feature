#language: nl

@gba
Functionaliteit: raadpleeg verblijfplaats in periode

  Als consumer van de Historie bevragen API
  wil ik kunnen raadplegen op welke adresseerbare objecten een persoon in een periode heeft verbleven
  zodat ik deze informatie kan gebruiken in mijn proces

  Achtergrond:
    Gegeven adres 'A1' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | straatnaam (11.10) |
    | 0800                 | 0800010000000001                         | Laan               |
    En adres 'A2' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | straatnaam (11.10) |
    | 0800                 | 0800010000000002                         | Luttestraat        |
    En adres 'A3' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
    | 0800                 | 0800010000000003                         |
    En adres 'A4' heeft de volgende gegevens
    | gemeentecode (92.10) | locatiebeschrijving (12.10) |
    | 0800                 | Woonboot bij de Grote Sloot |

Rule: De gevraagde velden van een verblijfplaats van een persoon met bekend datum aanvang adreshouding/adres buitenland worden geleverd als de adreshoudingperiode van de verblijfplaats in de gevraagde periode ligt of als de gevraagde periode de adreshoudingperiode geheel/deels overlapt

  De verblijfplaatsen worden aflopend gesorteerd geleverd. De eerste verblijfplaats in de verblijfplaatsen lijst is de meest recente verblijfplaats in de gevraagde periode.
  Komt er in de gevraagde periode alleen verblijfplaatsen met bekend datum aanvang adreshouding/adres buitenland voor, dan is de sortering gelijk aan het aflopend sorteren op datum aanvang adreshouding/adres buitenland.

  Abstract Scenario: <scenario> (geen vorige en geen volgende adreshoudingperiode)
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100818                           |
    Als gba verblijfplaatsen wordt gezocht met met de volgende parameters
    | naam                | waarde              |
    | type                | RaadpleegMetPeriode |
    | burgerservicenummer | 000000024           |
    | datumVan            | <datum van>         |
    | datumTot            | 2011-09-01          |
    | fields              | verblijfplaats      |
    Dan heeft de response verblijfplaatsen met de volgende gegevens
    | adresseerbaarObjectIdentificatie | straat | datumVan | datumTot |
    | 0800010000000001                 | Laan   | 20100818 |          |

    Voorbeelden:
    | datum van  | scenario                                                                              |
    | 2010-09-01 | De gevraagde periode ligt in de adreshoudingperiode op een adresseerbaar object       |
    | 2010-08-01 | De gevraagde periode ligt deels in de adreshoudingperiode op een adresseerbaar object |

  Scenario: De gevraagde periode ligt in de adreshoudingperiode op een adresseerbaar object (wel vorige en geen volgende adreshoudingperiode)
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100818                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20160526                           |
    Als gba verblijfplaatsen wordt gezocht met met de volgende parameters
    | naam                | waarde              |
    | type                | RaadpleegMetPeriode |
    | burgerservicenummer | 000000024           |
    | datumVan            | 2016-09-01          |
    | datumTot            | 2020-01-01          |
    | fields              | verblijfplaats      |
    Dan heeft de response verblijfplaatsen met de volgende gegevens
    | adresseerbaarObjectIdentificatie | straat      | datumVan | datumTot |
    | 0800010000000002                 | Luttestraat | 20160526 |          |

  Scenario: De gevraagde periode ligt in de adreshoudingperiode op een adresseerbaar object (geen vorige en wel volgende adreshoudingperiode)
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100818                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20160526                           |
    Als gba verblijfplaatsen wordt gezocht met met de volgende parameters
    | naam                | waarde              |
    | type                | RaadpleegMetPeriode |
    | burgerservicenummer | 000000024           |
    | datumVan            | 2011-01-01          |
    | datumTot            | 2016-01-01          |
    | fields              | verblijfplaats      |
    Dan heeft de response verblijfplaatsen met de volgende gegevens
    | adresseerbaarObjectIdentificatie | straat | datumVan | datumTot |
    | 0800010000000001                 | Laan   | 20100818 | 20160526 |

  Scenario: De gevraagde periode ligt in de adreshoudingperiode op een adresseerbaar object (wel vorige en wel volgende adreshoudingperiode)
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100818                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20160526                           |
    En de persoon is vervolgens ingeschreven op adres 'A3' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20201008                           |
    Als gba verblijfplaatsen wordt gezocht met met de volgende parameters
    | naam                | waarde              |
    | type                | RaadpleegMetPeriode |
    | burgerservicenummer | 000000024           |
    | datumVan            | 2016-10-01          |
    | datumTot            | 2020-07-01          |
    | fields              | verblijfplaats      |
    Dan heeft de response verblijfplaatsen met de volgende gegevens
    | adresseerbaarObjectIdentificatie | straat      | datumVan | datumTot |
    | 0800010000000002                 | Luttestraat | 20160526 | 20201008 |

  Scenario: De gevraagde periode ligt in de adreshoudingperiode op een locatie
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A4' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100818                           |
    En de persoon is vervolgens ingeschreven op adres 'A3' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20201008                           |
    Als gba verblijfplaatsen wordt gezocht met met de volgende parameters
    | naam                | waarde              |
    | type                | RaadpleegMetPeriode |
    | burgerservicenummer | 000000024           |
    | datumVan            | 2016-10-01          |
    | datumTot            | 2020-07-01          |
    | fields              | verblijfplaats      |
    Dan heeft de response verblijfplaatsen met de volgende gegevens
    | locatiebeschrijving         | datumVan | datumTot |
    | Woonboot bij de Grote Sloot | 20100818 | 20201008 |

  Scenario: De gevraagde periode ligt in de adreshoudingperiode op een buitenlands adres
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100818                           |
    En de persoon is vervolgens ingeschreven op een buitenlands adres met de volgende gegevens
    | datum aanvang adres buitenland (13.20) | land adres buitenland (13.10) |
    | 20181201                               | 6014                          |
    Als gba verblijfplaatsen wordt gezocht met met de volgende parameters
    | naam                | waarde              |
    | type                | RaadpleegMetPeriode |
    | burgerservicenummer | 000000024           |
    | datumVan            | 2019-10-01          |
    | datumTot            | 2020-07-01          |
    | fields              | verblijfplaats      |
    Dan heeft de response verblijfplaatsen met de volgende gegevens
    | land.code | land.omschrijving            | datumVan | datumTot |
    | 6014      | Verenigde Staten van Amerika | 20181201 |          |

  Scenario: De gevraagde periode overlapt meerdere adreshoudingperiodes
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100818                           |
    En de persoon is vervolgens ingeschreven op adres 'A4' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20160526                           |
    En de persoon is vervolgens ingeschreven op een buitenlands adres met de volgende gegevens
    | datum aanvang adres buitenland (13.20) | land adres buitenland (13.10) |
    | 20181201                               | 6014                          |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20200415                           |
    Als gba verblijfplaatsen wordt gezocht met met de volgende parameters
    | naam                | waarde              |
    | type                | RaadpleegMetPeriode |
    | burgerservicenummer | 000000024           |
    | datumVan            | 2010-07-01          |
    | datumTot            | 2020-07-01          |
    | fields              | verblijfplaats      |
    Dan heeft de response verblijfplaatsen met de volgende gegevens
    | land.code | land.omschrijving            | straat      | adresseerbaarObjectIdentificatie | locatiebeschrijving         | datumVan | datumTot |
    |           |                              | Luttestraat | 0800010000000002                 |                             | 20200415 |          |
    | 6014      | Verenigde Staten van Amerika |             |                                  |                             | 20181201 | 20200415 |
    |           |                              |             |                                  | Woonboot bij de Grote Sloot | 20160526 | 20181201 |
    |           |                              | Laan        | 0800010000000001                 |                             | 20100818 | 20160526 |

Rule: De gevraagde velden van een verblijfplaats van een persoon met deels/geheel onbekende datum aanvang adreshouding/adres buitenland worden geleverd als de onzekerheidsperiode van de adreshouding van de verblijfplaats in de gevraagde periode ligt of als de gevraagde periode de onzekerheidsperiode geheel/deels overlapt

  De adreshouding van een persoon heeft een onzekerheidsperiode als de datum aanvang adreshouding geheel/deels onbekend is.
  In deze periode kan niet met zekerheid worden aangegeven of de persoon daadwerkelijk bewoner is van het adresseerbaar object.
  Voor een datum aanvang adreshouding waarvan de dag onbekend is, loopt de onzekerheidsperiode vanaf de eerste dag tot en met de laatste dag van de betreffende maand.
  Voor een datum aanvang adreshouding waarvan de dag en maand onbekend is, loopt de onzekerheidsperiode vanaf de eerste dag tot en met de laatste dag van het betreffende jaar.

  De verblijfplaatsen worden aflopend gesorteerd geleverd. De eerste verblijfplaats in de verblijfplaatsen lijst is de meest recente verblijfplaats in de gevraagde periode.
  In tegenstelling tot verblijfplaatsen met bekend datum aanvang adreshouding/adres buitenland, is de sortering niet hetzelfde als aflopend sorteren op datum aanvang adreshouding/adres buitenland.
  Bij aflopende sortering zou een verblijfplaats met geheel onbekend datum aanvang adreshouding altijd de laatste verblijfplaats zijn in de verblijfplaatsen lijst.

  Abstract Scenario: <scenario> (geen vorige en geen volgende adreshoudingperiode)
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | <datum aanvang adreshouding>       |
    Als gba verblijfplaatsen wordt gezocht met met de volgende parameters
    | naam                | waarde              |
    | type                | RaadpleegMetPeriode |
    | burgerservicenummer | 000000024           |
    | datumVan            | <datum van>         |
    | datumTot            | <datum tot>         |
    | fields              | verblijfplaats      |
    Dan heeft de response verblijfplaatsen met de volgende gegevens
    | adresseerbaarObjectIdentificatie | straat | datumVan                     | datumTot |
    | 0800010000000001                 | Laan   | <datum aanvang adreshouding> |          |

    Voorbeelden:
    | datum aanvang adreshouding | datum van  | datum tot  | scenario                                                                                                  |
    | 20100800                   | 2010-08-01 | 2010-08-31 | De gevraagde periode ligt in de onzekerheidsperiode van de adreshouding op een adresseerbaar object       |
    | 20100800                   | 2010-07-01 | 2010-08-15 | De gevraagde periode ligt deels in de onzekerheidsperiode van de adreshouding op een adresseerbaar object |
    | 20100800                   | 2010-08-01 | 2011-01-01 | De gevraagde periode overlapt de onzekerheidsperiode van de adreshouding op een adresseerbaar object      |
    | 20100000                   | 2010-01-01 | 2010-12-31 | De gevraagde periode ligt in de onzekerheidsperiode van de adreshouding op een adresseerbaar object       |

  Scenario: De gevraagde periode overlapt meerdere adreshoudingperiodes met deels/geheel onbekend datum aanvang adreshouding/adres buitenland
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100000                           |
    En de persoon is vervolgens ingeschreven op adres 'A4' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20101026                           |
    En de persoon is vervolgens ingeschreven op een buitenlands adres met de volgende gegevens
    | datum aanvang adres buitenland (13.20) | land adres buitenland (13.10) |
    | 00000000                               | 6014                          |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20200415                           |
    Als gba verblijfplaatsen wordt gezocht met met de volgende parameters
    | naam                | waarde              |
    | type                | RaadpleegMetPeriode |
    | burgerservicenummer | 000000024           |
    | datumVan            | 2010-07-01          |
    | datumTot            | 2020-07-01          |
    | fields              | verblijfplaats      |
    Dan heeft de response verblijfplaatsen met de volgende gegevens
    | land.code | land.omschrijving            | straat      | adresseerbaarObjectIdentificatie | locatiebeschrijving         | datumVan | datumTot |
    |           |                              | Luttestraat | 0800010000000002                 |                             | 20200415 |          |
    | 6014      | Verenigde Staten van Amerika |             |                                  |                             | 00000000 | 20200415 |
    |           |                              |             |                                  | Woonboot bij de Grote Sloot | 20101026 | 00000000 |
    |           |                              | Laan        | 0800010000000001                 |                             | 20100000 | 20101026 |

Rule: De gevraagde velden van een verblijfplaats buitenland van een persoon worden niet geleverd als de 'verblijfplaatsBinnenland' field alias wordt gebruikt

  Scenario: De gevraagde periode overlapt geheel/deels de adreshoudingperiode op een buitenlands adres
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100818                           |
    En de persoon is vervolgens ingeschreven op adres 'A4' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20160526                           |
    En de persoon is vervolgens ingeschreven op een buitenlands adres met de volgende gegevens
    | datum aanvang adres buitenland (13.20) | land adres buitenland (13.10) |
    | 20181201                               | 6014                          |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20200415                           |
    Als gba verblijfplaatsen wordt gezocht met met de volgende parameters
    | naam                | waarde                   |
    | type                | RaadpleegMetPeriode      |
    | burgerservicenummer | 000000024                |
    | datumVan            | 2010-07-01               |
    | datumTot            | 2020-07-01               |
    | fields              | verblijfplaatsBinnenland |
    Dan heeft de response verblijfplaatsen met de volgende gegevens
    | straat      | adresseerbaarObjectIdentificatie | locatiebeschrijving         | datumVan | datumTot |
    | Luttestraat | 0800010000000002                 |                             | 20200415 |          |
    |             |                                  | Woonboot bij de Grote Sloot | 20160526 | 20181201 |
    | Laan        | 0800010000000001                 |                             | 20100818 | 20160526 |
