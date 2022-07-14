# language: nl

@post-assert
Functionaliteit: als gebruiker van de API wil ik dat zoekresultaten worden gesorteerd op Datum huwelijkssluiting/aangaan geregistreerd partnerschap
    zodat ik in een lijst resultaten het gewenste huwelijk/geregistreerd partnerschap sneller kan vinden

Rule: Partners worden in het antwoord aflopend gesorteerd op Datum huwelijkssluiting/aangaan geregistreerd partnerschap, zodat het laatst gesloten huwelijk/partnerschap bovenaan staat

    Scenario: Ontbonden en actueel huwelijk/partnerschap
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550002 |
      En de 'partner' heeft de volgende 'aangaanHuwelijkPartnerschap' gegevens
      | naam  | waarde   |
      | datum | 20171103 |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550003 |
      En de 'partner' heeft de volgende 'ontbindingHuwelijkPartnerschap' gegevens
      | naam  | waarde   |
      | datum | 20140315 |
      En de 'partner' heeft de volgende historische gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550003 |
      En de 'partner' heeft de volgende historische 'aangaanHuwelijkPartnerschap' gegevens
      | naam  | waarde   |
      | datum | 20101022 |
      Als partnerhistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 555550001           |
      | fields              | burgerservicenummer |
      | datumVan            | 1999-01-01          |
      | datumTot            | 2018-12-31          |
      Dan heeft de response de partnerhistorie in de volgende volgorde
      | burgerservicenummer |
      | 555550002           |
      | 555550003           |

    Scenario: Twee ontbonden huwelijken
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550003 |
      En de 'partner' heeft de volgende 'ontbindingHuwelijkPartnerschap' gegevens
      | naam  | waarde   |
      | datum | 20140315 |
      En de 'partner' heeft de volgende historische gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550003 |
      En de 'partner' heeft de volgende historische 'aangaanHuwelijkPartnerschap' gegevens
      | naam  | waarde   |
      | datum | 20101022 |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550004 |
      En de 'partner' heeft de volgende 'ontbindingHuwelijkPartnerschap' gegevens
      | naam  | waarde   |
      | datum | 20070416 |
      En de 'partner' heeft de volgende historische gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550004 |
      En de 'partner' heeft de volgende historische 'aangaanHuwelijkPartnerschap' gegevens
      | naam  | waarde   |
      | datum | 20010913 |
      Als partnerhistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 555550001           |
      | fields              | burgerservicenummer |
      | datumVan            | 1999-01-01          |
      | datumTot            | 2018-12-31          |
      Dan heeft de response de partnerhistorie in de volgende volgorde
      | burgerservicenummer |
      | 555550003           |
      | 555550004           |

    Scenario: poligamie (twee actuele partners)
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550002 |
      En de 'partner' heeft de volgende 'aangaanHuwelijkPartnerschap' gegevens
      | naam  | waarde   |
      | datum | 20171103 |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550003 |
      En de 'partner' heeft de volgende 'aangaanHuwelijkPartnerschap' gegevens
      | naam  | waarde   |
      | datum | 20101022 |
      Als partnerhistorie wordt gezocht met de volgende parameters
      | naam                | waarde              |
      | type                | RaadpleegMetPeriode |
      | burgerservicenummer | 555550001           |
      | fields              | burgerservicenummer |
      | datumVan            | 2009-01-01          |
      | datumTot            | 2018-12-31          |
      Dan heeft de response de partnerhistorie in de volgende volgorde
      | burgerservicenummer |
      | 555550002           |
      | 555550003           |
