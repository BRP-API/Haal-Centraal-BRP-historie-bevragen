# language: nl

 Functionaliteit: Tonen van verblijfstitelhistorie
  - Huidige en historische verblijfstitels van ingeschreven personen kunnen worden geraadpleegd.
  - Filteren op peildatum of periode wordt gedaan op basis Ingangsdatum verblijfstitel (39.30) en Datum einde verblijfstitel (39.20). Datum einde verblijfstitel is de datum waarop de verblijfstitel niet meer geldig is

  - Op periode gefilterde gegevens tonen alle verblijfstitels die de persoon gedurende de periode heeft gehad.

  - Historische voorkomens die onjuist zijn worden niet opgenomen in de response.

  De verblijfstitels worden in de response aflopend gesorteerd op ingangsdatum, zodat de meest actuele bovenaan staat.
  Als er een actuele verblijfstitel is (categorie 10) staat deze als eerste verblijfstitel in de response.

  Achtergrond:
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | burgerservicenummer |
    | 999991553           |
    En de persoon heeft de volgende verblijfstitels gegevens
    | categorie | Aanduiding (39.10) | Datum einde (39.20) | Ingangsdatum (39.30) | Testsituatie                                            |
    | 10        | 42                 | 20190901            | 20160901             |                                                         |
    | 60        | 24                 | 20120405            | 20090512             | ingangsdatum is eerder dan datum einde vorige           |
    | 60        | 26                 | 20091129            | 20081129             |                                                         |
    | 60        | 25                 |                     | 20050219             | datumEinde wordt ingevuld met ingangsdatum volgende     |
    | 60        | 33                 | 20050327            | 20030327             | Overschrijft vorige verblijfstitel                      |
    | 60        | 34                 | 20060327            | 20030327             |                                                         |
    | 60        | 11                 | 20011205            | 20011205             | Ingangsdatum = datum einde                              |

Rule: Als de peildatum waarmee geraadpleegd wordt in de geldigheidsperiode van een verblijfstitel van een persoon valt wordt die verblijfstitel opgenomen in de response.

  @gba
  Scenario: Raadpleeg de verblijfstitelhistorie met peildatum na datum einde laatste verblijfstitel
    Als de verblijfstitelhistorie wordt geraadpleegd met de volgende parameters
    | naam                | waarde                |
    | type                | RaadpleegMetPeildatum |
    | burgerservicenummer | 999991553             |
    | fields              | aanduiding, datumEinde, datumIngang |
    | peildatum           | 2019-09-28            |
    Dan heeft de response geen verblijfstitelhistorie

  @gba
  Scenario: Raadpleeg de verblijfstitelhistorie met peildatum voor de ingangsdatum van de eerste verblijfstitel
    Als de verblijfstitelhistorie wordt geraadpleegd met de volgende parameters
    | naam                | waarde                |
    | type                | RaadpleegMetPeildatum |
    | burgerservicenummer | 999991553             |
    | fields              | aanduiding, datumEinde, datumIngang |
    | peildatum           | 2019-09-28            |
    Dan heeft de response geen verblijfstitelhistorie

  @gba
  Scenario: Raadpleeg de verblijfstitelhistorie met peildatum gelijk aan de datum einde van een verblijfstitel
    Als de verblijfstitelhistorie wordt geraadpleegd met de volgende parameters
    | naam                | waarde                |
    | type                | RaadpleegMetPeildatum |
    | burgerservicenummer | 999991553             |
    | fields              | aanduiding, datumEinde, datumIngang |
    | peildatum           | 2019-09-01            |
    Dan heeft de response geen verblijfstitelhistorie

  @gba
  Scenario: Raadpleeg de verblijfstitelhistorie met peildatum gelijk aan de datum ingang van een verblijfstitel
    Als de verblijfstitelhistorie wordt geraadpleegd met de volgende parameters
    | naam                | waarde                |
    | type                | RaadpleegMetPeildatum |
    | burgerservicenummer | 999991553             |
    | fields              | aanduiding.code, datumEinde, datumIngang |
    | peildatum           | 20160901              |
    Dan heeft de response een verblijfstitelhistorie met de waarden
    | aanduiding.code | datumIngang | datumEinde |
    | 42              | 20160901    | 20190901   |

  @gba
  Scenario: Raadpleeg de verblijfstitelhistorie met peildatum in de actuele verblijfstitel
    Als de verblijfstitelhistorie wordt geraadpleegd met de volgende parameters
    | naam                | waarde                |
    | type                | RaadpleegMetPeildatum |
    | burgerservicenummer | 999991553             |
    | fields              | aanduiding.code, datumEinde, datumIngang |
    | peildatum           | 2019-01-01            |
    Dan heeft de response een verblijfstitelhistorie met de waarden
    | aanduiding.code | datumIngang | datumEinde |
    | 42              | 20160901    | 20190901   |

  @gba
  Scenario: Raadpleeg de verblijfstitelhistorie met peildatum in een historische verblijfstitel
    Als de verblijfstitelhistorie wordt geraadpleegd met de volgende parameters
    | naam                | waarde                |
    | type                | RaadpleegMetPeildatum |
    | burgerservicenummer | 999991553             |
    | fields              | aanduiding.code, datumEinde, datumIngang |
    | peildatum           | 2010-01-01            |
    Dan heeft de response een verblijfstitelhistorie met de waarden
    | aanduiding.code  | datumIngang | datumEinde |
    | 24               | 20090512    | 20120405   |

Rule: Als de periode waarmee geraadpleegd wordt (deels) overlapt met de geldigheidsperiode van een verblijfstitel van een persoon valt wordt die verblijfstitel opgenomen in de response.

  @gba
  Scenario: Raadpleeg de verblijfstitelhistorie met periode en datumVan ligt na datum einde laatste verblijfstitel
    Als de verblijfstitelhistorie wordt geraadpleegd met de volgende parameters
    | naam                | waarde                |
    | type                | RaadpleegMetPeriode   |
    | burgerservicenummer | 999991553             |
    | fields              | aanduiding.code, datumEinde, datumIngang |
    | datumVan            | 2019-09-28            |
    | datumTot            | 2022-01-01            |
    Dan heeft de response geen verblijfstitelhistorie

  @gba
  Scenario: Raadpleeg de verblijfstitelhistorie met periode en datumTot ligt voor ingangsdatum eerste verblijfstitel
    Als de verblijfstitelhistorie wordt geraadpleegd met de volgende parameters
    | naam                | waarde                |
    | type                | RaadpleegMetPeriode   |
    | burgerservicenummer | 999991553             |
    | fields              | aanduiding.code, datumEinde, datumIngang |
    | datumVan            | 2002-01-01            |
    | datumTot            | 2003-03-26            |
    Dan heeft de response geen verblijfstitelhistorie

  @gba
  Scenario: Raadpleeg de verblijfstitelhistorie met periode en datumVan is gelijk een datumEinde van een verblijfstitel
    Als de verblijfstitelhistorie wordt geraadpleegd met de volgende parameters
    | naam                | waarde                |
    | type                | RaadpleegMetPeriode   |
    | burgerservicenummer | 999991553             |
    | fields              | aanduiding.code, datumEinde, datumIngang |
    | datumVan            | 2019-09-01            |
    | datumTot            | 2022-01-01            |
    Dan heeft de response geen verblijfstitelhistorie

  @gba
  Scenario: Raadpleeg de verblijfstitelhistorie met periode binnen de geldigheidsperiode van actuele verblijfstitel
    Als de verblijfstitelhistorie wordt geraadpleegd met de volgende parameters
    | naam                | waarde                |
    | type                | RaadpleegMetPeildatum |
    | burgerservicenummer | 999991553             |
    | fields              | aanduiding.code, datumEinde, datumIngang |
    | datumVan            | 2019-09-01            |
    | datumTot            | 2019-06-30            |
    Dan heeft de response een verblijfstitelhistorie met de waarden
    | aanduiding.code  | datumIngang | datumEinde |
    | 42               | 20160901    | 20190901   |

  @gba
  Scenario: Raadpleeg de verblijfstitelhistorie met periode binnen de geldigheidsperiode van een historische verblijfstitel
    Als de verblijfstitelhistorie wordt geraadpleegd met de volgende parameters
    | naam                | waarde                |
    | type                | RaadpleegMetPeildatum |
    | burgerservicenummer | 999991553             |
    | fields              | aanduiding.code, datumEinde, datumIngang |
    | datumVan            | 2010-01-01            |
    | datumTot            | 2010-12-31            |
    Dan heeft de response een verblijfstitelhistorie met de waarden
    | aanduiding.code  | datumIngang | datumEinde |
    | 24               | 20090512    | 20120405   |

  @gba
  Scenario: Raadpleeg de verblijfstitelhistorie met periode over de geldigheidsperiodes van meerdere verblijfstitels
    Als de verblijfstitelhistorie wordt geraadpleegd met de volgende parameters
    | naam                | waarde                |
    | type                | RaadpleegMetPeildatum |
    | burgerservicenummer | 999991553             |
    | fields              | aanduiding.code, datumEinde, datumIngang |
    | datumVan            | 2009-01-01            |
    | datumTot            | 2009-06-30            |
    Dan heeft de response een verblijfstitelhistorie met de waarden
    | aanduiding.code  | datumIngang | datumEinde |
    | 24               | 20090512    | 20120405   |
    | 26               | 20081129    | 20090512   |

  @gba
  Scenario: Als voor een verblijfstitel ingangsdatum gelijk is aan datum einde, dan wordt deze verblijfstitel niet opgenomen in de response.
    Als de verblijfstitelhistorie wordt geraadpleegd met de volgende parameters
    | naam                | waarde                |
    | type                | RaadpleegMetPeildatum |
    | burgerservicenummer | 999991553             |
    | fields              | aanduiding.code, datumEinde, datumIngang |
    | datumVan            | 2001-01-01            |
    | datumTot            | 2002-01-02            |
    Dan heeft de response geen verblijfstitelhistorie

Rule: Als de datum einde geldigheid van een verblijfstitel leeg of onbekend is en er is een volgende verblijfstitel, dan wordt voor de eerste verblijfstitel datumEinde gevuld met de ingangsdatum van de volgende verblijfstitel.
  @gba
  Scenario: Raadpleeg de verblijfstitelhistorie met vervallen of ingetrokken verblijfstitel
    Gegeven het systeem kent een persoon met de volgende gegevens
    | burgerservicenummer |
    | 999995182           |
    En de persoon heeft de volgende verblijfstitel-gegevens
    | categorie | Aanduiding (39.10) | Datum einde (39.20) | Ingangsdatum (39.30) | Datum geldigheid (85.10) |
    | 10        | 42                 | 20190901            | 20160901             | 20160905                 |
    | 60        | 26                 | 00000000            | 20091129             | 20091203                 |
    Als de verblijfstitelhistorie wordt geraadpleegd met de volgende parameters
    | naam                | waarde                |
    | type                | RaadpleegMetPeildatum |
    | burgerservicenummer | 999991553             |
    | fields              | aanduiding.code, datumEinde, datumIngang |
    | datumVan            | 2009-01-01            |
    | datumTot            | 2018-01-01            |
    Dan heeft de response een verblijfstitelhistorie met de waarden
    | aanduiding.code  | datumIngang | datumEinde |
    | 42               | 20160901    | 20190901   |
    | 26               | 20091129    | 00000000   |

  @proxy
  Scenario: Raadpleeg de verblijfstitelhistorie met vervallen of ingetrokken verblijfstitel
    Gegeven het systeem kent een persoon met de volgende gegevens
    | burgerservicenummer |
    | 999995182           |
    En de persoon heeft de volgende verblijfstitel-gegevens
    | categorie | Aanduiding (39.10) | Datum einde (39.20) | Ingangsdatum (39.30) | Datum geldigheid (85.10) |
    | 10        | 42                 | 20190901            | 20160901             | 20160905                 |
    | 60        | 26                 | 00000000            | 20091129             | 20091203                 |
    Als de verblijfstitelhistorie wordt geraadpleegd met de volgende parameters
    | naam                | waarde                |
    | type                | RaadpleegMetPeildatum |
    | burgerservicenummer | 999991553             |
    | fields              | aanduiding.code, datumEinde, datumIngang |
    | datumVan            | 2009-01-01            |
    | datumTot            | 2018-01-01            |
    Dan heeft de response een verblijfstitelhistorie met de waarden
    | aanduiding.code  | datumIngang.datum | datumIngang.type |datumIngang.langFormaat | datumEinde.datum | datumEinde.type | datumEinde.langFormaat |
    | 42               | 2016-09-01        | datum            | 1 september 2016       | 2019-09-01       | Datum           | 1 september 2019       |
    | 26               | 2009-11-29        | datum            | 29 november 2009       | 2016-09-01       | Datum           | 1 september 2016       |
      

Rule: Een vervallen of een ingetrokken verblijfstitel wordt niet opgenomen in de response
  @gba
  Scenario: Raadpleeg de verblijfstitelhistorie met vervallen of ingetrokken verblijfstitel
    Gegeven het systeem kent een persoon met de volgende gegevens
    | burgerservicenummer |
    | 999995182           |
    En de persoon heeft de volgende verblijfstitel-gegevens
    | categorie | Aanduiding (39.10) | Datum einde (39.20) | Ingangsdatum (39.30) | Datum geldigheid (85.10) |
    | 10        | 42                 | 20190901            | 20160901             | 20160905                 |
    | 60        |                    |                     |                      | 20150723                 |
    | 60        | 26                 | 20120202            | 20091129             | 20091203                 |
    Als de verblijfstitelhistorie wordt geraadpleegd met de volgende parameters
    | naam                | waarde                |
    | type                | RaadpleegMetPeildatum |
    | burgerservicenummer | 999991553             |
    | fields              | aanduiding.code, datumEinde, datumIngang |
    | datumVan            | 2009-01-01            |
    | datumTot            | 2018-01-01            |
    Dan heeft de response een verblijfstitelhistorie met de waarden
    | aanduiding.code  | datumIngang | datumEinde |
    | 42               | 20160901    | 20190901   |
    | 26               | 20091129    | 20120202   |

  @proxy
  Scenario: Raadpleeg de verblijfstitelhistorie met vervallen of ingetrokken verblijfstitel
    Gegeven het systeem kent een persoon met de volgende gegevens
    | burgerservicenummer |
    | 999995182           |
    En de persoon heeft de volgende verblijfstitel-gegevens
    | categorie | Aanduiding (39.10) | Datum einde (39.20) | Ingangsdatum (39.30) | Datum geldigheid (85.10) |
    | 10        | 42                 | 20190901            | 20160901             | 20160905                 |
    | 60        |                    |                     |                      | 20150723                 |
    | 60        | 26                 | 20120202            | 20091129             | 20091203                 |
    Als de verblijfstitelhistorie wordt geraadpleegd met de volgende parameters
    | naam                | waarde                |
    | type                | RaadpleegMetPeildatum |
    | burgerservicenummer | 999991553             |
    | fields              | aanduiding.code, datumEinde, datumIngang |
    | datumVan            | 2009-01-01            |
    | datumTot            | 2018-01-01            |
    Dan heeft de response een verblijfstitelhistorie met de waarden
    | aanduiding.code  | datumIngang.datum | datumIngang.type |datumIngang.langFormaat | datumEinde.datum | datumIngang.type | datumIngang.langFormaat |
    | 42               | 2016-09-01        | datum            | 1 september 2016       | 2019-09-01       | Datum            | 1 september 2019        |
    | 26               | 2009-11-29        | datum            | 29 november 2009       | 2012-02-02       | Datum            | 2 februari 2012         |

Rule: Als een verblijfstitel, actueel of historisch, in onderzoek is, en dit onderzoek is niet afgerond (Datum einde onderzoek is leeg), wordt inOnderzoek gevuld voor betreffende verblijfstitel.

  @gba
  Scenario: Raadpleeg de verblijfstitelhistorie met een historische verblijstitel in onderzoek
    Gegeven het systeem kent een persoon met de volgende gegevens
    | burgerservicenummer |
    | 999992409           |
    En de persoon heeft de volgende verblijfstitel-gegevens
    | categorie | Aanduiding (39.10) | Datum einde (39.20) | Ingangsdatum (39.30) | Datum geldigheid (85.10) | Datum ingang onderzoek |
    | 10        | 42                 | 20190901            | 20160901             | 20160905                 |
    | 60        | 26                 | 00000000            | 20091129             | 20091203                 |
    Als de verblijfstitelhistorie wordt geraadpleegd met de volgende parameters
    | naam                | waarde                |
    | type                | RaadpleegMetPeildatum |
    | burgerservicenummer | 999991553             |
    | fields              | aanduiding.code, datumEinde, datumIngang |
    | datumVan            | 2009-01-01            |
    | datumTot            | 2018-01-01            |
    Dan heeft de response een verblijfstitelhistorie met de waarden
    | aanduiding.code  | datumIngang | datumEinde |
    | 42               | 20160901    | 20190901   |
    | 26               | 20091129    | 00000000   |

Rule:   Er kan op enig moment in de tijd maximaal één verblijfstitel geldig zijn.
  Scenario: Als de datum einde geldigheid van een verblijfstitel ligt na de ingangsdatum van een volgende verblijfstitel, dan wordt voor de eerste verblijfstitel datumEinde gevuld met de ingangsdatum van de volgende verblijfstitel.

  Scenario: Als er meerdere (historische) verblijfstitels zijn met dezelfde ingangsdatum, dan wordt alleen de meest de meest recente opgenomen in de response. Dat is de meest recente datum opneming, of eerste/bovenste in GBA-V antwoord.
  Scenario: Als er een verblijfstitel geldig is over de hele geldigheid van een eerder opgevoerde verblijfstitel, dan wordt alleen de meest de meest recente opgenomen in de response. Dat is de meest recente datum opneming, of eerste/bovenste in GBA-V antwoord.

Rule: Als voor een verblijfstitel groep 39 niet is gevuld, maar geldigheid (85.10) of opneming (86.10) wel, dan wordt deze niet opgenomen in de response.
      Als de einddatum (39.20) van de voorgaande verblijfstitel leeg is, 00000000 of na de geldigheidsdatum van genoemde verblijfstitel ligt, dan wordt voor de voorgaande verblijfstitel als datumEinde de waarde in 85.10 van de lege verblijfstitel genomen.

Rule: Als voor een verblijfstitel de aanduiding gelijk is aan 98 "geen verblijfstitel (meer)", dan wordt deze verblijfstitel niet opgenomen in de response.
      Als de einddatum (39.20) van de voorgaande verblijfstitel leeg is, 00000000 of na de geldigheidsdatum van de verblijfstitel met aanduiding 98 ligt, dan wordt voor de voorgaande verblijfstitel als datumEinde de waarde in 39.30 (ingangsdatum) van de verblijfstitel met aanduiding 98 genomen.
