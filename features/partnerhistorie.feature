# language: nl

Functionaliteit: Tonen van Partnerhistorie
  Huidige en beëindigde huwelijken en geregistreerd partnerschappen van ingeschreven personen kunnen worden geraadpleegd.

  Alleen huwelijken en partnerschappen uit categorie 05 worden opgenomen in het antwoord.
    - Bij het ophalen van ontbonden huwelijken en partnerschappen uit GBA-V wordt de _Datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10)_ uit de eerste historische huwelijk/partnerschap (categorie 55) na het actuele huwelijk/partnerschap waarin _Datum huwelijkssluiting/aangaan geregistreerd partnerschap_ een waarde heeft opgenomen.
    - Als (een deel van) het al dan niet ontbonden huwelijk/partnerschap binnen de gevraagde periode valt worden de gegevens van de de betreffende (ex-)partner opgenomen in het antwoord.
    - Als partnerhistorie wordt gevraagd met peildatum gelijk aan de Datum ontbinding huwelijk/geregistreerd partnerschap van een huwelijk/partnerschap, dan wordt dat huwelijk of partnerschap niet opgenomen in het antwoord.
    - Als partnerhistorie wordt gevraagd met datumVan gelijk aan de Datum ontbinding huwelijk/geregistreerd partnerschap van een huwelijk/partnerschap, dan wordt dat huwelijk of partnerschap niet opgenomen in het antwoord.

  De huwelijken/partnerschappen worden in het antwoord aflopend gesorteerd op Datum huwelijkssluiting/aangaan geregistreerd partnerschap, zodat de laatst gesloten huwelijk/partnerschap bovenaan staat.

Achtergrond:
  Gegeven het systeem heeft een personen met de volgende gegevens
  | burgerservicenummer |
  | 999991553           |
  | 999995182           |
  | 999992806           |
  | 999991139           |
  | 999991418           |
  En de personen hebben de volgende huwelijken/partnerschappen
  | burgerservicenummer | Categorie | Voornamen | Datum aangaan (06.10) | Datum ontbinding (07.10) | datumIngangOnderzoek | aanduidingGegevensInOnderzoek |
  | 999991553           | 5         | Karel     | 20091102              |                          |                      |                               |
  | 999991553           | 5         | Björn     |                       | 20080706                 |                      |                               |
  | 999991553           | 55        | Björn     | 19870714              |                          |                      |                               |
  | 999991553           | 55        | Björn     | 19870714              |                          |                      |                               |
  | 999995182           | 5         | Erik      |                       | 19730812                 |                      |                               |
  | 999995182           | 55        | Erik      |                       | 19730812                 |                      |                               |
  | 999995182           | 55        | Erik      | 19650812              |                          |                      |                               |
  | 999995182           | 5         | Henk      | 19740808              |                          |                      |                               |
  | 999992806           | 5         | Osama     |                       | 20011109                 |                      |                               |
  | 999992806           | 55        | Osama     | 20000115              |                          |                      |                               |
  | 999991139           | 5         | Ayaan     | 19360000              |                          |                      |                               |
  | 999991418           | 5         | Annechien | 00000000              |                          |                      |                               |
  | 999992409           | 5         | Jennifer  | 20140123              |                          | 20160403             | 050000                        |

Rule: Gegevens van (ex-)partners kunnen geraadpleegd worden op een specifieke peildatum (in het verleden).
        - Filteren op peildatum wordt gedaan op basis Datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) en Datum ontbinding huwelijk/geregistreerd partnerschap (07.10).

  @gba
  Scenario: Raadpleeg op peildatum met ontbonden huwelijk/partnerschap
    Als de partnerhistorie wordt geraadpleegd met de volgende parameters
    | naam                | waarde                |
    | type                | RaadpleegMetPeildatum |
    | burgerservicenummer | 999991553             |
    | fields              | naam.voornamen, aangaanHuwelijkPartnerschap.datum, ontbindingHuwelijkPartnerschap.datum |
    | peildatum           | 2001-01-01            |
    Dan worden de (ex-)partner-gegevens geretourneerd en met waarden:
    | naam.voornamen | aangaanHuwelijkPartnerschap.datum | ontbindingHuwelijkPartnerschap.datum |
    | Björn          | 1987-07-14                        | 2008-07-06                           |

  @gba
  Scenario: Raadpleeg op peildatum in actueel huwelijk/partnerschap
    Als de partnerhistorie wordt geraadpleegd met de volgende parameters
    | naam                | waarde                |
    | type                | RaadpleegMetPeildatum |
    | burgerservicenummer | 999991553             |
    | fields              | naam.voornamen, aangaanHuwelijkPartnerschap.datum, ontbindingHuwelijkPartnerschap.datum |
    | peildatum           | 2009-09-11            |
    Dan worden de (ex-)partner-gegevens geretourneerd en met waarden:
    | naam.voornamen | aangaanHuwelijkPartnerschap.datum | ontbindingHuwelijkPartnerschap.datum |
    | Karel          | 2009-11-02                        |                                      |

Rule: Gegevens van (ex-)partners kunnen geraadpleegd worden binnen een specifieke periode.
        - Filteren op periode wordt gedaan op basis Datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) en Datum ontbinding huwelijk/geregistreerd partnerschap (07.10).
        - Op periode gefilterde gegevens tonen alle huwelijken/partnerschappen die de persoon gedurende de periode heeft gehad.
  @gba
  Scenario: Raadpleeg op periode bij ontbonden en actueel huwelijk
    Als de partnerhistorie wordt geraadpleegd met de volgende parameters
    | naam                | waarde                |
    | type                | RaadpleegMetPeriode   |
    | burgerservicenummer | 999991553             |
    | fields              | naam.voornamen, aangaanHuwelijkPartnerschap.datum, ontbindingHuwelijkPartnerschap.datum |
    | DatumVan            | 2001-01-01            |
    | DatumTot            | 2010-01-01            |
    Dan worden de (ex-)partner-gegevens geretourneerd en met waarden:
    | naam.voornamen | aangaanHuwelijkPartnerschap.datum | ontbindingHuwelijkPartnerschap.datum |
    | Karel          | 2009-11-02                        |                                      |
    | Björn          | 1987-07-14                        | 2008-07-06                           |

  @gba
  Scenario: Raadpleeg op periode bij ontbonden en actueel huwelijk (in omgekeerde volgorde in registratie)
    Als de partnerhistorie wordt geraadpleegd met de volgende parameters
    | naam                | waarde                |
    | type                | RaadpleegMetPeriode   |
    | burgerservicenummer | 999995182             |
    | fields              | naam.voornamen, aangaanHuwelijkPartnerschap.datum, ontbindingHuwelijkPartnerschap.datum |
    | DatumVan            | 1965-01-01            |
    | DatumTot            | 1975-01-01            |
    Dan worden de (ex-)partner-gegevens geretourneerd en met waarden:
    | naam.voornamen | aangaanHuwelijkPartnerschap.datum | ontbindingHuwelijkPartnerschap.datum |
    | Henk           | 1974-08-08                        |                                      |
    | Erik           | 1965-08-12                        | 1973-08-12                           |

  @gba
  Scenario: Raadpleeg op periode bij ontbonden en actueel huwelijk (in omgekeerde volgorde in registratie)
    Als de partnerhistorie wordt geraadpleegd met de volgende parameters
    | naam                | waarde                |
    | type                | RaadpleegMetPeriode   |
    | burgerservicenummer | 999992806             |
    | fields              | naam.voornamen, aangaanHuwelijkPartnerschap.datum, ontbindingHuwelijkPartnerschap.datum |
    | DatumVan            | 1995-01-01            |
    | DatumTot            | 2005-01-01            |
    Dan worden de (ex-)partner-gegevens geretourneerd en met waarden
    | naam.voornamen | aangaanHuwelijkPartnerschap.datum | ontbindingHuwelijkPartnerschap.datum |
    | Osama          | 2000-01-15                        | 2001-11-09                           |

  @gba
  Scenario: Raadpleeg op peildatum gelijk aan datum ontbinding
  Als de partnerhistorie wordt geraadpleegd met de volgende parameters
  | naam                | waarde                |
  | type                | RaadpleegMetPeildatum |
  | burgerservicenummer | 999991553             |
  | fields              | naam.voornamen, aangaanHuwelijkPartnerschap.datum, ontbindingHuwelijkPartnerschap.datum |
  | peildatum           | 2008-07-06            |
  Dan worden er geen (ex-)partner-gegevens geretourneerd


  @gba
  Scenario: Raadpleeg op periode, periode begint tijdens huwelijk/partnerschap
    Als de partnerhistorie wordt geraadpleegd met de volgende parameters
    | naam                | waarde                |
    | type                | RaadpleegMetPeriode   |
    | burgerservicenummer | 999991553             |
    | fields              | naam.voornamen, aangaanHuwelijkPartnerschap.datum, ontbindingHuwelijkPartnerschap.datum |
    | DatumVan            | 2019-01-01            |
    | DatumTot            | 2022-01-01            |
    Dan worden de (ex-)partner-gegevens geretourneerd met waarden:
    | naam.voornamen | aangaanHuwelijkPartnerschap.datum | ontbindingHuwelijkPartnerschap.datum |
    | Karel          | 2009-11-02                        |                                      |

  @gba
  Scenario: Raadpleeg op periode, periode begint vóór aangaan huwelijk/partnerschap
    Als de partnerhistorie wordt geraadpleegd met de volgende parameters
    | naam                | waarde                |
    | type                | RaadpleegMetPeriode   |
    | burgerservicenummer | 999991553             |
    | fields              | naam.voornamen, aangaanHuwelijkPartnerschap.datum, ontbindingHuwelijkPartnerschap.datum |
    | DatumVan            | 2009-01-01            |
    | DatumTot            | 2022-01-01            |
    Dan worden de (ex-)partner-gegevens geretourneerd en met waarden:
    | naam.voornamen | aangaanHuwelijkPartnerschap.datum | ontbindingHuwelijkPartnerschap.datum |
    | Karel          | 2009-11-02                        |                                      |

  @gba
  Scenario: Raadpleeg op periode, datumVan gelijk aan datum ontbinding
    Als de partnerhistorie wordt geraadpleegd met de volgende parameters
    | naam                | waarde                |
    | type                | RaadpleegMetPeriode   |
    | burgerservicenummer | 999992806             |
    | fields              | naam.voornamen, aangaanHuwelijkPartnerschap.datum, ontbindingHuwelijkPartnerschap.datum |
    | DatumVan            | 2001-11-09            |
    | DatumTot            | 2022-01-01            |
    Dan worden er geen (ex-)partner-gegevens geretourneerd

  Scenario: Raadpleeg op periode, datumTotEnMet gelijk aan datum aangaan
    Als de partnerhistorie wordt geraadpleegd met de volgende parameters
    | naam                | waarde                |
    | type                | RaadpleegMetPeriode   |
    | burgerservicenummer | 999991553             |
    | fields              | naam.voornamen, aangaanHuwelijkPartnerschap.datum, ontbindingHuwelijkPartnerschap.datum |
    | DatumVan            | 2001-11-09            |
    | DatumTot            | 2009-11-02            |
  Dan worden de huwelijken/partners teruggegeven in de volgorde en met waarden:
    | naam.voornamen | aangaanHuwelijkPartnerschap.datum | ontbindingHuwelijkPartnerschap.datum |
    | Karel          | 2009-11-02                        |                                      |

Rule: Wanneer de datum sluiting/aangaan gedeeltelijk onbekend is, wordt voor de filtering aangenomen dat de persoon gedurende de gehele onzekerheidstijd deze partner heeft gehad.
       - Wanneer van de sluiting/aangaan alleen het jaar bekend is, wordt voor de filtering aangenomen dat de persoon het hele jaar deze partner heeft gehad.
       - Wanneer van de sluiting/aangaan alleen het jaar en de maand bekend is, wordt voor de filtering aangenomen dat de persoon de hele maand deze partner heeft gehad.
  @gba
  Scenario: Raadpleeg op peildatum, gedeeltelijk onbekende datum huwelijkssluiting
    Als de partnerhistorie wordt geraadpleegd met de volgende parameters
    | naam                | waarde                |
    | type                | RaadpleegMetPeildatum |
    | burgerservicenummer | 999991139             |
    | fields              | naam.voornamen, aangaanHuwelijkPartnerschap.datum, ontbindingHuwelijkPartnerschap.datum |
    | peildatum           | 1936-01-01            |
    Dan worden de (ex-)partner-gegevens geretourneerd en met waarden:
    | naam.voornamen | aangaanHuwelijkPartnerschap.datum | ontbindingHuwelijkPartnerschap.datum |
    | Ayaan          | 19360000                          |                                      |

  @gba
  Scenario: Raadpleeg op periode, datumTotEnMet valt in het jaar van de gedeelteijk onbekende datum aangaan huwelijk
    Als de partnerhistorie wordt geraadpleegd met de volgende parameters
    | naam                | waarde                |
    | type                | RaadpleegMetPeriode   |
    | burgerservicenummer | 999991139             |
    | fields              | naam.voornamen, aangaanHuwelijkPartnerschap.datum, ontbindingHuwelijkPartnerschap.datum |
    | DatumVan            | 1935-01-01            |
    | DatumTot            | 1936-01-01            |
    Dan worden de huwelijken/partners teruggegeven in de volgorde en met waarden:
    | naam.voornamen | aangaanHuwelijkPartnerschap.datum | ontbindingHuwelijkPartnerschap.datum |
    | Ayaan          | 19360000                          |                                      |

  @gba
  Scenario: Raadpleeg op periode, datumTotEnMet valt in het jaar van de gedeelteijk onbekende datum aangaan huwelijk
    Als de partnerhistorie wordt geraadpleegd met de volgende parameters
    | naam                | waarde                |
    | type                | RaadpleegMetPeriode   |
    | burgerservicenummer | 999991139             |
    | fields              | naam.voornamen, aangaanHuwelijkPartnerschap.datum, ontbindingHuwelijkPartnerschap.datum |
    | DatumVan            | 1936-12-31            |
    | DatumTot            | 1940-01-01            |
    Dan worden de huwelijken/partners teruggegeven in de volgorde en met waarden:
    | naam.voornamen | aangaanHuwelijkPartnerschap.datum | ontbindingHuwelijkPartnerschap.datum |
    | Ayaan          | 19360000                          |                                      |

Rule: Wanneer de sluiting/aangaan geheel onbekend is, wordt voor de filtering aangenomen dat de persoon deze partner altijd heeft gehad.

  @gba
  Scenario: Raadpleeg op peildatum,  onbekende datum aangaan huwelijk/partnerschap
    Als de partnerhistorie wordt geraadpleegd met de volgende parameters
    | naam                | waarde                |
    | type                | RaadpleegMetPeildatum |
    | burgerservicenummer | 999991418             |
    | fields              | naam.voornamen, aangaanHuwelijkPartnerschap.datum, ontbindingHuwelijkPartnerschap.datum |
    | peildatum           | 1925-01-01            |
    Dan worden de (ex-)partner-gegevens geretourneerd en met waarden:
    | naam.voornamen | aangaanHuwelijkPartnerschap.datum | ontbindingHuwelijkPartnerschap.datum |
    | Annechien      | 00000000                          |                                      |

  @gba
  Scenario: Raadpleeg op periode,  onbekende datum aangaan huwelijk/partnerschap
    Als de partnerhistorie wordt geraadpleegd met de volgende parameters
    | naam                | waarde                |
    | type                | RaadpleegMetPeriode   |
    | burgerservicenummer | 999991418             |
    | fields              | naam.voornamen, aangaanHuwelijkPartnerschap.datum, ontbindingHuwelijkPartnerschap.datum |
    | DatumVan            | 1935-01-01            |
    | DatumTot            | 1936-01-01            |
    Dan worden de huwelijken/partners teruggegeven in de volgorde en met waarden:
    | naam.voornamen | aangaanHuwelijkPartnerschap.datum | ontbindingHuwelijkPartnerschap.datum |
    | Annechien      | 00000000                          |                                      |

Rule : Als een huwelijk/partnerschap, actueel of ontbonden, in onderzoek is, en dit onderzoek is niet afgerond (Datum einde onderzoek is leeg), wordt inOnderzoek gevuld voor betreffende huwelijk/partnerschap.
  @gba
  Scenario: Raadpleeg op periode,  gegevens in onderzoek
    Als de partnerhistorie wordt geraadpleegd met de volgende parameters
    | naam                | waarde                |
    | type                | RaadpleegMetPeriode   |
    | burgerservicenummer | 999992409             |
    | fields              | naam.voornamen, aangaanHuwelijkPartnerschap.datum, ontbindingHuwelijkPartnerschap.datum |
    | DatumVan            | 2015-01-01            |
    | DatumTot            | 2017-01-01            |
    Dan worden de huwelijken/partners teruggegeven in de volgorde en met waarden:
    | naam.voornamen | aangaanHuwelijkPartnerschap.datum | ontbindingHuwelijkPartnerschap.datum | datumIngangOnderzoek | aanduidingGegevensInOnderzoek |
    | Jennifer       | 20140123                          |                                      | 20160403             | 050000                        |

  @proxy
  Scenario: Raadpleeg op periode,  gegevens in onderzoek
    Als de partnerhistorie wordt geraadpleegd met de volgende parameters
    | naam                | waarde                |
    | type                | RaadpleegMetPeriode   |
    | burgerservicenummer | 999992409             |
    | fields              | naam.voornamen, aangaanHuwelijkPartnerschap.datum.datum, ontbindingHuwelijkPartnerschap.datum.datum |
    | DatumVan            | 2015-01-01            |
    | DatumTot            | 2017-01-01            |
    Dan worden de huwelijken/partners teruggegeven in de volgorde en met waarden:
    | naam.voornamen | aangaanHuwelijkPartnerschap.datum.datum | ontbindingHuwelijkPartnerschap.datum.datum | aangaanHuwelijkPartnerschap.inOnderzoek.datumIngangOnderzoek.datum | aangaangHuwelijkPartnerschap.inOnderzoek.datum |
    | Jennifer       | 2014-01-23                              |                                            | 2016-04-03                                                         | true                                           |
