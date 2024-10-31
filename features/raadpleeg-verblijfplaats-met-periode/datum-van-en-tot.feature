#language: nl

Functionaliteit: leveren van datumVan en datumTot voor geleverde verblijfplaatsen

    Achtergrond:
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0800                 | 0800010000000001                         |
      En adres 'A2' heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0800                 | 0800010000000002                         |


    Scenario: actuele en historische verblijfplaatsen
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210526                           |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20231014                           |
      Als verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2023-01-01          |
      | datumTot            | 2024-01-01          |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | type  | datumVan.type | datumVan.datum | datumVan.langFormaat | datumTot.type | datumTot.datum | datumTot.langFormaat | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | adresseerbaarObjectIdentificatie |
      | Adres | Datum         | 2023-10-14     | 14 oktober 2023      |               |                |                      | 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000002                 |
      | Adres | Datum         | 2021-05-26     | 26 mei 2021          | Datum         | 2023-10-14     | 14 oktober 2023      | 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000001                 |

    Scenario: verblijfplaatsen in Nederland en in buitenland
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210526                           |
      En de persoon is vervolgens ingeschreven op een buitenlands adres met de volgende gegevens
      | datum aanvang adres buitenland (13.20) | land adres buitenland (13.10) |
      | 20220730                               | 6014                          |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20231014                           |
      Als verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2022-01-01          |
      | datumTot            | 2024-01-01          |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | type                     | datumVan.type | datumVan.datum | datumVan.langFormaat | datumTot.type | datumTot.datum | datumTot.langFormaat | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | adresseerbaarObjectIdentificatie | verblijfadres.land.code | verblijfadres.land.omschrijving |
      | Adres                    | Datum         | 2023-10-14     | 14 oktober 2023      |               |                |                      | 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000002                 |                         |                                 |
      | VerblijfplaatsBuitenland | Datum         | 2022-07-30     | 30 juli 2022         | Datum         | 2023-10-14     | 14 oktober 2023      |                              |                                      |                                  | 6014                    | Verenigde Staten van Amerika    |
      | Adres                    | Datum         | 2021-05-26     | 26 mei 2021          | Datum         | 2022-07-30     | 30 juli 2022         | 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000001                 |                         |                                 |

    Scenario: verblijfplaats in Nederland heeft datum aanvang met alleen jaar en maand bekend
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210526                           |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20231000                           |
      Als verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2022-01-01          |
      | datumTot            | 2024-01-01          |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | type  | datumVan.type  | datumVan.datum | datumVan.jaar | datumVan.maand | datumVan.langFormaat | datumTot.type  | datumTot.jaar | datumTot.maand | datumTot.langFormaat | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | adresseerbaarObjectIdentificatie | verblijfadres.land.code | verblijfadres.land.omschrijving |
      | Adres | JaarMaandDatum |                | 2023          | 10             | oktober 2023         |                |               |                |                      | 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000002                 |                         |                                 |
      | Adres | Datum          | 2021-05-26     | 26 mei 2021   |                |                      | JaarMaandDatum | 2023          | 10             | oktober 2023         | 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000001                 |                         |                                 |

    Scenario: verblijfplaats in Nederland heeft datum aanvang met alleen jaar bekend
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210526                           |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20230000                           |
      Als verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2022-01-01          |
      | datumTot            | 2024-01-01          |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | type  | datumVan.type | datumVan.datum | datumVan.jaar | datumVan.langFormaat | datumTot.type | datumTot.jaar | datumTot.langFormaat | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | adresseerbaarObjectIdentificatie | verblijfadres.land.code | verblijfadres.land.omschrijving |
      | Adres | JaarDatum     |                | 2023          | 2023                 |               |               |                     | 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000002                 |                         |                                 |
      | Adres | Datum         | 2021-05-26     | 26 mei 2021   |                      | JaarDatum     | 2023          |2023                 | 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000001                 |                         |                                 |

    Scenario: verblijfplaats in Nederland heeft datum aanvang is onbekend
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20220526                           |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 00000000                           |
      Als verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2022-01-01          |
      | datumTot            | 2024-01-01          |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | type  | datumVan.type | datumVan.datum | datumVan.langFormaat | datumVan.onbekend | datumTot.type | datumTot.langFormaat | datumTot.onbekend | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | adresseerbaarObjectIdentificatie | verblijfadres.land.code       | verblijfadres.land.omschrijving |
      | Adres | DatumOnbekend |                | onbekend             | true              |               |                      |                   |                              |                                      | 0800                             | Hoogeloon, Hapert en Casteren | 0800010000000002                |  |  |
      | Adres | Datum         | 2021-05-26     | 26 mei 2021          |                   | DatumOnbekend | onbekend             | true              | 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000001                 |                               |                                 |

    Scenario: verblijfplaats buitenland heeft datum aanvang met alleen jaar en maand bekend
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210526                           |
      En de persoon is vervolgens ingeschreven op een buitenlands adres met de volgende gegevens
      | datum aanvang adres buitenland (13.20) | land adres buitenland (13.10) |
      | 20220700                               | 6014                          |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20231014                           |
      Als verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2022-01-01          |
      | datumTot            | 2024-01-01          |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | type                     | datumVan.type  | datumVan.datum | datumVan.jaar | datumVan.maand | datumVan.langFormaat | datumTot.type  | datumTot.datum | datumTot.jaar | datumTot.maand | datumTot.langFormaat | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | adresseerbaarObjectIdentificatie | verblijfadres.land.code | verblijfadres.land.omschrijving |
      | Adres                    | Datum          | 2023-10-14     |               |                | 14 oktober 2023      |                |                |               |                |                      | 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000002                 |                         |                                 |
      | VerblijfplaatsBuitenland | JaarMaandDatum |                | 2022          | 7              | juli 2022            | Datum          | 2023-10-14     |               |                | 14 oktober 2023      |                              |                                      |                                  | 6014                    | Verenigde Staten van Amerika    |
      | Adres                    | Datum          | 2021-05-26     |               |                | 26 mei 2021          | JaarMaandDatum |                | 2022          | 7              | juli 2022            | 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000001                 |                         |                                 |

    Scenario: verblijfplaats buitenland heeft datum aanvang met alleen jaar bekend
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210526                           |
      En de persoon is vervolgens ingeschreven op een buitenlands adres met de volgende gegevens
      | datum aanvang adres buitenland (13.20) | land adres buitenland (13.10) |
      | 20220000                               | 6014                          |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20231014                           |
      Als verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2022-01-01          |
      | datumTot            | 2024-01-01          |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | type                     | datumVan.type | datumVan.datum | datumVan.jaar | datumVan.langFormaat | datumTot.type | datumTot.datum | datumTot.jaar | datumTot.langFormaat | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | adresseerbaarObjectIdentificatie | verblijfadres.land.code | verblijfadres.land.omschrijving |
      | Adres                    | Datum         | 2023-10-14     |               | 14 oktober 2023      |               |                |               |                      | 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000002                 |                         |                                 |
      | VerblijfplaatsBuitenland | JaarDatum     |                | 2022          | 2022                 | Datum         | 2023-10-14     |               | 14 oktober 2023      |                              |                                      |                                  | 6014                    | Verenigde Staten van Amerika    |
      | Adres                    | Datum         | 2021-05-26     |               | 26 mei 2021          | JaarDatum     |                | 2022          | 2022                 | 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000001                 |                         |                                 |

    Scenario: verblijfplaats buitenland heeft datum aanvang is onbekend
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210526                           |
      En de persoon is vervolgens ingeschreven op een buitenlands adres met de volgende gegevens
      | datum aanvang adres buitenland (13.20) | land adres buitenland (13.10) |
      | 00000000                               | 6014                          |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20231014                           |
      Als verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 000000012           |
      | datumVan            | 2021-01-01          |
      | datumTot            | 2024-01-01          |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | type                     | datumVan.type | datumVan.datum | datumVan.langFormaat | datumVan.onbekend | datumTot.type | datumTot.datum | datumTot.langFormaat | datumTot.onbekend | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | adresseerbaarObjectIdentificatie | verblijfadres.land.code | verblijfadres.land.omschrijving |
      | Adres                    | Datum         | 2023-10-14     | 14 oktober 2023      |                   |               |                |                      |                   | 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000002                 |                         |                                 |
      | VerblijfplaatsBuitenland | DatumOnbekend |                | onbekend             | true              | Datum         | 2023-10-14     | 14 oktober 2023      |                   |                              |                                      |                                  | 6014                    | Verenigde Staten van Amerika    |
      | Adres                    | Datum         | 2021-05-26     | 26 mei 2021          |                   | DatumOnbekend |                | onbekend             | true              | 0800                         | Hoogeloon, Hapert en Casteren        | 0800010000000001                 |                         |                                 |
