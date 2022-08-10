# language: nl

Functionaliteit: Tonen van Nationaliteithistorie
  Huidige en voormalige nationaliteiten van ingeschreven personen kunnen worden geraadpleegd.

  # In onderstaande scenario's staat ten behoeve van de provider implementatie in Gegeven achter de veldnaam tussen haakjes de veldcode zoals deze in de bron volgens LO GBA is geregistreerd.
  # De historie van de registratie van nationaliteiten wordt bewaard in opeenvolgende categorievoorkomens.
  # Voor elke actuele of beëindigde nationaliteit is er 1 "actueel" categorievoorkomen en 0, 1 of meer "historische" categorievoorkomens.
  # De actuele categorie en de daarbijbehorende historische voorkomens zijn gegroepeerd in een stapel.
  # Een persoon kan meerdere nationaliteiten bezitten of hebben gehad, die elk gegroepeerd zijn op 1 stapel.
  # Het categorievoorkomen met categorie 4 is de actuele categorie, de categorievoorkomens met categorie 54 bevatten de historische gegevens.
  # Elk categorievoorkomen bevat de gegevens die vanaf de ingangsdatum gelden plus de registratiedatum.
  # Voor een beëindigde nationaliteit zit in de actuele categorie geen nationaliteit, omdat die op dat moment niet meer geldig is. De ingangsdatum in de actuele categorie is dan de datum vanaf wanneer de persoon deze nationaliteit niet meer had.

  # Geprobeerd scenario's zodanig te schrijven met als doel het beschrijven/documenteren van de gewenste functionaliteit

  Rule: Voor een actueel geldende nationaliteit of bijzonder Nederlanderschap wordt de datumIngangGeldigheid gevuld met de datum geldigheid (85.10) in de actuele categorie (04).
      
    Scenario: actueel en ongewijzigde nationaliteit
      Gegeven de ingeschreven persoon met burgerservicenummer 000009830 kent de volgende nationaliteiten:
        | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
        | 1      | 4         | 0001                  | 001                   |                          |                                    |                 | 19750707                        |
      Als de nationaliteithistorie met burgerservicenummer 000009830 wordt geraadpleegd
      Dan bevat het nationaliteithistorie-item met nationaliteit.code "0001" het gegeven "datumIngangGeldigheid" met datum "1975-07-07"

    # Vervangt bovenstaande scenario
    # kolommen zijn weggelaten die niet toedoen of niet relevant zijn voor deze scenario. Bijv. stapel, categorie, reden opnemen en lege velden
    # wat wordt bedoeld met actueel?
    # Wat wordt bedoeld met ongewijzigd? Wordt 'geen historische gegevens' bedoeld?
    # zou in dit geval 'persoon heeft op peildatum een nationaliteit zonder historische gegevens' geen betere titel zijn?
    # in de response is 'nationaliteiten' gebruikt als veld naam ipv nationaliteitHistorie zoals gespecificeerd in de OAS
    Scenario: persoon heeft alleen één actueel nationaliteit
      Gegeven een persoon met burgerservicenummer '000009830' heeft een 'nationaliteit' met de volgende gegevens
      | nationaliteit (05.10) | datum ingang geldigheid (85.10) |
      | 0001                  | 19750707                        |
      Als nationaliteithistorie wordt geraadpleegd met de volgende parameters
      | naam                | waarde                                                                   |
      | type                | RaadpleegMetPeildatum                                                    |
      | burgerservicenummer | 000009830                                                                |
      | peildatum           | 2022-08-01                                                               |
      | fields              | nationaliteiten.nationaliteit.code,nationaliteiten.datumIngangGeldigheid |
      Dan heeft de response de volgende 'nationaliteiten'
      | type          | nationaliteit.code | datumIngangGeldigheid.type | datumIngangGeldigheid.datum | datumIngangGeldigheid.langFormaat |
      | Nationaliteit | 0001               | Datum                      | 1975-07-07                  | 7 juli 1975                       |

    # het is niet duidelijk wat met deze scenario wordt beschreven/uitgelegd. Waarom zou nationaliteit met code 0307 een onbekende datum ingang geldigheid hebben? De onbekende datum is volgens de gegeven stap niet-actueel (historisch) 
    Scenario: nationaliteit met onbekende datum ingang geldigheid
      Gegeven de ingeschreven persoon met burgerservicenummer 999990998 kent de volgende nationaliteiten:
        | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
        | 1      | 4         |                       |                       | 404                      |                                    |                 | 20150131                        |
        | 1      | 54        | 0307                  | 301                   |                          |                                    |                 | 00000000                        |
        | 2      | 4         | 0001                  | 000                   |                          |                                    |                 | 00000000                        |
      Als de nationaliteithistorie met burgerservicenummer 999990998 wordt geraadpleegd
      Dan bevat het nationaliteithistorie-item met nationaliteit.code "0307" geen gegeven "datumIngangGeldigheid"
      En bevat het nationaliteithistorie-item met nationaliteit.code "0001" geen gegeven "datumIngangGeldigheid"

    Scenario: geactualiseerde ingangsdatum geldigheid
      Gegeven de ingeschreven persoon met burgerservicenummer 555550004 kent de volgende nationaliteiten:
        | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
        | 1      | 4         | 0100                  | 311                   |                          |                                    |                 | 20200727                        |
        | 1      | 54        | 0100                  | 311                   |                          |                                    | O               | 20200713                        |
      Als de nationaliteithistorie met burgerservicenummer 555550004 wordt geraadpleegd
      Dan bevat het nationaliteithistorie-item met nationaliteit.code "0100" het gegeven "datumIngangGeldigheid" met datum "2020-07-27"

    # Vervangt bovenstaande scenario
    # hier is categorie wel toegevoegd om te weten welke datum ingang geldigheid actueel is en welke historisch
    # vraag: niet duidelijk of het relevant is om de onjuist kolom op te nemen in de historische rij. Voor het bepalen van de gegevens die voor de nationaliteit moet worden geretourneerd lijkt het niet relevant
    Scenario: persoon heeft een nationaliteit met geactualiseerde datum ingang geldigheid
      Gegeven een persoon met burgerservicenummer '555550004' heeft een 'nationaliteit' met de volgende gegevens
      | categorie | nationaliteit (05.10) | datum ingang geldigheid (85.10) |
      | 4         | 0100                  | 20200727                        |
      | 54        | 0100                  | 20200713                        |
      Als nationaliteithistorie wordt geraadpleegd met de volgende parameters
      | naam                | waarde                                                                   |
      | type                | RaadpleegMetPeildatum                                                    |
      | burgerservicenummer | 555550004                                                                |
      | peildatum           | 2022-08-01                                                               |
      | fields              | nationaliteiten.nationaliteit.code,nationaliteiten.datumIngangGeldigheid |
      Dan heeft de response de volgende 'nationaliteiten'
      | type          | nationaliteit.code | datumIngangGeldigheid.type | datumIngangGeldigheid.datum | datumIngangGeldigheid.langFormaat |
      | Nationaliteit | 0100               | Datum                      | 2020-07-27                  | 27 juli 2020                      |

    # in oude scenario's wordt volgens mij stapel gebruikt om aan te geven welke rijen bij elkaar horen. Dit zou ook kunnen op de manier zoals in deze scenario met de gegeven: En de persoon heeft een andere 'nationaliteit' met de volgende gegevens
    Scenario: persoon heeft meerdere actuele nationaliteiten
      Gegeven een persoon met burgerservicenummer '999990998' heeft een 'nationaliteit' met de volgende gegevens
      | nationaliteit (05.10) | datum ingang geldigheid (85.10) |
      | 0307                  | 20150131                        |
      En de persoon heeft een ander 'nationaliteit' met de volgende gegevens
      | nationaliteit (05.10) | datum ingang geldigheid (85.10) |
      | 0001                  | 19750707                        |
      Als nationaliteithistorie wordt geraadpleegd met de volgende parameters
      | naam                | waarde                                                                   |
      | type                | RaadpleegMetPeildatum                                                    |
      | burgerservicenummer | 999990998                                                                |
      | peildatum           | 2022-08-01                                                               |
      | fields              | nationaliteiten.nationaliteit.code,nationaliteiten.datumIngangGeldigheid |
      Dan heeft de response de volgende 'nationaliteiten'
      | type          | nationaliteit.code | datumIngangGeldigheid.type | datumIngangGeldigheid.datum | datumIngangGeldigheid.langFormaat |
      | Nationaliteit | 0307               | Datum                      | 2015-01-31                  | 31 januari 2015                   |
      | Nationaliteit | 0001               | Datum                      | 1975-07-07                  | 7 juli 1975                       |

    # vervangt mogelijk scenario (regel 175): beëindigde registratie vreemde nationaliteit na verkrijgen Nederlandse nationaliteit
    Scenario: persoon heeft een beëindigde nationaliteit op peildatum
      Gegeven een persoon met burgerservicenummer '999993008' heeft een 'nationaliteit' met de volgende gegevens
      | nationaliteit (05.10) | datum ingang geldigheid (85.10) |
      | 0001                  | 20050316                        |
      En de persoon heeft een ander 'nationaliteit' met de volgende gegevens
      | categorie | nationaliteit (05.10) | datum ingang geldigheid (85.10) | reden beëindigen (64.10) |
      | 4         |                       | 20050131                        | 404                      |
      | 54        | 0131                  | 19750501                        |                          |
      Als nationaliteithistorie wordt geraadpleegd met de volgende parameters
      | naam                | waarde                                                                                            |
      | type                | RaadpleegMetPeildatum                                                                             |
      | burgerservicenummer | 999993008                                                                                         |
      | peildatum           | 2005-01-01                                                                                        |
      | fields              | nationaliteiten.nationaliteit.code,nationaliteiten.datumIngangGeldigheid,nationaliteiten.datumTot |
      Dan heeft de response de volgende 'nationaliteiten'
      | type          | nationaliteit.code | datumIngangGeldigheid.type | datumIngangGeldigheid.datum | datumIngangGeldigheid.langFormaat | datumTot.type | datumTot.datum | datumTot.langFormaat |
      | Nationaliteit | 0131               | Datum                      | 1975-05-01                  | 1 mei 1975                        | Datum         | 2005-01-31     | 31 januari 2005      |

  # indicatieNationaliteitBeeindigd komt niet voor in de OAS. Is dit nog nodig?
  Rule: In het antwoord wordt indicatieNationaliteitBeeindigd opgenomen met de waarde true, wanneer in de actuele nationaliteit (categorie 04) GEEN nationaliteit (05.10) en GEEN bijzonder Nederlanderschap (65.10) is opgenomen.

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


  Rule: Voor een beëindigde nationaliteit of beëindigd bijzonder Nederlanderschap worden de nationaliteit, aanduidingBijzonderNederlanderschap, redenOpname en datumIngangGeldigheid overgenomen uit de jongste bijbehorende historische categorie (54) waarin deze voorkomen en die niet onjuist is.

    Scenario: beëindigde registratie vreemde nationaliteit na verkrijgen Nederlandse nationaliteit
      Gegeven de ingeschreven persoon met burgerservicenummer 999993008 kent de volgende nationaliteiten:
        | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
        | 1      | 4         | 0001                  | 027                   |                          |                                    |                 | 20050316                        |
        | 2      | 4         |                       |                       | 404                      |                                    |                 | 20050131                        |
        | 2      | 54        | 0131                  | 301                   |                          |                                    |                 | 19750501                        |
      Als de nationaliteithistorie met burgerservicenummer 999993008 wordt geraadpleegd
      Dan bevat het nationaliteithistorie-item met nationaliteit.code "0131" de volgende gegevens:
        | nationaliteit.code | redenOpname.code | redenBeeindigen.code | datumIngangGeldigheid.datum |
        | 0131               | 301              | 404                  | 1975-05-01                  |

    Scenario: verlies vreemde nationaliteit
      Gegeven de ingeschreven persoon met burgerservicenummer 999991188 kent de volgende nationaliteiten:
        | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
        | 1      | 4         | 0499                  | 312                   |                          |                                    |                 | 20040201                        |
        | 2      | 4         |                       |                       | 401                      |                                    |                 | 20040201                        |
        | 2      | 54        | 0065                  | 301                   |                          |                                    |                 | 19310624                        |
      Als de nationaliteithistorie met burgerservicenummer 999991188 wordt geraadpleegd
      Dan bevat het nationaliteithistorie-item met nationaliteit.code "0065" de volgende gegevens:
        | nationaliteit.code | redenOpname.code | redenBeeindigen.code | datumIngangGeldigheid.datum |
        | 0065               | 301              | 401                  | 1931-06-24                  |

    Scenario: verlies bijzonder Nederlanderschap
      Gegeven de ingeschreven persoon met burgerservicenummer 555550002 kent de volgende nationaliteiten:
        | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
        | 1      | 4         |                       |                       | 410                      |                                    |                 | 20190604                        |
        | 1      | 54        |                       | 310                   |                          | B                                  |                 | 20010319                        |
        | 2      | 4         | 0214                  | 301                   |                          |                                    |                 | 20190604                        |
      Als de nationaliteithistorie met burgerservicenummer 555550002 wordt geraadpleegd
      Dan bevat het nationaliteithistorie-item met aanduidingBijzonderNederlanderschap "vastgesteld_niet_nederlander" de volgende gegevens:
        | aanduidingBijzonderNederlanderschap | redenOpname.code | redenBeeindigen.code | datumIngangGeldigheid.datum |
        | vastgesteld_niet_nederlander        | 301              | 410                  | 2001-03-19                  |

    Scenario: gewijzigde reden beëindigen
      Gegeven de ingeschreven persoon met burgerservicenummer 999994657 kent de volgende nationaliteiten:
        | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
        | 1      | 4         |                       |                       | 404                      |                                    |                 | 20140601                        |
        | 1      | 54        |                       |                       | 401                      |                                    | O               | 19940601                        |
        | 1      | 54        | 0100                  | 301                   |                          |                                    |                 | 19890301                        |
        | 2      | 4         | 0001                  | 030                   |                          |                                    |                 | 19910201                        |
      Als de nationaliteithistorie met burgerservicenummer 999994657 wordt geraadpleegd
      Dan bevat het nationaliteithistorie-item met nationaliteit.code "0100" de volgende gegevens:
        | nationaliteit.code | redenOpname.code | redenBeeindigen.code | datumIngangGeldigheid.datum |
        | 0100               | 301              | 401                  | 1989-03-01                  |

    Scenario: gewijzigde reden opnemen en gewijzigde reden beëindigen
      Gegeven de ingeschreven persoon met burgerservicenummer 555550014 kent de volgende nationaliteiten:
        | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
        | 1      | 4         |                       |                       | 404                      |                                    |                 | 20190821                        |
        | 1      | 54        |                       |                       | 401                      |                                    | O               | 20190821                        |
        | 1      | 54        | 0264                  | 301                   |                          |                                    |                 | 20160417                        |
        | 1      | 54        | 0264                  | 311                   |                          |                                    | O               | 20160417                        |
      Als de nationaliteithistorie met burgerservicenummer 555550014 wordt geraadpleegd
      Dan bevat het nationaliteithistorie-item met nationaliteit.code "0264" de volgende gegevens:
        | nationaliteit.code | redenOpname.code | redenBeeindigen.code | datumIngangGeldigheid.datum |
        | 0264               | 301              | 404                  | 2016-04-17                  |

    Scenario: geactualiseerde geldigheid
      Gegeven de ingeschreven persoon met burgerservicenummer 555550015 kent de volgende nationaliteiten:
        | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
        | 1      | 4         |                       |                       | 404                      |                                    |                 | 20200305                        |
        | 1      | 4         | 0400                  | 301                   |                          |                                    |                 | 20170417                        |
        | 1      | 54        | 0400                  | 301                   |                          |                                    | O               | 20160417                        |
      Als de nationaliteithistorie met burgerservicenummer 555550015 wordt geraadpleegd
      Dan bevat het nationaliteithistorie-item met nationaliteit.code "0400" de volgende gegevens:
        | nationaliteit.code | redenOpname.code | redenBeeindigen.code | datumIngangGeldigheid.datum |
        | 0400               | 301              | 404                  | 2017-04-17                  |


  Rule: Voor een beëindigde nationaliteit of beëindigd bijzonder Nederlanderschap wordt de redenBeeindigen overgenomen uit de actuele categorie (04).

    Scenario: gewijzigde reden beëindigen
      Gegeven de ingeschreven persoon met burgerservicenummer 999994657 kent de volgende nationaliteiten:
        | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
        | 1      | 4         |                       |                       | 404                      |                                    |                 | 20140601                        |
        | 1      | 54        |                       |                       | 401                      |                                    |                 | 19940601                        |
        | 1      | 54        | 0100                  | 301                   |                          |                                    |                 | 19890301                        |
        | 2      | 4         | 0001                  | 030                   |                          |                                    |                 | 19910201                        |
      Als de nationaliteithistorie met burgerservicenummer 999994657 wordt geraadpleegd
      Dan bevat het nationaliteithistorie-item met nationaliteit.code "0100" het gegeven "redenBeeindigen" met code "404"

  
  Rule: Voor een beëindigde nationaliteit wordt datumTot gevuld met de datum geldigheid (85.10) uit de actuele categorie (04).

    Scenario: gewijzigde reden beëindigen
      Gegeven de ingeschreven persoon met burgerservicenummer 999994657 kent de volgende nationaliteiten:
        | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
        | 1      | 4         |                       |                       | 404                      |                                    |                 | 20140601                        |
        | 1      | 54        |                       |                       | 401                      |                                    |                 | 19940601                        |
        | 1      | 54        | 0100                  | 301                   |                          |                                    |                 | 19890301                        |
        | 2      | 4         | 0001                  | 030                   |                          |                                    |                 | 19910201                        |
      Als de nationaliteithistorie met burgerservicenummer 999994657 wordt geraadpleegd
      Dan bevat het nationaliteithistorie-item met nationaliteit.code "0100" het gegeven "datumTot" met datum "2014-06-01"

    Scenario: actuele nationaliteit
      Gegeven de ingeschreven persoon met burgerservicenummer 000009830 kent de volgende nationaliteiten:
        | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
        | 1      | 4         | 0001                  | 001                   |                          |                                    |                 | 19750707                        |
      Als de nationaliteithistorie met burgerservicenummer 000009830 wordt geraadpleegd
      Dan bevat het nationaliteithistorie-item met nationaliteit.code "0001" geen gegeven "datumTot"
  

  Rule: Een beëindigde nationaliteit met reden beëindigen "Correctie in verband met ten onrechte BE opgenomen gegevens" (405) wordt niet opgenomen
    
    Scenario: ten onrechte opgenomen nationaliteit
      Gegeven de ingeschreven persoon met burgerservicenummer 555550005 kent de volgende nationaliteiten:
        | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
        | 1      | 4         | 0001                  | 189                   |                          |                                    |                 | 20180210                        |
        | 2      | 4         |                       |                       | 405                      |                                    |                 | 20181014                        |
        | 2      | 54        | 0031                  | 301                   |                          |                                    | O               | 20160526                        |
      Als de nationaliteithistorie met burgerservicenummer 555550005 wordt geraadpleegd
      Dan bevat het antwoord 1 item(s) voor nationaliteithistorie
      En bevat het antwoord wel de nationaliteit met code "0001"
      En bevat het antwoord niet de nationaliteit met code "0031"
  

  Rule: Wanneer (registratie van) een nationaliteit is beëindigd en daarna weer wordt opgenomen, worden beide periodes dat de nationaliteit geldig was opgenomen.

    Scenario: verlies Nederlanderschap verwerkt als actualisering vreemde nationaliteit met een nieuwe datum geldigheid
      Gegeven de ingeschreven persoon met burgerservicenummer 555550012 kent de volgende nationaliteiten:
        | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
        | 1      | 4         | 0131                  | 301                   |                          |                                    |                 | 20210604                        |
        | 1      | 54        |                       |                       | 404                      |                                    |                 | 20190516                        |
        | 1      | 54        | 0131                  | 301                   |                          |                                    |                 | 20010319                        |
        | 2      | 4         |                       |                       | 192                      |                                    |                 | 20210604                        |
        | 2      | 54        | 0001                  | 017                   |                          |                                    |                 | 20190516                        |
      Als de nationaliteithistorie met burgerservicenummer 555550012 wordt geraadpleegdbevat het antwoord 3 voorkomens
      En wordt de nationaliteithistorie teruggegeven met waarden:
      | # | nationaliteit.code | datumIngangGeldigheid | datumTot   | indicatieNationaliteitBeeindigd | redenOpname.code | redenBeeindigen.code |
      | 0 | 0131               | 2021-06-04            |            |                                 | 301              |                      |
      | 1 | 0001               | 2019-05-16            | 2021-06-04 | true                            | 017              | 192                  |
      | 1 | 0131               | 2001-03-19            | 2019-05-16 | true                            | 301              | 404                  |

    Scenario: verlies Nederlanderschap verwerkt als correctieprocedure
      Gegeven de ingeschreven persoon met burgerservicenummer 555550013 kent de volgende nationaliteiten:
        | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
        | 1      | 4         | 0131                  | 301                   |                          |                                    |                 | 20010319                        |
        | 1      | 54        |                       |                       | 404                      |                                    | O               | 20190516                        |
        | 1      | 54        | 0131                  | 301                   |                          |                                    |                 | 20010319                        |
        | 2      | 4         |                       |                       | 192                      |                                    |                 | 20210604                        |
        | 2      | 54        | 0001                  | 017                   |                          |                                    |                 | 20190516                        |
      Als de nationaliteithistorie met burgerservicenummer 555550013 wordt geraadpleegdbevat het antwoord 3 voorkomens
      En wordt de nationaliteithistorie teruggegeven met waarden:
      | # | nationaliteit.code | datumIngangGeldigheid | datumTot   | indicatieNationaliteitBeeindigd | redenOpname.code | redenBeeindigen.code |
      | 0 | 0131               | 2001-03-19            |            |                                 | 301              |                      |
      | 1 | 0001               | 2019-05-16            | 2021-06-04 | true                            | 017              | 192                  |


  Rule: Er worden alleen nationaliteiten geleverd die geldig waren in de gevraagde periode of op de gevraagde peildatum

    Abstract Scenario: Vragen nationaliteithistorie met <omschrijving> van de nationaliteit
      Gegeven de ingeschreven persoon met burgerservicenummer 999991188 kent de volgende nationaliteiten:
        | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
        | 2      | 4         |                       |                       | 401                      |                                    |                 | 20040201                        |
        | 2      | 54        | 0065                  | 301                   |                          |                                    |                 | 19310624                        |
      Als de nationaliteithistorie met burgerservicenummer "999991188" wordt gevraagd met datumVan="<datumVan>" en datumTotEnMet="<datumTotEnMet>"
      Dan bevat het antwoord <resultaat> de nationaliteit met code "0065"

      Voorbeelden:
        | omschrijving                                   | datumVan   | datumTotEnMet | resultaat |
        | periode voor de geldigheid                     | 1931-01-01 | 1931-06-23    | niet      |
        | datumTotEnMet gelijk aan datumIngangGeldigheid | 1931-01-01 | 1931-06-24    | wel       |
        | periode voor en in de geldigheid               | 1931-01-01 | 2000-01-01    | wel       |
        | periode volledig in de geldigheid              | 1990-01-01 | 2000-01-01    | wel       |
        | periode in en na in de geldigheid              | 2004-01-01 | 2020-01-01    | wel       |
        | periode na in de geldigheid                    | 2010-01-01 | 2020-01-01    | niet      |
        | datumVan gelijk aan de datumTot                | 2004-02-01 | 2020-01-01    | niet      |

    Abstract Scenario: Vragen nationaliteithistorie met peildatum <omschrijving> van de nationaliteit
      Gegeven de ingeschreven persoon met burgerservicenummer 999991188 kent de volgende nationaliteiten:
        | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
        | 2      | 4         |                       |                       | 401                      |                                    |                 | 20040201                        |
        | 2      | 54        | 0065                  | 301                   |                          |                                    |                 | 19310624                        |
      Als de nationaliteithistorie met burgerservicenummer "999991188" wordt gevraagd met peildatum="<peildatum>"
      Dan bevat het antwoord <resultaat> de nationaliteit met code "0065"

      Voorbeelden:
        | omschrijving                     | peildatum  | resultaat |
        | voor de geldigheid               | 1931-06-23 | niet      |
        | gelijk aan datumIngangGeldigheid | 1931-06-24 | wel       |
        | in de geldigheid                 | 2000-01-01 | wel       |
        | gelijk aan de datumTot           | 2004-02-01 | niet      |
        | na de geldigheid                 | 2020-01-01 | niet      |


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

    Abstract Scenario: combinatie van datumVan, datumTotEnMet en peildatum met <omschrijving>
      Gegeven de ingeschreven persoon met burgerservicenummer 999991188 kent de volgende nationaliteiten:
        | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
        | 1      | 4         | 0499                  | 312                   |                          |                                    |                 | 20040201                        |
        | 2      | 4         |                       |                       | 401                      |                                    |                 | 20040201                        |
        | 2      | 54        | 0065                  | 301                   |                          |                                    |                 | 19310624                        |
      Als de nationaliteithistorie met burgerservicenummer "999991188" wordt gevraagd met <query>
      Dan is het resultaat <resultaat>

      Voorbeelden:
        | omschrijving              | query                                                             | resultaat                                                              |
        | datumVan na datumTotEnMet | datumVan=2003-01-01&datumTotEnMet=2002-12-31                      | een foutmelding met statuscode 400                                     |
        | peildatum buiten periode  | datumVan=2003-01-01&datumTotEnMet=2003-12-31&peildatum=2004-01-01 | een foutmelding met statuscode 400                                     |
        | peildatum binnen periode  | datumVan=2003-01-01&datumTotEnMet=2004-12-31&peildatum=2003-07-01 | de nationaliteit met code "0065" en geen nationaliteit met code "0499" |


  Rule: datumVan, datumTotEnMet en peildatum mogen niet in de toekomst liggen

    Abstract Scenario: <parameter> in de toekomst
      Gegeven de ingeschreven persoon met burgerservicenummer 999991188 kent de volgende nationaliteiten:
        | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
        | 1      | 4         | 0499                  | 312                   |                          |                                    |                 | 20040201                        |
        | 2      | 4         |                       |                       | 401                      |                                    |                 | 20040201                        |
        | 2      | 54        | 0065                  | 301                   |                          |                                    |                 | 19310624                        |
      Als de nationaliteithistorie met burgerservicenummer "999991188" wordt gevraagd met <query>
      Dan is het resultaat <resultaat>

      Voorbeelden:
        | parameter     | query                                        | resultaat                          |
        | datumTotEnMet | datumVan=2003-01-01&datumTotEnMet=2102-12-31 | een foutmelding met statuscode 400 |
        | datumVan      | datumVan=2103-01-01                          | een foutmelding met statuscode 400 |
        | peildatum     | peildatum=2103-01-01                         | een foutmelding met statuscode 400 |


  Rule: Er moet minimaal een periode of peildatum worden opgegeven

    Scenario: geen datumVan, geen datumTotEnMet en geen peildatum opgegeven
      Gegeven de ingeschreven persoon met burgerservicenummer 999991188 kent de volgende nationaliteiten:
        | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
        | 2      | 4         |                       |                       | 401                      |                                    |                 | 20040201                        |
        | 2      | 54        | 0065                  | 301                   |                          |                                    |                 | 19310624                        |
      Als de nationaliteithistorie met burgerservicenummer "999991188" wordt zonder datumVan, datumTotEnMet en peildatum maar wel met de fields parameter
      Dan is het resultaat een foutmelding met statuscode 400

  
  Rule: Wanneer de datum ingang geldigheid gedeeltelijk onbekend is, wordt voor de filtering aangenomen dat de persoon gedurende de gehele onzekerheidstijd deze nationaliteit heeft gehad.

    Abstract Scenario: vragen op periode bij een nationaliteit met <situatie> en vragen <periode>
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
        | situatie                                    | periode                  | burgerservicenummer | datumVan   | datumTotEnMet | resultaat | code |
        | volledig onbekende datum ingang             | voor een periode         | 999992806           | 2021-01-01 | 2021-06-30    | wel       | 0334 |
        | alleen jaar bekend in datum ingang          | tot 1e dag van dat jaar  | 555550006           | 2000-01-01 | 2001-01-01    | wel       | 0105 |
        | alleen jaar bekend in datum ingang          | tot vorige jaar          | 555550006           | 2000-01-01 | 2000-12-31    | niet      | 0105 |
        | alleen jaar en maand bekend in datum ingang | tot 1e dag van die maand | 555550007           | 2013-06-01 | 2014-06-01    | wel       | 0105 |
        | alleen jaar en maand bekend in datum ingang | tot volgende maand       | 555550007           | 2013-06-01 | 2014-07-31    | wel       | 0105 |
        | alleen jaar en maand bekend in datum ingang | tot vorige maand         | 555550007           | 2013-06-01 | 2014-05-31    | niet      | 0105 |
        | alleen jaar en maand bekend in datum ingang | tot vorig jaar           | 555550007           | 2013-06-01 | 2013-07-01    | niet      | 0105 |

    Abstract Scenario: <status> nationaliteit met datumIngangGeldigheid <ingang geldigheid> en vragen op peildatum <omschrijving peildatum>
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
        | status     | ingang geldigheid           | omschrijving peildatum | burgerservicenummer | peildatum  | resultaat | code |
        | actuele    | volledig onbekend           |                        | 999992806           | 2021-06-30 | wel       | 0334 |
        | beëindigde | volledig onbekend           | voor datumTot          | 999990998           | 2015-01-01 | wel       | 0307 |
        | beëindigde | volledig onbekend           | na datumTot            | 999990998           | 2015-02-01 | niet      | 0307 |
        | actuele    | alleen jaar bekend          | in dat jaar            | 555550006           | 2001-01-01 | wel       | 0105 |
        | actuele    | alleen jaar bekend          | in vorige jaar         | 555550006           | 2000-12-31 | niet      | 0105 |
        | actuele    | alleen jaar en maand bekend | in die maand           | 555550007           | 2014-06-01 | wel       | 0105 |
        | actuele    | alleen jaar en maand bekend | in vorige maand        | 555550007           | 2014-05-31 | niet      | 0105 |
        | actuele    | alleen jaar en maand bekend | in vorig jaar          | 555550007           | 2013-07-01 | niet      | 0105 |

    Abstract Scenario: datumIngangGeldigheid onbekend bij een beëindigde nationaliteit en vragen op periode <omschrijving>
      Gegeven de ingeschreven persoon met burgerservicenummer 999990998 kent de volgende nationaliteiten:
        | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
        | 1      | 4         |                       |                       | 404                      |                                    |                 | 20150131                        |
        | 1      | 54        | 0307                  | 301                   |                          |                                    |                 | 00000000                        |
      Als de nationaliteithistorie met burgerservicenummer "999990998" wordt gevraagd met datumVan="<datumVan>" en datumTotEnMet="<datumTotEnMet>"
      Dan bevat het antwoord <resultaat> de nationaliteit met code "0307"

      Voorbeelden:
        | omschrijving  | datumVan   | datumTotEnMet | resultaat |
        | voor datumTot | 2015-01-01 | 2016-01-31    | wel       |
        | na datumTot   | 2015-02-01 | 2016-01-31    | niet      |

    Abstract Scenario: datumIngangGeldigheid onbekend bij een beëindigde nationaliteit en vragen op peildatum <omschrijving>
      Gegeven de ingeschreven persoon met burgerservicenummer 999990998 kent de volgende nationaliteiten:
        | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
        | 1      | 4         |                       |                       | 404                      |                                    |                 | 20150131                        |
        | 1      | 54        | 0307                  | 301                   |                          |                                    |                 | 00000000                        |
      Als de nationaliteithistorie met burgerservicenummer "999990998" wordt gevraagd met peildatum="<peildatum>"
      Dan bevat het antwoord <resultaat> de nationaliteit met code "0307"

      Voorbeelden:
        | omschrijving  | peildatum  | resultaat |
        | voor datumTot | 2015-01-01 | wel       |
        | na datumTot   | 2015-02-01 | niet      |


  Rule: Wanneer de datumTot gedeeltelijk onbekend is, wordt voor de filtering aangenomen dat de persoon gedurende de gehele onzekerheidstijd deze nationaliteit heeft gehad.

    Abstract Scenario: nationaliteit met datumTot <datumTot> en vragen <periode>
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
        | datumTot                                            | periode           | burgerservicenummer | datumVan   | datumTotEnMet | resultaat |
        | volledig onbekend                                   | na datum ingang   | 555550008           | 1999-01-01 | 1999-03-31    | wel       |
        | volledig onbekend                                   | voor datum ingang | 555550008           | 1999-01-01 | 1999-03-01    | niet      |
        | alleen jaar bekend                                  | in dat jaar       | 555550009           | 2003-12-01 | 2003-12-31    | wel       |
        | alleen jaar bekend                                  | in volgend jaar   | 555550009           | 2004-01-01 | 2004-12-31    | niet      |
        | alleen jaar bekend gelijk aan jaar van datum ingang | na datum ingang   | 555550010           | 2003-01-01 | 2003-03-20    | wel       |
        | alleen jaar bekend gelijk aan jaar van datum ingang | voor datum ingang | 555550010           | 2003-01-01 | 2003-03-01    | niet      |


Rule: In het antwoord worden eerst de actuele nationaliteiten opgenomen, gevolgd door de beëindigde nationaliteiten (gesorteerd op indicatieNationaliteitBeeindigd). Daarbinnen worden resultaten aflopend gesorteerd op datumTot en vervolgens aflopend gesorteerd op datumIngangGeldigheid.

    Scenario: actuele en beëindigde nationaliteiten in de juiste volgorde
      Gegeven de ingeschreven persoon met burgerservicenummer 999991292 kent de volgende nationaliteiten:
        | Stapel | Categorie | 05.10                 | 65.10                 | 64.10                    | 85.10                              |
        | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
        | 1      | 04        |                       |                       | 404                      |                                    |                 | 19940601                        |
        | 1      | 54        | 0100                  |                       |                          |                                    |                 | 19890301                        |
        | 2      | 04        | 0001                  |                       |                          |                                    |                 | 19910201                        |
        | 3      | 04        |                       |                       | 404                      |                                    |                 | 20140601                        |
        | 3      | 54        | 0057                  |                       |                          |                                    |                 | 19831213                        |
      Als de nationaliteithistorie met burgerservicenummer 999991292 wordt geraadpleegd
      Dan bevat het antwoord 3 voorkomens
      En wordt de nationaliteithistorie teruggegeven in de volgorde en met waarden:
      | # | nationaliteit.code | aanduidingBijzonderNederlanderschap | datumIngangGeldigheid | datumTot   | indicatieNationaliteitBeeindigd | redenBeeindigen.code |
      | 0 | 0001               |                                     | 1991-02-01            |            |                                 |                      |
      | 1 | 0057               |                                     | 1983-12-13            | 2014-06-01 | true                            | 404                  |
      | 2 | 0100               |                                     | 1989-03-01            | 1994-06-01 | true                            | 404                  |


  Rule: bij sorteren wordt een nationaliteit met volledig onbekende datum ingang of datum tot geplaatst onder de nationaliteit(en) met een bekende datum

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
      | # | nationaliteit.code | aanduidingBijzonderNederlanderschap | datumIngangGeldigheid | datumTot   | indicatieNationaliteitBeeindigd | redenBeeindigen.code |
      | 0 | 0100               | vastgesteld_niet_nederlander        | 2000-01-14            |            |                                 |                      |
      | 1 | 0334               |                                     |                       |            |                                 |                      |
      | 2 | 0331               |                                     | 1983-12-13            | 2000-01-14 | true                            | 404                  |

  Rule: voor sorteren wordt bij een gedeeltelijk onbekende datum ingang of datum tot de eerste dag van de onzekerheidsperiode gebruikt

    Abstract Scenario: nationaliteiten met gedeeltelijk onbekende datum tot 
      Gegeven de ingeschreven persoon met burgerservicenummer 555550016 kent de volgende nationaliteiten:
        | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
        | 1      | 4         |                       |                       | 404                      |                                    |                 | 20150102                        |
        | 1      | 54        | 0334                  | 301                   |                          |                                    |                 | 19670311                        |
        | 2      | 4         |                       |                       | 401                      |                                    |                 | 20150000                        |
        | 2      | 54        | 0223                  | 301                   |                          |                                    |                 | 19851203                        |
        | 3      | 4         |                       |                       | 401                      |                                    |                 | 20150100                        |
        | 3      | 54        | 0331                  | 301                   |                          |                                    |                 | 19930422                        |
        | 4      | 4         | 0001                  | 017                   |                          |                                    |                 | 20150102                        |
      Als de nationaliteithistorie met burgerservicenummer 555550016 wordt geraadpleegd
      Dan bevat het antwoord 4 voorkomens
      En wordt de nationaliteithistorie teruggegeven in de volgorde en met waarden:
      | # | nationaliteit.code | datumIngangGeldigheid | datumTot.jaar | datumTot.maand | datumTot.dag | indicatieNationaliteitBeeindigd |
      | 0 | 0001               | 2015-01-02            |               |                |              |                                 |
      | 1 | 0334               | 1967-03-11            | 2015          | 1              | 2            | true                            |
      | 2 | 0331               | 1993-04-22            | 2015          | 1              |              | true                            |
      | 3 | 0223               | 1985-12-03            | 2015          |                |              | true                            |

    Abstract Scenario: nationaliteiten met gedeeltelijk onbekende datum ingang 
      Gegeven de ingeschreven persoon met burgerservicenummer 555550017 kent de volgende nationaliteiten:
        | Stapel | Categorie | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | bijzonder Nederlanderschap (65.10) | onjuist (84.10) | datum ingang geldigheid (85.10) |
        | 1      | 4         |                       |                       | 404                      |                                    |                 | 20150102                        |
        | 1      | 54        | 0334                  | 301                   |                          |                                    |                 | 19670311                        |
        | 2      | 4         |                       |                       | 404                      |                                    |                 | 20150102                        |
        | 2      | 54        | 0223                  | 301                   |                          |                                    |                 | 19670000                        |
        | 3      | 4         |                       |                       | 404                      |                                    |                 | 20150102                        |
        | 3      | 54        | 0331                  | 301                   |                          |                                    |                 | 19670300                        |
        | 4      | 4         |                       |                       | 404                      |                                    |                 | 20150102                        |
        | 4      | 54        | 0101                  | 301                   |                          |                                    |                 | 19670102                        |
        | 5      | 4         | 0001                  | 017                   |                          |                                    |                 | 20150102                        |
      Als de nationaliteithistorie met burgerservicenummer 555550017 wordt geraadpleegd
      Dan bevat het antwoord 6 voorkomens
      En wordt de nationaliteithistorie teruggegeven in de volgorde en met waarden:
      | # | nationaliteit.code | datumIngangGeldigheid.jaar | datumIngangGeldigheid.maand | datumIngangGeldigheid.dag | datumTot   | indicatieNationaliteitBeeindigd |
      | 0 | 0001               | 2015                       | 1                           | 2                         |            |                                 |
      | 0 | 0334               | 1967                       | 3                           | 11                        | 2015-01-02 | true                            |
      | 0 | 0331               | 1967                       | 3                           |                           | 2015-01-02 | true                            |
      | 0 | 0101               | 1967                       | 1                           | 2                         | 2015-01-02 | true                            |
      | 0 | 0223               | 1967                       |                             |                           | 2015-01-02 | true                            |
