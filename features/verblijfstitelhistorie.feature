# language: nl

 Functionaliteit: Tonen van verblijfstitelhistorie
  Huidige en historische verblijfstitels van ingeschreven personen kunnen worden geraadpleegd.

  De gebruiker kan de verblijfstitel raadplegen op een specifieke peildatum (in het verleden).
  De gebruiker kan de verblijfstitels raadplegen over een specifieke periode.
  Filteren op peildatum of periode wordt gedaan op basis Ingangsdatum verblijfstitel (39.30) en Datum einde verblijfstitel (39.20). Datum einde verblijfstitel is de datum waarop de verblijfstitel niet meer geldig is
  .
  Op periode gefilterde gegevens tonen alle verblijfstitels die de persoon gedurende de periode heeft gehad.
  Als de persoon al voor de periode een verblijfstitel had die binnen (een deel van) de gevraagde periode nog steeds geldig was, dan wordt de verblijfstitel opgenomen in het antwoord.
  Als de persoon tijdens (een deel van) de periode een verblijfstitel kreeg die na de gevraagde periode nog steeds geldig was, dan wordt de verblijfstitel opgenomen in het antwoord.
  Als de persoon tijdens de periode een verblijfstitel kreeg die voor het einde van de gevraagde periode zijn geldigheid verloor, dan wordt de verblijfstitel opgenomen in het antwoord.

  Er kan op enig moment in de tijd maximaal één verblijfstitel geldig zijn.
  Als de datum einde geldigheid van een verblijfstitel ligt na de ingangsdatum van een volgende verblijfstitel, dan wordt voor de eerste verblijfstitel datumEinde gevuld met de ingangsdatum van de volgende verblijfstitel.
  Als de datum einde geldigheid van een verblijfstitel leeg is en er is een volgende verblijfstitel, dan wordt voor de eerste verblijfstitel datumEinde gevuld met de ingangsdatum van de volgende verblijfstitel.
  Als er meerdere (historische) verblijfstitels zijn met dezelfde ingangsdatum, dan wordt alleen de meest de meest recente opgenomen in het antwoord. Dat is de meest recente datum opneming, of eerste/bovenste in GBA-V antwoord.
  Als er een verblijfstitel geldig is over de hele geldigheid van een eerder opgevoerde verblijfstitel, dan wordt alleen de meest de meest recente opgenomen in het antwoord. Dat is de meest recente datum opneming, of eerste/bovenste in GBA-V antwoord.

  Als voor een verblijfstitel groep 39 niet is gevuld, maar geldigheid (85.10) of opneming (86.10) wel, dan wordt deze niet opgenomen in het antwoord. Als de einddatum (39.20) van de voorgaande verblijfstitel leeg is, 00000000 of na de geldigheidsdatum van genoemde verblijfstitel ligt, dan wordt voor de voorgaande verblijfstitel als datumEinde de waarde in 85.10 van de lege verblijfstitel genomen.

  Als voor een verblijfstitel de aanduiding gelijk is aan 98 "geen verblijfstitel (meer)", dan wordt deze verblijfstitel niet opgenomen in het antwoord. Als de einddatum (39.20) van de voorgaande verblijfstitel leeg is, 00000000 of na de geldigheidsdatum van de verblijfstitel met aanduiding 98 ligt, dan wordt voor de voorgaande verblijfstitel als datumEinde de waarde in 39.30 (ingangsdatum) van de verblijfstitel met aanduiding 98 genomen.

  Als voor een verblijfstitel ingangsdatum gelijk is aan datum einde, dan wordt deze verblijfstitel niet opgenomen in het antwoord.

  Historische voorkomens die onjuist zijn worden niet opgenomen in het antwoord.

  De verblijfstitels worden in het antwoord aflopend gesorteerd op ingangsdatum, zodat de meest actuele bovenaan staat.
  Als er een actuele verblijfstitel is (categorie 10) staat deze als eerste verblijfstitel in het antwoord.

  Als een verblijfstitel, actueel of historisch, in onderzoek is, en dit onderzoek is niet afgerond (Datum einde onderzoek is leeg), wordt inOnderzoek gevuld voor betreffende verblijfstitel.

  Als wel het begin van de periode (datumVan) wordt opgegeven, maar geen einde van de periode (datumTotEnMet), dan worden alle verblijfstitels vanaf de datumVan in het antwoord opgenomen.
  Als wel het einde van de periode (datumTotEnMet) wordt opgegeven, maar geen begin van de periode (datumVan), dan worden alle verblijfstitels tot en met de datumTotEnMet in het antwoord opgenomen.

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
  Scenario: Raadpleeg de verblijfstitelhistorie met periode binnen de actuele verblijfstitel
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
  Scenario: Raadpleeg de verblijfstitelhistorie met periode binnen een historische verblijfstitel
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
  Scenario: Raadpleeg de verblijfstitelhistorie met periode over meerdere verblijfstitels
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
  Scenario: Raadpleeg de verblijfstitelhistorie met vervallen of ingetrokken verblijfstitel
    Gegeven het systeem kent een persoon met de volgende gegevens
    | burgerservicenummer |
    | 999995182           |
    En de persoon heeft de volgende verblijfstitel-gegevens
    | categorie | Aanduiding (39.10) | Datum einde (39.20) | Ingangsdatum (39.30) | Datum geldigheid (85.10) |
    | 10        | 42                 | 20190901            | 20160901             | 20160905                 |
    | 60        |                    |                     |                      | 20150723                 |
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
    | 60        |                    |                     |                      | 20150723                 |
    | 60        | 26                 | 00000000            | 20091129             | 20091203                 |
    Als de verblijfstitelhistorie wordt geraadpleegd met de volgende parameters
    | naam                | waarde                |
    | type                | RaadpleegMetPeildatum |
    | burgerservicenummer | 999991553             |
    | fields              | aanduiding.code, datumEinde, datumIngang |
    | datumVan            | 2009-01-01            |
    | datumTot            | 2018-01-01            |
    Dan heeft de response een verblijfstitelhistorie met de waarden
    | aanduiding.code  | datumIngang.datum | datumIngang.type |datumIngang.langFormaat | datumEinde.datum | datumIngang.type | datumIngang.langFormaat | datumEinde.onbekend |
    | 42               | 2016-09-01        | datum            | 1 september 2016       | 2019-09-01       | Datum            | 1 september 2019        |                     |
    | 26               | 2009-11-29        | datum            | 29 november 2009       |                  | DatumOnbekend    |                         | true                |
