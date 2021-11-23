# language: nl

Functionaliteit: Tonen van Nationaliteithistorie
  Huidige en voormalige nationaliteiten van ingeschreven personen kunnen worden geraadpleegd.

  # In onderstaande scenario's staat ten behoeve van de provider implementatie in Gegeven achter de veldnaam tussen haakjes de veldcode zoals deze in de bron volgens LO GBA is geregistreerd.
  # De historie van de registratie van nationaliteiten wordt bewaard in opeenvolgende categorievoorkomens.
  # Elk categorievoorkomen bevat alleen de gewijzigde gegevens, de ingangsdatum dat die gelden en de registratiedatum.
  # Voor elke actuele of beëindigde nationaliteit is er 1 "actuele" categorievoorkomen en 0, 1 of meer "historische" categorievoorkomens.
  # De actuele categorie en de daarbijbehorende historische voorkomens zijn gegroepeerd in een stapel.
  # Een persoon kan meerdere nationaliteiten bezitten of hebben gehad, die elk gegroepeerd zijn op 1 stapel.
  # Het categorievoorkomen met categorie 4 is de actuele categorie, de categorievoorkomens met categorie 54 bevatten de historische gegevens.


  Rule: In het antwoord wordt indicatieNationaliteitBeeindigd opgenomen met de waarde true, wanneer in de actuele nationaliteit (categorie 04) reden beëindigen nationaliteit (64.10) is opgenomen.

    Scenario: de persoon heeft de nationaliteit nu
      Gegeven de ingeschreven persoon met burgerservicenummer 000009830 kent de volgende nationaliteiten:
        | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
        | 1      | 4         | 0001                  | 001                   |                          |                                    |                 | 19750707                        |
      Als de nationaliteithistorie met burgerservicenummer 000009830 wordt geraadpleegd
      Dan bevat het antwoord 1 item(s) voor nationaliteithistorie
      En bevat het nationaliteithistorie-item met nationaliteit.code "0001" geen gegeven "indicatieNationaliteitBeeindigd"

    Scenario: de persoon heeft nu bijzonder Nederlanderschap
      Gegeven de ingeschreven persoon met burgerservicenummer 000009866 kent de volgende nationaliteiten:
        | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
        | 1      | 4         |                       | 310                   |                          | B                                  |                 | 19570115                        |
      Als de nationaliteithistorie met burgerservicenummer 000009830 wordt geraadpleegd
      Dan bevat het antwoord 1 item(s) voor nationaliteithistorie
      En bevat het nationaliteithistorie-item met aanduidingBijzonderNederlanderschap "behandeld_als_nederlander" geen gegeven "indicatieNationaliteitBeeindigd"

    Scenario: beëindigde registratie van vreemde nationaliteit
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
      Gegeven de ingeschreven persoon met burgerservicenummer 555550001 kent de volgende nationaliteiten:
        | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
        | 1      | 4         |                       |                       | 410                      |                                    |                 | 20190604                        |
        | 1      | 54        |                       | 310                   |                          | V                                  |                 | 20010319                        |
        | 2      | 4         | 0001                  | 017                   |                          |                                    |                 | 20190602                        |
      Als de nationaliteithistorie met burgerservicenummer 555550001 wordt geraadpleegd
      Dan bevat het antwoord 2 item(s) voor nationaliteithistorie
      En bevat het nationaliteithistorie-item met aanduidingBijzonderNederlanderschap "vastgesteld_niet_nederlander" het gegeven "indicatieNationaliteitBeeindigd" met waarde true
      En bevat het nationaliteithistorie-item met nationaliteit.code "0001" geen gegeven "indicatieNationaliteitBeeindigd"

    Scenario: beëindigde nationaliteit met onbekende reden
      Gegeven de ingeschreven persoon met burgerservicenummer 555550011 kent de volgende nationaliteiten:
        | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
        | 1      | 4         |                       |                       | 000                      |                                    |                 | 20181122                        |
        | 1      | 54        | 0268                  | 301                   |                          |                                    |                 | 00000000                        |
        | 2      | 4         | 0499                  | 312                   |                          |                                    |                 | 20181122                        |
      Als de nationaliteithistorie met burgerservicenummer 555550011 wordt geraadpleegd
      Dan bevat het antwoord 2 item(s) voor nationaliteithistorie
      En bevat het nationaliteithistorie-item met nationaliteit.code "0268" het gegeven "indicatieNationaliteitBeeindigd" met waarde true
      En bevat het nationaliteithistorie-item met nationaliteit.code "0499" geen gegeven "indicatieNationaliteitBeeindigd"


  Rule: Voor een beëindigde nationaliteit of beëindigd bijzonder Nederlanderschap worden de nationaliteit, aanduidingBijzonderNederlanderschap, redenOpname en datumIngangGeldigheid overgenomen uit de jongste bijbehorende historische categorie (54) waarin deze voorkomen.

    Scenario: beëindigde nationaliteit
      Gegeven de ingeschreven persoon met burgerservicenummer 999990998 kent de volgende nationaliteiten:
        | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
        | 1      | 4         |                       |                       | 404                      |                                    |                 | 20150131                        |
        | 1      | 54        | 0307                  | 301                   |                          |                                    |                 | 00000000                        |
        | 2      | 4         | 0001                  | 000                   |                          |                                    |                 | 00000000                        |
      Als de nationaliteithistorie met burgerservicenummer 999990998 wordt geraadpleegd
      Dan bevat het nationaliteithistorie-item met nationaliteit.code "0307" de volgende gegevens:
        | nationaliteit.code | redenOpname.code | redenBeeindigen.code | datumIngangGeldigheid.datum |
        | 0307               | 301              | 404                  | 20150131

    Scenario: verlies bijzonder Nederlanderschap
      Gegeven de ingeschreven persoon met burgerservicenummer 555550002 kent de volgende nationaliteiten:
        | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
        | 1      | 4         |                       |                       | 410                      |                                    |                 | 20190604                        |
        | 1      | 54        |                       | 310                   |                          | V                                  |                 | 20010319                        |
        | 2      | 4         | 0001                  | 017                   |                          |                                    |                 | 20190602                        |
      Als de nationaliteithistorie met burgerservicenummer 555550002 wordt geraadpleegd
      Dan bevat het nationaliteithistorie-item met aanduidingBijzonderNederlanderschap "vastgesteld_niet_nederlander" de volgende gegevens:
        | aanduidingBijzonderNederlanderschap | redenOpname.code | redenBeeindigen.code |
        | vastgesteld_niet_nederlander        | 301              | 410                  |

  
  Rule: Voor een actueel geldende nationaliteit of bijzonder Nederlanderschap wordt de datumIngangGeldigheid gevuld met de datum geldigheid (85.10) in de actuele categorie (04).

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
      Gegeven de ingeschreven persoon met burgerservicenummer 555550003 kent de volgende nationaliteiten:
        | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
        | 1      | 4         |                       |                       | 410                      |                                    |                 | 20190604                        |
        | 1      | 54        |                       | 310                   |                          | V                                  |                 | 20010319                        |
        | 2      | 4         | 0001                  | 017                   |                          |                                    |                 | 20190602                        |
      Als de nationaliteithistorie met burgerservicenummer 555550003 wordt geraadpleegd
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
      Gegeven de ingeschreven persoon met burgerservicenummer 555550004 kent de volgende nationaliteiten:
        | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
        | 1      | 4         | 0100                  | 301                   |                          |                                    |                 | 20200727                        |
        | 1      | 54        | 0100                  | 311                   |                          |                                    |                 | 20200713                        |
      Als de nationaliteithistorie met burgerservicenummer 555550004 wordt geraadpleegd
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
      Gegeven de ingeschreven persoon met burgerservicenummer 555550005 kent de volgende nationaliteiten:
        | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
        | 1      | 4         | 0001                  | 189                   |                          |                                    |                 | 20180210                        |
        | 2      | 4         |                       |                       | 405                      |                                    |                 | 20181014                        |
        | 2      | 54        | 0031                  | 301                   |                          |                                    | O               | 20160526                        |
      Als de nationaliteithistorie met burgerservicenummer 555550005 wordt geraadpleegd
      Dan is er geen nationaliteithistorie-item met nationaliteit.code "0031"
  

  Rule: Er worden alleen nationaliteiten geleverd die geldig waren in de gevraagde periode of op de gevraagde peildatum

    Abstract Scenario: Vragen nationaliteithistorie met periode
      Gegeven de ingeschreven persoon met burgerservicenummer 999991188 kent de volgende nationaliteiten:
        | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
        | 2      | 4         |                       |                       | 401                      |                                    |                 | 20040201                        |
        | 2      | 54        | 0065                  | 301                   |                          |                                    |                 | 19310624                        |
      Als de nationaliteithistorie met burgerservicenummer "999991188" wordt gevraagd met datumVan="<datumVan>" en datumTotEnMet="<datumTotEnMet>"
      Dan bevat het antwoord <resultaat> de nationaliteit met code "0065"

      Voorbeelden:
        | omschrijving                                                | datumVan   | datumTotEnMet | resultaat |
        | periode voor de geldigheid                                  | 1931-01-01 | 1931-06-23    | niet      |
        | datumTotEnMet gelijk aan datumIngangGeldigheid              | 1931-01-01 | 1931-06-24    | wel       |
        | periode voor en in de geldigheid                            | 1931-01-01 | 2000-01-01    | wel       |
        | periode volledig in de geldigheid                           | 1990-01-01 | 2000-01-01    | wel       |
        | periode in en na in de geldigheid                           | 2004-01-01 | 2020-01-01    | wel       |
        | periode na in de geldigheid                                 | 2010-01-01 | 2020-01-01    | niet      |
        | datumVan gelijk aan de datumTot                             | 2004-02-01 | 2020-01-01    | niet      |

    Abstract Scenario: Vragen nationaliteithistorie met peildatum
      Gegeven de ingeschreven persoon met burgerservicenummer 999991188 kent de volgende nationaliteiten:
        | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
        | 2      | 4         |                       |                       | 401                      |                                    |                 | 20040201                        |
        | 2      | 54        | 0065                  | 301                   |                          |                                    |                 | 19310624                        |
      Als de nationaliteithistorie met burgerservicenummer "999991188" wordt gevraagd met peildatum="<peildatum>"
      Dan bevat het antwoord <resultaat> de nationaliteit met code "0065"

      Voorbeelden:
        | omschrijving                                          | peildatum  | resultaat |
        | peildatum voor de geldigheid                          | 1931-06-23 | niet      |
        | peildatum gelijk aan datumIngangGeldigheid            | 1931-06-24 | wel       |
        | peildatum in de geldigheid                            | 2000-01-01 | wel       |
        | peildatum gelijk aan de datumTot                      | 2004-02-01 | niet      |
        | peildatumna de geldigheid                             | 2020-01-01 | niet      |


  Rule: als datumVan is opgegeven en datumTotEnMet is niet opgegeven, worden alle nationaliteiten die geldig zijn of waren na datumVan geleverd

    Scenario: datumVan is opgegeven en datumTotEnMet is niet opgegeven
      Gegeven de ingeschreven persoon met burgerservicenummer 555550011 kent de volgende nationaliteiten:
        | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
        | 1      | 4         |                       |                       | 404                      |                                    |                 | 20150131                        |
        | 1      | 54        | 0307                  | 301                   |                          |                                    |                 | 19980911                        |
        | 2      | 4         | 0001                  | 000                   |                          |                                    |                 | 20141123                        |
      Als de nationaliteithistorie met burgerservicenummer 555550011 wordt gevraagd met datumVan="2014-01-01" en zonder datumTotEnMet
      Dan bevat het antwoord wel de nationaliteit met code "0307"
      En bevat het antwoord wel de nationaliteit met code "0001"


  Rule: als datumTotEnMet is opgegeven en datumVan is niet opgegeven, worden alle nationaliteiten die geldig waren voor datumTotEnMet geleverd

    Scenario: datumTotEnMet is opgegeven en datumVan is niet opgegeven
      Gegeven de ingeschreven persoon met burgerservicenummer 555550011 kent de volgende nationaliteiten:
        | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
        | 1      | 4         |                       |                       | 404                      |                                    |                 | 20150131                        |
        | 1      | 54        | 0307                  | 301                   |                          |                                    |                 | 19980911                        |
        | 2      | 4         | 0001                  | 000                   |                          |                                    |                 | 20141123                        |
      Als de nationaliteithistorie met burgerservicenummer 555550011 wordt gevraagd met datumTotEnMet="2016-01-01" en zonder datumTotEnMet
      Dan bevat het antwoord wel de nationaliteit met code "0307"
      En bevat het antwoord wel de nationaliteit met code "0001"


  Rule: de datumVan, datumTotEnMet en peildatum parameters mogen elkaar niet uitsluiten

    Abstract Scenario: combinatie van datumVan, datumTotEnMet en peildatum
      Gegeven de ingeschreven persoon met burgerservicenummer 999991188 kent de volgende nationaliteiten:
        | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
        | 2      | 4         |                       |                       | 401                      |                                    |                 | 20040201                        |
        | 2      | 54        | 0065                  | 301                   |                          |                                    |                 | 19310624                        |
      Als de nationaliteithistorie met burgerservicenummer "999991188" wordt gevraagd met <query>
      Dan is het resultaat <resultaat>

      Voorbeelden:
        | omschrijving              | query                                                             | resultaat                             |
        | datumVan na datumTotEnMet | datumVan=2003-01-01&datumTotEnMet=2002-12-31                      | een foutmelding met statuscode 400    |
        | peildatum buiten periode  | datumVan=2003-01-01&datumTotEnMet=2003-12-31&peildatum=2004-01-01 | een foutmelding met statuscode 400    |
        | peildatum binnen periode  | datumVan=2003-01-01&datumTotEnMet=2003-12-31&peildatum=2003-07-01 | de nationaliteithistorie op peildatum |


  Rule: datumVan, datumTotEnMet en peildatum mogen niet in de toekomst liggen
    Abstract Scenario: parameterwaarde in de toekomst
      Gegeven de ingeschreven persoon met burgerservicenummer 999991188 kent de volgende nationaliteiten:
        | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
        | 2      | 4         |                       |                       | 401                      |                                    |                 | 20040201                        |
        | 2      | 54        | 0065                  | 301                   |                          |                                    |                 | 19310624                        |
      Als de nationaliteithistorie met burgerservicenummer "999991188" wordt gevraagd met <query>
      Dan is het resultaat <resultaat>

      Voorbeelden:
        | omschrijving                 | query                                                             | resultaat                             |
        | datumTotEnMet in de toekomst | datumVan=2003-01-01&datumTotEnMet=2102-12-31                      | een foutmelding met statuscode 400    |
        | datumVan in de toekomst      | datumVan=2103-01-01                                               | een foutmelding met statuscode 400    |
        | peildatum in de toekomst     | peildatum=2103-01-01                                              | een foutmelding met statuscode 400    |


  Rule: Er moet minimaal een periode of peildatum worden opgegeven

    Scenario: geen datumVan, geen datumTotEnMet en geen peildatum opgegeven
      Gegeven de ingeschreven persoon met burgerservicenummer 999991188 kent de volgende nationaliteiten:
        | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
        | 2      | 4         |                       |                       | 401                      |                                    |                 | 20040201                        |
        | 2      | 54        | 0065                  | 301                   |                          |                                    |                 | 19310624                        |
      Als de nationaliteithistorie met burgerservicenummer "999991188" wordt zonder datumVan, datumTotEnMet en peildatum maar wel met de fields parameter
      Dan is het resultaat een foutmelding met statuscode 400

  
  Rule: Wanneer de datum ingang geldigheid gedeeltelijk onbekend is, wordt voor de filtering aangenomen dat de persoon gedurende de gehele onzekerheidstijd deze nationaliteit heeft gehad.

    Abstract Scenario: datumIngangGeldigheid geheel of gedeeltelijk onbekend en vragen op periode
      Gegeven de ingeschreven persoon met burgerservicenummer 999992806 kent de volgende nationaliteiten:
        | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
        | 1      | 4         | 0334                  | 301                   |                          |                                    |                 | 00000000                        |
      En de ingeschreven persoon met burgerservicenummer 555550006 kent de volgende nationaliteiten:
        | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
        | 1      | 4         | 0105                  | 301                   |                          |                                    |                 | 20010000                        |
      En de ingeschreven persoon met burgerservicenummer 555550007 kent de volgende nationaliteiten:
        | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
        | 1      | 4         | 0105                  | 301                   |                          |                                    |                 | 20140600                        |
      Als de nationaliteithistorie met burgerservicenummer "<burgerservicenummer>" wordt gevraagd met datumVan="<datumVan>" en datumTotEnMet="<datumTotEnMet>"
      Dan bevat het antwoord <resultaat> de nationaliteit met code "<code>"

      Voorbeelden:
        | omschrijving                                                                             | burgerservicenummer | datumVan   | datumTotEnMet | resultaat | code |
        | nationaliteit met volledig onbekende datum ingang                                        | 999992806           | 2021-01-01 | 2021-06-30    | wel       | 0334 |
        | nationaliteit met alleen jaar bekend in datum ingang en vragen tot dat jaar              | 555550006           | 2000-01-01 | 2001-01-01    | wel       | 0105 |
        | nationaliteit met alleen jaar bekend in datum ingang en vragen tot vorige jaar           | 555550006           | 2000-01-01 | 2000-12-31    | niet      | 0105 |
        | nationaliteit met alleen jaar en maand bekend in datum ingang en vragen tot die maand    | 555550007           | 2013-06-01 | 2014-06-01    | wel       | 0105 |
        | nationaliteit met alleen jaar en maand bekend in datum ingang en vragen tot vorige maand | 555550007           | 2013-06-01 | 2014-05-31    | niet      | 0105 |
        | nationaliteit met alleen jaar en maand bekend in datum ingang en vragen tot vorig jaar   | 555550007           | 2013-06-01 | 2013-07-01    | niet      | 0105 |

    Abstract Scenario: datumIngangGeldigheid geheel of gedeeltelijk onbekend en vragen op peildatum
      Gegeven de ingeschreven persoon met burgerservicenummer 999992806 kent de volgende nationaliteiten:
        | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
        | 1      | 4         | 0334                  | 301                   |                          |                                    |                 | 00000000                        |
      En de ingeschreven persoon met burgerservicenummer 999990998 kent de volgende nationaliteiten:
        | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
        | 1      | 4         |                       |                       | 404                      |                                    |                 | 20150131                        |
        | 1      | 54        | 0307                  | 301                   |                          |                                    |                 | 00000000                        |
      En de ingeschreven persoon met burgerservicenummer 555550006 kent de volgende nationaliteiten:
        | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
        | 1      | 4         | 0105                  | 301                   |                          |                                    |                 | 20010000                        |
      En de ingeschreven persoon met burgerservicenummer 555550007 kent de volgende nationaliteiten:
        | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
        | 1      | 4         | 0105                  | 301                   |                          |                                    |                 | 20140600                        |
      Als de nationaliteithistorie met burgerservicenummer "<burgerservicenummer>" wordt gevraagd met peildatum="<peildatum>"
      Dan bevat het antwoord <resultaat> de nationaliteit met code "<code>"

      Voorbeelden:
        | omschrijving                                                                            | burgerservicenummer | peildatum  | resultaat | code |
        | actuele nationaliteit met volledig onbekende datum ingang                               | 999992806           | 2021-06-30 | wel       | 0334 |
        | beëindigde nationaliteit met volledig onbekende datum ingang vragen voor datumTot       | 999990998           | 2015-01-01 | wel       | 0307 |
        | beëindigde nationaliteit met volledig onbekende datum ingang vragen na datumTot         | 999990998           | 2015-02-01 | niet      | 0307 |
        | nationaliteit met alleen jaar bekend in datum ingang en vragen in dat jaar              | 555550006           | 2001-01-01 | wel       | 0105 |
        | nationaliteit met alleen jaar bekend in datum ingang en vragen in vorige jaar           | 555550006           | 2000-12-31 | niet      | 0105 |
        | nationaliteit met alleen jaar en maand bekend in datum ingang en vragen in die maand    | 555550007           | 2014-06-01 | wel       | 0105 |
        | nationaliteit met alleen jaar en maand bekend in datum ingang en vragen in vorige maand | 555550007           | 2014-05-31 | niet      | 0105 |
        | nationaliteit met alleen jaar en maand bekend in datum ingang en vragen in vorig jaar   | 555550007           | 2013-07-01 | niet      | 0105 |

    Abstract Scenario: datumIngangGeldigheid onbekend bij een beëindigde nationaliteit en vragen op periode
      Gegeven de ingeschreven persoon met burgerservicenummer 999990998 kent de volgende nationaliteiten:
        | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
        | 1      | 4         |                       |                       | 404                      |                                    |                 | 20150131                        |
        | 1      | 54        | 0307                  | 301                   |                          |                                    |                 | 00000000                        |
      Als de nationaliteithistorie met burgerservicenummer "999990998" wordt gevraagd met datumVan="<datumVan>" en datumTotEnMet="<datumTotEnMet>"
      Dan bevat het antwoord <resultaat> de nationaliteit met code "0307"

      Voorbeelden:
        | omschrijving                                                                             | datumVan   | datumTotEnMet | resultaat |
        | beëindigde nationaliteit met volledig onbekende datum ingang vragen voor datumTot        | 2015-01-01 | 2016-01-31    | wel       |
        | beëindigde nationaliteit met volledig onbekende datum ingang vragen na datumTot          | 2015-02-01 | 2016-01-31    | niet      |

    Abstract Scenario: datumIngangGeldigheid onbekend bij een beëindigde nationaliteit en vragen op peildatum
      Gegeven de ingeschreven persoon met burgerservicenummer 999990998 kent de volgende nationaliteiten:
        | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
        | 1      | 4         |                       |                       | 404                      |                                    |                 | 20150131                        |
        | 1      | 54        | 0307                  | 301                   |                          |                                    |                 | 00000000                        |
      Als de nationaliteithistorie met burgerservicenummer "999990998" wordt gevraagd met peildatum="<peildatum>"
      Dan bevat het antwoord <resultaat> de nationaliteit met code "0307"

      Voorbeelden:
        | omschrijving                                                                            | peildatum  | resultaat |
        | beëindigde nationaliteit met volledig onbekende datum ingang vragen voor datumTot       | 2015-01-01 | wel       |
        | beëindigde nationaliteit met volledig onbekende datum ingang vragen na datumTot         | 2015-02-01 | niet      |


  Rule: Wanneer de datumTot gedeeltelijk onbekend is, wordt voor de filtering aangenomen dat de persoon gedurende de gehele onzekerheidstijd deze nationaliteit heeft gehad.

    Abstract Scenario: datumTot geheel of gedeeltelijk onbekend en vragen met periode
      Gegeven de ingeschreven persoon met burgerservicenummer 555550008 kent de volgende nationaliteiten:
        | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
        | 1      | 4         |                       |                       | 403                      |                                    |                 | 00000000                        |
        | 1      | 54        | 0222                  | 301                   |                          |                                    |                 | 19990317                        |
      En de ingeschreven persoon met burgerservicenummer 555550009 kent de volgende nationaliteiten:
        | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
        | 1      | 4         |                       |                       | 403                      |                                    |                 | 20030000                        |
        | 1      | 54        | 0222                  | 301                   |                          |                                    |                 | 19680317                        |
      En de ingeschreven persoon met burgerservicenummer 555550010 kent de volgende nationaliteiten:
        | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
        | 1      | 4         |                       |                       | 403                      |                                    |                 | 20030000                        |
        | 1      | 54        | 0222                  | 301                   |                          |                                    |                 | 20030317                        |
      En de ingeschreven persoon met burgerservicenummer 555550011 kent de volgende nationaliteiten:
        | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
        | 1      | 4         |                       |                       | 403                      |                                    |                 | 20070900                        |
        | 1      | 54        | 0222                  | 301                   |                          |                                    |                 | 19680317                        |
      Als de nationaliteithistorie met burgerservicenummer "<burgerservicenummer>" wordt gevraagd met datumVan="<datumVan>" en datumTotEnMet="<datumTotEnMet>"
      Dan bevat het antwoord <resultaat> de nationaliteit met code "0222"

      Voorbeelden:
        | omschrijving                                                                                                 | burgerservicenummer | datumVan   | datumTotEnMet | resultaat |
        | nationaliteit met volledig onbekende datumTot en vragen na datum ingang                                      | 555550008           | 1999-01-01 | 1999-03-31    | wel       |
        | nationaliteit met volledig onbekende datumTot en vragen voor datum ingang                                    | 555550008           | 1999-01-01 | 1999-03-01    | niet      |
        | nationaliteit met alleen jaar bekend van datumTot en vragen in dat jaar                                      | 555550009           | 2003-12-01 | 2003-12-31    | wel       |
        | nationaliteit met alleen jaar bekend van datumTot en vragen in volgend jaar                                  | 555550009           | 2004-01-01 | 2004-12-31    | niet      |
        | nationaliteit met alleen jaar bekend van datumTot en datum ingang in zelfde jaar en vragen na datum ingang   | 555550010           | 2003-01-01 | 2003-03-20    | wel       |
        | nationaliteit met alleen jaar bekend van datumTot en datum ingang in zelfde jaar en vragen voor datum ingang | 555550010           | 2003-01-01 | 2003-03-01    | niet      |


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
