# language: nl

Functionaliteit: Lever de omschrijving van de reden beëindigen
  Als consumer van de BRP
  Wil ik de reden beëindigen omschrijving bij de code ontvangen
  Zodat ik de reden beëindigen aan eindgebruikers kan tonen


  Rule: Op basis van de reden beëindigen wordt de bijbehorende omschrijving gehaald uit de tabel 'Reden_Nationaliteit' (Landelijke tabel 37)

    Abstract Scenario: persoon heeft reden beëindigen "<reden opname code>"
      Gegeven landelijke tabel "Reden_Nationaliteit" heeft de volgende waarde
      | code                    | omschrijving                    |
      | <reden beëindigen code> | <reden beëindigen omschrijving> |
      En de persoon met burgerservicenummer '<burgerservicenummer>' heeft een 'nationaliteit' met de volgende gegevens
      | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
      | <nationaliteit code>  | <reden opname code>   | 20150426                        |
      En de 'nationaliteit' is gewijzigd naar de volgende gegevens
      | reden beëindigen (64.10) | datum ingang geldigheid (85.10) |
      | <reden beëindigen code>  | 20220526                        |
      Als nationaliteithistorie wordt geraadpleegd met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetPeriode             |
      | burgerservicenummer | <burgerservicenummer>           |
      | datumVan            | 2022-01-01                      |
      | datumTot            | 2022-07-01                      |
      | fields              | nationaliteiten.redenBeeindigen |
      Dan heeft de response de volgende 'nationaliteiten'
      | type          | redenBeeindigen.code    | redenBeeindigen.omschrijving    |
      | Nationaliteit | <reden beëindigen code> | <reden beëindigen omschrijving> |

      Voorbeelden:
      | burgerservicenummer | nationaliteit code | reden opname code | reden beëindigen code | reden beëindigen omschrijving                                            |
      | 000000401           | 0001               | 174               | 192                   | Rijkswet Nederlanderschap 1984 ivm wijziging 2017, art. 15, lid 1, sub e |
      | 000000413           | 0001               | 101               | 105                   | Toescheidingsovereenkomst Nederland-Indonesië, art. 5, 2e volzin         |
      | 000000425           | 0052               | 301               | 401                   | Verlies vreemde nationaliteit                                            |
      | 000000425           | 0052               | 301               | 402                   | Afstand van vreemde nationaliteit                                        |
      | 000000425           | 0052               | 301               | 404                   | Beëindiging registratie (niet-Nederlandse) nationaliteit                 |

    Scenario: bijzonder Nederlanderschap
      Gegeven landelijke tabel "Reden_Nationaliteit" heeft de volgende waarde
      | code | omschrijving                       |
      | 410  | Verlies bijzonder Nederlanderschap |
      En de persoon met burgerservicenummer '000000449' heeft een 'nationaliteit' met de volgende gegevens
      | bijzonder Nederlanderschap (65.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
      | B                                  | 310                   | 20180319                        |
      En de 'nationaliteit' is gewijzigd naar de volgende gegevens
      | reden beëindigen (64.10) | datum ingang geldigheid (85.10) |
      | 410                      | 20220526                        |
      Als nationaliteithistorie wordt geraadpleegd met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetPeriode             |
      | burgerservicenummer | 000000449                       |
      | datumVan            | 2022-01-01                      |
      | datumTot            | 2022-07-01                      |
      | fields              | nationaliteiten.redenBeeindigen |
      Dan heeft de response de volgende 'nationaliteiten'
      | type                    | redenBeeindigen.code | redenBeeindigen.omschrijving       |
      | BehandeldAlsNederlander | 410                  | Verlies bijzonder Nederlanderschap |
