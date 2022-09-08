# language: nl

Functionaliteit: Lever de omschrijving van de reden opname van een nationaliteit

  Als consumer van de BRP
  Wil ik de omschrijving van de reden opname van een nationaliteit
  Zodat ik deze aan een eindgebruiker kan tonen


  Rule: Op basis van de reden opname wordt de bijbehorende omschrijving gehaald uit de tabel 'Reden_Nationaliteit' (Landelijke tabel 37)

    Abstract Scenario: persoon heeft reden opname "<reden opname code>"
      Gegeven landelijke tabel "Reden_Nationaliteit" heeft de volgende waarde
      | code                | omschrijving                |
      | <reden opname code> | <reden opname omschrijving> |
      En de persoon met burgerservicenummer '<burgerservicenummer>' heeft een 'nationaliteit' met de volgende gegevens
      | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
      | <nationaliteit code>  | <reden opname code>   | 20150426                        |
      Als nationaliteithistorie wordt geraadpleegd met de volgende parameters
      | naam                | waarde                      |
      | type                | RaadpleegMetPeildatum       |
      | burgerservicenummer | <burgerservicenummer>       |
      | peildatum           | 2022-08-16                  |
      | fields              | nationaliteiten.redenOpname |
      Dan heeft de response de volgende 'nationaliteiten'
      | type          | redenOpname.code    | redenOpname.omschrijving    |
      | Nationaliteit | <reden opname code> | <reden opname omschrijving> |

      Voorbeelden:
      | burgerservicenummer | nationaliteit code | reden opname code | reden opname omschrijving                                                        |
      | 000000401           | 0001               | 176               | Wijziging Rw. Nederl. Bep: Rw. 27-06-2008 art. II, lid 1, sub b (Stb. 2008, 270) |
      | 000000413           | 0001               | 100               | Toescheidingsovereenkomst Nederland-Indonesië, art. 3                            |
      | 000000425           | 0052               | 301               | Vaststelling bezit vreemde nationaliteit                                         |

    Scenario: bijzonder Nederlanderschap
      Gegeven landelijke tabel "Reden_Nationaliteit" heeft de volgende waarde
      | code | omschrijving                            |
      | 310  | Vaststelling bijzonder Nederlanderschap |
      En de persoon met burgerservicenummer '000000449' heeft een 'nationaliteit' met de volgende gegevens
      | bijzonder Nederlanderschap (65.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
      | B                                  | 310                   | 20180319                        |
      Als nationaliteithistorie wordt geraadpleegd met de volgende parameters
      | naam                | waarde                                                                 |
      | type                | RaadpleegMetPeildatum                                                  |
      | burgerservicenummer | 000000449                                                              |
      | peildatum           | 2021-01-01                                                             |
      | fields              | nationaliteiten.redenOpname |
      Dan heeft de response de volgende 'nationaliteiten'
      | type                    | redenOpname.code | redenOpname.omschrijving                |
      | BehandeldAlsNederlander | 310              | Vaststelling bijzonder Nederlanderschap |

    Scenario: de persoon heeft een onbekende nationaliteit
      Gegeven landelijke tabel "Reden_Nationaliteit" heeft de volgende waarde
      | code | omschrijving                            |
      | 311  | Vaststelling onbekende nationaliteit |
      En de persoon met burgerservicenummer '000000255' heeft een 'nationaliteit' met de volgende gegevens
      | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
      | 0000                  | 311                   | 19531104                        |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                      |
      | type                | RaadpleegMetPeildatum       |
      | burgerservicenummer | 000000255                   |
      | peildatum           | 2022-08-01                  |
      | fields              | nationaliteiten.redenOpname |
      Dan heeft de response de volgende 'nationaliteiten'
      | type                  | redenOpname.code | redenOpname.omschrijving             |
      | NationaliteitOnbekend | 311              | Vaststelling onbekende nationaliteit |
      
    Scenario: de persoon is staatloos
      Gegeven landelijke tabel "Reden_Nationaliteit" heeft de volgende waarde
      | code | omschrijving               |
      | 312  | Vaststelling staatloosheid |
      En de persoon met burgerservicenummer '000000243' heeft een 'nationaliteit' met de volgende gegevens
      | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
      | 0499                  | 312                   | 20040201                        |
      Als personen wordt gezocht met de volgende parameters
      | naam                | waarde                      |
      | type                | RaadpleegMetPeildatum       |
      | burgerservicenummer | 000000243                   |
      | peildatum           | 2022-08-01                  |
      | fields              | nationaliteiten.redenOpname |
      Dan heeft de response de volgende 'nationaliteiten'
      | type      | redenOpname.code | redenOpname.omschrijving   |
      | Staatloos | 312              | Vaststelling staatloosheid |
