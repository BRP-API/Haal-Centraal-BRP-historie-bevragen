# language: nl

Functionaliteit: Tonen van Nationaliteithistorie
  Huidige en voormalige nationaliteiten van ingeschreven personen kunnen worden geraadpleegd.

  Rule: In het antwoord wordt indicatieNationaliteitBeeindigd opgenomen met de waarde true, wanneer in de actuele nationaliteit (categorie 04) GEEN nationaliteit (05.10) noch aanduiding bijzonder Nederlanderschap (65.10) is opgenomen, of wanneer in categorie 04 reden beëindigen nationaliteit (64.10) is opgenomen.

    Scenario: actuele nationaliteit
      Gegeven de ingeschreven persoon met burgerservicenummer 000009830 kent de volgende nationaliteiten:
        | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
        | 1      | 4         | 0001                  | 001                   |                          |                                    |                 | 19750707                        |
      Als de nationaliteithistorie met burgerservicenummer 000009830 wordt geraadpleegd
      Dan bevat het antwoord 1 item(s) voor nationaliteithistorie
      En bevat het nationaliteithistorie-item met nationaliteit.code "0001" geen gegeven "indicatieNationaliteitBeeindigd"

    Scenario: actueel bijzonder Nederlanderschap
      Gegeven de ingeschreven persoon met burgerservicenummer 000009866 kent de volgende nationaliteiten:
        | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
        | 1      | 4         |                       | 310                   |                          | B                                  |                 | 19570115                        |
      Als de nationaliteithistorie met burgerservicenummer 000009830 wordt geraadpleegd
      Dan bevat het antwoord 1 item(s) voor nationaliteithistorie
      En bevat het nationaliteithistorie-item met aanduidingBijzonderNederlanderschap "behandeld_als_nederlander" geen gegeven "indicatieNationaliteitBeeindigd"

    Scenario: actuele en beëindigde nationaliteit
      Gegeven de ingeschreven persoon met burgerservicenummer 999990998 kent de volgende nationaliteiten:
        | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
        | 1      | 4         |                       |                       | 404                      |                                    |                 | 20150131                        |
        | 1      | 54        | 0307                  | 301                   |                          |                                    |                 | 00000000                        |
        | 2      | 4         | 0001                  | 000                   |                          |                                    |                 | 00000000                        |
      Als de nationaliteithistorie met burgerservicenummer 999990998 wordt geraadpleegd
      Dan bevat het antwoord 2 item(s) voor nationaliteithistorie
      En bevat het nationaliteithistorie-item met nationaliteit.code "0307" het gegeven "indicatieNationaliteitBeeindigd" met waarde true
      En bevat het nationaliteithistorie-item met nationaliteit.code "0001" geen gegeven "indicatieNationaliteitBeeindigd"

    Scenario: verlies bijzonder Nederlanderschap
      Gegeven de ingeschreven persoon met burgerservicenummer XXXXXXXXX kent de volgende nationaliteiten:
        | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
        | 1      | 4         |                       |                       | 410                      |                                    |                 | 20190604                        |
        | 1      | 54        |                       | 310                   |                          | V                                  |                 | 20010319                        |
        | 2      | 4         | 0001                  | 017                   |                          |                                    |                 | 20190602                        |
      Als de nationaliteithistorie met burgerservicenummer XXXXXXXXX wordt geraadpleegd
      Dan bevat het antwoord 2 item(s) voor nationaliteithistorie
      En bevat het nationaliteithistorie-item met aanduidingBijzonderNederlanderschap "vastgesteld_niet_nederlander" het gegeven "indicatieNationaliteitBeeindigd" met waarde true
      En bevat het nationaliteithistorie-item met nationaliteit.code "0001" geen gegeven "indicatieNationaliteitBeeindigd"


  Rule: Voor een beëindigde nationaliteit of beëindigd bijzonder Nederlanderschap worden de nationaliteit, aanduidingBijzonderNederlanderschap en redenOpname overgenomen uit de jongste bijbehorende historische categorie (54) waarin deze voorkomen.

    Scenario: beëindigde nationaliteit
      Gegeven de ingeschreven persoon met burgerservicenummer 999990998 kent de volgende nationaliteiten:
        | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
        | 1      | 4         |                       |                       | 404                      |                                    |                 | 20150131                        |
        | 1      | 54        | 0307                  | 301                   |                          |                                    |                 | 00000000                        |
        | 2      | 4         | 0001                  | 000                   |                          |                                    |                 | 00000000                        |
      Als de nationaliteithistorie met burgerservicenummer 999990998 wordt geraadpleegd
      Dan bevat het nationaliteithistorie-item met nationaliteit.code "0307" de volgende gegevens:
        | nationaliteit.code | redenOpname.code | redenBeeindigen.code |
        | 0307               | 301              | 404                  |

    Scenario: verlies bijzonder Nederlanderschap
      Gegeven de ingeschreven persoon met burgerservicenummer XXXXXXXXX kent de volgende nationaliteiten:
        | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
        | 1      | 4         |                       |                       | 410                      |                                    |                 | 20190604                        |
        | 1      | 54        |                       | 310                   |                          | V                                  |                 | 20010319                        |
        | 2      | 4         | 0001                  | 017                   |                          |                                    |                 | 20190602                        |
      Als de nationaliteithistorie met burgerservicenummer XXXXXXXXX wordt geraadpleegd
      Dan bevat het nationaliteithistorie-item met aanduidingBijzonderNederlanderschap "vastgesteld_niet_nederlander" de volgende gegevens:
        | aanduidingBijzonderNederlanderschap | redenOpname.code | redenBeeindigen.code |
        | vastgesteld_niet_nederlander        | 301              | 410                  |

  
  Rule: Voor een nationaliteit (actueel of beëindigd) wordt de datumIngangGeldigheid gevuld met de datum geldigheid (85.10) uit de oudste bijbehorende categorie (04 of 54) waarin er een waarde is voor 05.10 of voor 65.10.

    Scenario: actueel en ongewijzigde nationaliteit
      Gegeven de ingeschreven persoon met burgerservicenummer 000009830 kent de volgende nationaliteiten:
        | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
        | 1      | 4         | 0001                  | 001                   |                          |                                    |                 | 19750707                        |
      Als de nationaliteithistorie met burgerservicenummer 000009830 wordt geraadpleegd
      Dan bevat het nationaliteithistorie-item met nationaliteit.code "0001" het gegeven "datumIngangGeldigheid" met datum "1975-07-07"

    Scenario: beëindigde nationaliteit
      Gegeven de ingeschreven persoon met burgerservicenummer 999991188 kent de volgende nationaliteiten:
        | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
        | 1      | 4         | 0499                  | 312                   |                          |                                    |                 | 20040201                        |
        | 2      | 4         |                       |                       | 401                      |                                    |                 | 20040201                        |
        | 2      | 54        | 0065                  | 301                   |                          |                                    |                 | 19310624                        |
      Als de nationaliteithistorie met burgerservicenummer 999991188 wordt geraadpleegd
      Dan bevat het nationaliteithistorie-item met nationaliteit.code "0499" het gegeven "datumIngangGeldigheid" met datum "1931-06-24"

    Scenario: verlies bijzonder Nederlanderschap
      Gegeven de ingeschreven persoon met burgerservicenummer XXXXXXXXX kent de volgende nationaliteiten:
        | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
        | 1      | 4         |                       |                       | 410                      |                                    |                 | 20190604                        |
        | 1      | 54        |                       | 310                   |                          | V                                  |                 | 20010319                        |
        | 2      | 4         | 0001                  | 017                   |                          |                                    |                 | 20190602                        |
      Als de nationaliteithistorie met burgerservicenummer XXXXXXXXX wordt geraadpleegd
      Dan bevat het nationaliteithistorie-item met aanduidingBijzonderNederlanderschap "vastgesteld_niet_nederlander" het gegeven "datumIngangGeldigheid" met datum "2001-03-19"

    Scenario: nationaliteit met onbekende datum ingang geldigheid
      Gegeven de ingeschreven persoon met burgerservicenummer 999990998 kent de volgende nationaliteiten:
        | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
        | 1      | 4         |                       |                       | 404                      |                                    |                 | 20150131                        |
        | 1      | 54        | 0307                  | 301                   |                          |                                    |                 | 00000000                        |
        | 2      | 4         | 0001                  | 000                   |                          |                                    |                 | 00000000                        |
      Als de nationaliteithistorie met burgerservicenummer 999990998 wordt geraadpleegd
      Dan bevat het nationaliteithistorie-item met nationaliteit.code "0307" geen gegeven "datumIngangGeldigheid"
      En bevat het nationaliteithistorie-item met nationaliteit.code "0001" geen gegeven "datumIngangGeldigheid"

    Scenario: gewijzigde reden opnemen
      Gegeven de ingeschreven persoon met burgerservicenummer XXXXXXXXX kent de volgende nationaliteiten:
        | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
        | 1      | 4         | 0100                  | 301                   |                          |                                    |                 | 20200727                        |
        | 1      | 54        | 0100                  | 311                   |                          |                                    |                 | 20200713                        |
      Als de nationaliteithistorie met burgerservicenummer XXXXXXXXX wordt geraadpleegd
      Dan bevat het nationaliteithistorie-item met nationaliteit.code "0100" het gegeven "datumIngangGeldigheid" met datum "2020-07-13"

    Scenario: gewijzigde reden beëindigen
      Gegeven de ingeschreven persoon met burgerservicenummer 999994657 kent de volgende nationaliteiten:
        | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
        | 1      | 4         |                       |                       | 404                      |                                    |                 | 20140601                        |
        | 1      | 54        |                       |                       | 401                      |                                    |                 | 19940601                        |
        | 1      | 54        | 0100                  | 301                   |                          |                                    |                 | 19890301                        |
        | 2      | 4         | 0001                  | 030                   |                          |                                    |                 | 19910201                        |
      Als de nationaliteithistorie met burgerservicenummer 999994657 wordt geraadpleegd
      Dan bevat het nationaliteithistorie-item met nationaliteit.code "0100" het gegeven "datumIngangGeldigheid" met datum "1989-03-01"

  
  Rule: Voor een beëindigde nationaliteit of beëindigd bijzonder Nederlanderschap wordt de redenBeeindigen overgenomen uit de bijbehorende actuele categorie (04).

    Scenario: gewijzigde reden beëindigen
      Gegeven de ingeschreven persoon met burgerservicenummer 999994657 kent de volgende nationaliteiten:
        | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
        | 1      | 4         |                       |                       | 404                      |                                    |                 | 20140601                        |
        | 1      | 54        |                       |                       | 401                      |                                    |                 | 19940601                        |
        | 1      | 54        | 0100                  | 301                   |                          |                                    |                 | 19890301                        |
        | 2      | 4         | 0001                  | 030                   |                          |                                    |                 | 19910201                        |
      Als de nationaliteithistorie met burgerservicenummer 999994657 wordt geraadpleegd
      Dan bevat het nationaliteithistorie-item met nationaliteit.code "0100" het gegeven "redenBeeindigen" met code "404"

  
  Rule: Voor een beëindigde nationaliteit wordt datumTot gevuld met de datum geldigheid (85.10) uit de oudste bijbehorende categorie (04 of 54) waarin er geen waarde is voor 05.10 noch voor 65.10.

    Scenario: gewijzigde reden beëindigen
      Gegeven de ingeschreven persoon met burgerservicenummer 999994657 kent de volgende nationaliteiten:
        | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
        | 1      | 4         |                       |                       | 404                      |                                    |                 | 20140601                        |
        | 1      | 54        |                       |                       | 401                      |                                    |                 | 19940601                        |
        | 1      | 54        | 0100                  | 301                   |                          |                                    |                 | 19890301                        |
        | 2      | 4         | 0001                  | 030                   |                          |                                    |                 | 19910201                        |
      Als de nationaliteithistorie met burgerservicenummer 999994657 wordt geraadpleegd
      Dan bevat het nationaliteithistorie-item met nationaliteit.code "0100" het gegeven "datumTot" met datum "1994-06-01"

    Scenario: actuele nationaliteit
      Gegeven de ingeschreven persoon met burgerservicenummer 000009830 kent de volgende nationaliteiten:
        | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
        | 1      | 4         | 0001                  | 001                   |                          |                                    |                 | 19750707                        |
      Als de nationaliteithistorie met burgerservicenummer 000009830 wordt geraadpleegd
      Dan bevat het nationaliteithistorie-item met nationaliteit.code "0001" geen gegeven "datumTot"
  
  Rule: Een onjuiste nationaliteit wordt niet opgenomen.
    # Een nationaliteit waarbij in categorie 04 indicatie onjuist (84.10) is gevuld, wordt niet opgenomen in het antwoord.
    # Een beëindigde nationaliteit waarbij de jongste bijbehorende historische categorie 54 met nationaliteit (05.10) gevuld én indicatie onjuist (84.10) gevuld, wordt niet opgenomen in het antwoord.
    # Voor een actuele nationaliteit (niet-beëindigd) met een bijbehorende historische categorie 54 met indicatie onjuist, worden de gegevens (incl. datum ingang) in de onjuiste categorie genegeerd.

    Scenario: onjuiste nationaliteit in actuele categorie
      Gegeven de ingeschreven persoon met burgerservicenummer 999992855 kent de volgende nationaliteiten:
        | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
        | 1      | 4         | 0001                  | 018                   |                          |                                    |                 | 20041015                        |
        | 2      | 4         |                       |                       |                          |                                    |                 | 20121022                        |
        | 3      | 4         | 0251                  |                       |                          |                                    | O               | 20121022                        |
        | 4      | 4         | 0445                  |                       |                          |                                    |                 | 19611230                        |
        | 5      | 4         | 0446                  |                       |                          |                                    |                 | 19611230                        |
      Als de nationaliteithistorie met burgerservicenummer 999992855 wordt geraadpleegd
      Dan is er geen nationaliteithistorie-item met nationaliteit.code "0251"
  
    Scenario: onjuiste nationaliteit in historische categorie
      Gegeven de ingeschreven persoon met burgerservicenummer XXXXXXXXX kent de volgende nationaliteiten:
        | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
        | 1      | 4         | 0001                  | 189                   |                          |                                    |                 | 20180210                        |
        | 2      | 4         |                       |                       | 405                      |                                    |                 | 20181014                        |
        | 2      | 54        | 0031                  | 301                   |                          |                                    | O               | 20160526                        |
      Als de nationaliteithistorie met burgerservicenummer XXXXXXXXX wordt geraadpleegd
      Dan is er geen nationaliteithistorie-item met nationaliteit.code "0031"
  

  Rule: In het antwoord worden eerst de actuele nationaliteiten opgenomen, gevolgd door de beëindigde nationaliteiten (gesorteerd op indicatieNationaliteitBeeindigd). Daarbinnen worden resultaten aflopend gesorteerd op datumTot en vervolgens aflopend gesorteerd op datumIngangGeldigheid.

    Scenario: actuele en beëindigde nationaliteiten in de juiste volgorde
      Gegeven de ingeschreven persoon met burgerservicenummer 999991292 kent de volgende nationaliteiten:
        | Stapel | Categorie | 05.10 | 65.10 | 64.10 | 85.10    |
        | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
        | 1      | 04        |                       |                       | 404                      |                                    |                 | 19940601                        |
        | 1      | 54        | 0100                  |                       |                          |                                    |                 | 19890301                        |
        | 2      | 04        | 0001                  |                       |                          |                                    |                 | 19910201                        |
        | 3      | 04        |                       |                       | 404                      |                                    |                 | 20140601                        |
        | 3      | 54        | 0057                  |                       |                          |                                    |                 | 19831213                        |
      Als de nationaliteithistorie met burgerservicenummer 999991292 wordt geraadpleegd
      Dan bevat het antwoord 3 voorkomens
      En wordt de nationaliteithistorie teruggegeven in de volgorde en met waarden:
      | # | nationaliteit.code | aanduidingBijzonderNederlanderschap | datumIngangGeldigheid | datumTot             | indicatieNationaliteitBeeindigd | redenBeeindigen.code |
      | 0 | 0001               |                                     | 1991-02-01            |                      |                                 |                      |
      | 1 | 0057               |                                     | 1983-12-13            | 2014-06-01           | true                            | 404                  |
      | 2 | 0100               |                                     | 1989-03-01            | 1994-06-01           | true                            | 404                  |


  Rule: bij sorteren wordt een nationaliteit met volledig onbekende datum ingang geplaatst onder de nationaliteit(en) met een bekende datum)

    Scenario: onbekende datum ingang geldigheid
      Gegeven de ingeschreven persoon met burgerservicenummer 999992806 kent de volgende nationaliteiten:
        | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
        | 1      | 4         | 0334                  | 301                   |                          |                                    |                 | 00000000                        |
        | 2      | 4         |                       |                       | 404                      |                                    |                 | 20150131                        |
        | 2      | 54        |                       |                       | 401                      |                                    |                 | 20000114                        |
        | 2      | 54        | 0331                  | 301                   |                          |                                    |                 | 00000000                        |
        | 3      | 4         |                       | 310                   |                          | V                                  |                 | 20000114                        |
      Als de nationaliteithistorie met burgerservicenummer 999992806 wordt geraadpleegd
      Dan bevat het antwoord 3 voorkomens
      En wordt de nationaliteithistorie teruggegeven in de volgorde en met waarden:
      | # | nationaliteit.code | aanduidingBijzonderNederlanderschap | datumIngangGeldigheid | datumTot             | indicatieNationaliteitBeeindigd | redenBeeindigen.code |
      | 0 | 0100               | vastgesteld_niet_nederlander        | 2000-01-14            |                      |                                 |                      |
      | 1 | 0334               |                                     |                       |                      |                                 |                      |
      | 2 | 0331               |                                     | 1983-12-13            | 2000-01-14           | true                            | 404                  |
