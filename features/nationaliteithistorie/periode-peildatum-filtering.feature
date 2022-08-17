# language: nl

Functionaliteit: Selecteer nationaliteiten op een peildatum of in een periode

  Als consumer van de BRP
  Wil ik de nationaliteiten van een persoon zoals die geldig waren op een datum of in een periode kunnen opvragen

  Abstract Scenario: persoon heeft een niet-beëindigde nationaliteit, <sub-titel>
    Gegeven de persoon met burgerservicenummer '000009830' heeft een 'nationaliteit' met de volgende gegevens
    | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
    | 0001                  | 001                   | 19750707                        |
    Als nationaliteithistorie wordt geraadpleegd met de volgende parameters
    | naam                | waarde                                                                   |
    | type                | RaadpleegMetPeildatum                                                    |
    | burgerservicenummer | 000009830                                                                |
    | peildatum           | <peildatum>                                                              |
    | fields              | nationaliteiten.nationaliteit.code,nationaliteiten.datumIngangGeldigheid |
    Dan heeft de response de volgende 'nationaliteiten'
    | type          | nationaliteit.code | datumIngangGeldigheid.type | datumIngangGeldigheid.datum | datumIngangGeldigheid.langFormaat |
    | Nationaliteit | 0001               | Datum                      | 1975-07-07                  | 7 juli 1975                       |

    Voorbeelden:
    | sub-titel                                       | peildatum  |
    | peildatum ligt in geldigheid periode            | 2022-08-01 |
    | peildatum is gelijk aan datum ingang geldigheid | 1975-07-07 |

  Scenario: persoon heeft een niet-beëindigde nationaliteit, peildatum ligt voor datum ingang geldigheid
    Gegeven de persoon met burgerservicenummer '000009830' heeft een 'nationaliteit' met de volgende gegevens
    | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
    | 0001                  | 001                   | 19750707                        |
    Als nationaliteithistorie wordt geraadpleegd met de volgende parameters
    | naam                | waarde                                                                   |
    | type                | RaadpleegMetPeildatum                                                    |
    | burgerservicenummer | 000009830                                                                |
    | peildatum           | 1975-07-06                                                               |
    | fields              | nationaliteiten.nationaliteit.code,nationaliteiten.datumIngangGeldigheid |
    Dan heeft de response een leeg 'nationaliteiten' array

  Abstract Scenario: persoon heeft een niet-beëindigde nationaliteit, <sub-titel>
    Gegeven de persoon met burgerservicenummer '000009830' heeft een 'nationaliteit' met de volgende gegevens
    | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
    | 0001                  | 001                   | 19750707                        |
    Als nationaliteithistorie wordt geraadpleegd met de volgende parameters
    | naam                | waarde                                                                   |
    | type                | RaadpleegMetPeriode                                                      |
    | burgerservicenummer | 000009830                                                                |
    | datumVan            | <datumVan>                                                               |
    | datumTot            | <datumTot>                                                               |
    | fields              | nationaliteiten.nationaliteit.code,nationaliteiten.datumIngangGeldigheid |
    Dan heeft de response de volgende 'nationaliteiten'
    | type          | nationaliteit.code | datumIngangGeldigheid.type | datumIngangGeldigheid.datum | datumIngangGeldigheid.langFormaat |
    | Nationaliteit | 0001               | Datum                      | 1975-07-07                  | 7 juli 1975                       |

    Voorbeelden:
    | sub-titel                                              | datumVan   | datumTot   |
    | raadpleeg periode ligt in geldigheid periode           | 2022-01-01 | 2022-08-01 |
    | datum ingang geldigheid ligt in raadpleeg periode      | 1975-07-01 | 1976-01-01 |
    | datumVan is gelijk aan datum ingang geldigheid         | 1975-07-07 | 2022-08-01 |
    | datumTot is gelijk aan datum ingang geldigheid + 1 dag | 1975-01-01 | 1975-07-08 |

  Abstract Scenario: persoon heeft een niet-beëindigde nationaliteit, <sub-titel>
    Gegeven de persoon met burgerservicenummer '000009830' heeft een 'nationaliteit' met de volgende gegevens
    | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
    | 0001                  | 001                   | 19750707                        |
    Als nationaliteithistorie wordt geraadpleegd met de volgende parameters
    | naam                | waarde                                                                   |
    | type                | RaadpleegMetPeriode                                                      |
    | burgerservicenummer | 000009830                                                                |
    | datumVan            | <datumVan>                                                               |
    | datumTot            | <datumTot>                                                               |
    | fields              | nationaliteiten.nationaliteit.code,nationaliteiten.datumIngangGeldigheid |
    Dan heeft de response een leeg 'nationaliteiten' array

    Voorbeelden:
    | sub-titel                                      | datumVan   | datumTot   |
    | periode ligt voor datum ingang geldigheid      | 1975-01-01 | 1975-07-01 |
    | datumTot is gelijk aan datum ingang geldigheid | 1975-01-01 | 1975-07-07 |

  Abstract Scenario: persoon heeft een beëindigde nationaliteit, <sub-titel>
    Gegeven de persoon met burgerservicenummer '999993008' heeft een 'nationaliteit' met de volgende gegevens
    | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | datum ingang geldigheid (85.10) |
    |                       |                       | 404                      | 20050131                        |
    | 0131                  | 301                   |                          | 19750501                        |
    Als nationaliteithistorie wordt geraadpleegd met de volgende parameters
    | naam                | waarde                                                                                                          |
    | type                | RaadpleegMetPeildatum                                                                                           |
    | burgerservicenummer | 999993008                                                                                                       |
    | peildatum           | <peildatum>                                                                                                     |
    | fields              | nationaliteiten.nationaliteit.code,nationaliteiten.datumIngangGeldigheid,nationaliteiten.nationaliteit.datumTot |
    Dan heeft de response de volgende 'nationaliteiten'
    | type          | nationaliteit.code | datumIngangGeldigheid.type | datumIngangGeldigheid.datum | datumIngangGeldigheid.langFormaat | datumTot.type | datumTot.datum | datumTot.langFormaat |
    | Nationaliteit | 0131               | Datum                      | 1975-05-01                  | 1 mei 1975                        | Datum         | 2005-01-31     | 31 januari 2005      |

    Voorbeelden:
    | sub-titel                                       | peildatum  |
    | peildatum ligt in geldigheid periode            | 2004-01-01 |
    | peildatum is gelijk aan datum ingang geldigheid | 1975-05-01 |
    | peildatum is gelijk aan datumTot - 1 dag        | 2005-01-30 |

  Abstract Scenario: persoon heeft een beëindigde nationaliteit, <sub-titel>
    Gegeven de persoon met burgerservicenummer '999993008' heeft 'nationaliteiten' met de volgende gegevens
    | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | datum ingang geldigheid (85.10) |
    |                       |                       | 404                      | 20050131                        |
    | 0131                  | 301                   |                          | 19750501                        |
    Als nationaliteithistorie wordt geraadpleegd met de volgende parameters
    | naam                | waarde                                                                                                          |
    | type                | RaadpleegMetPeildatum                                                                                           |
    | burgerservicenummer | 999993008                                                                                                       |
    | peildatum           | <peildatum>                                                                                                     |
    | fields              | nationaliteiten.nationaliteit.code,nationaliteiten.datumIngangGeldigheid,nationaliteiten.nationaliteit.datumTot |
    Dan heeft de response een leeg 'nationaliteiten' array

    Voorbeelden:
    | sub-titel                                   | peildatum  |
    | peildatum ligt voor datum ingang geldigheid | 1975-04-30 |
    | peildatum is gelijk aan datumTot            | 2005-01-31 |

  Abstract Scenario: persoon heeft een beëindigde nationaliteit, <sub-titel>
    Gegeven de persoon met burgerservicenummer '999993008' heeft 'nationaliteiten' met de volgende gegevens
    | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | datum ingang geldigheid (85.10) |
    |                       |                       | 404                      | 20050131                        |
    | 0131                  | 301                   |                          | 19750501                        |
    Als nationaliteithistorie wordt geraadpleegd met de volgende parameters
    | naam                | waarde                                                                                                          |
    | type                | RaadpleegMetPeriode                                                                                             |
    | burgerservicenummer | 999993008                                                                                                       |
    | datumVan            | <datumVan>                                                                                                      |
    | datumTot            | <datumTot>                                                                                                      |
    | fields              | nationaliteiten.nationaliteit.code,nationaliteiten.datumIngangGeldigheid,nationaliteiten.nationaliteit.datumTot |
    Dan heeft de response de volgende 'nationaliteiten'
    | type          | nationaliteit.code | datumIngangGeldigheid.type | datumIngangGeldigheid.datum | datumIngangGeldigheid.langFormaat | datumTot.type | datumTot.datum | datumTot.langFormaat |
    | Nationaliteit | 0131               | Datum                      | 1975-05-01                  | 1 mei 1975                        | Datum         | 2005-01-31     | 31 januari 2005      |

    Voorbeelden:
    | sub-titel                                                                                  | datumVan   | datumTot   |
    | raadpleeg periode ligt in geldigheid periode van nationaliteit                             | 1976-01-01 | 1977-01-01 |
    | geldigheid periode van nationaliteit ligt in raadpleeg periode                             | 1975-01-01 | 2005-03-01 |
    | datum ingang geldigheid ligt in raadpleeg periode en datumTot van nationaliteit niet       | 1975-01-01 | 1976-01-01 |
    | datumTot van nationaliteit ligt in raadpleeg periode en datum ingang geldigheid niet       | 2005-01-01 | 2005-03-01 |
    | datumVan raadpleeg periode is gelijk aan datumTot van nationaliteit - 1 dag                | 2005-01-30 | 2005-03-01 |
    | datumTot raadpleeg periode is gelijk aan datum ingang geldigheid van nationaliteit + 1 dag | 1975-01-01 | 1975-05-02 |

  Abstract Scenario: persoon heeft een beëindigde nationaliteit, <sub-titel>
    Gegeven de persoon met burgerservicenummer '999993008' heeft 'nationaliteiten' met de volgende gegevens
    | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | datum ingang geldigheid (85.10) |
    |                       |                       | 404                      | 20050131                        |
    | 0131                  | 301                   |                          | 19750501                        |
    Als nationaliteithistorie wordt geraadpleegd met de volgende parameters
    | naam                | waarde                                                                   |
    | type                | RaadpleegMetPeriode                                                      |
    | burgerservicenummer | 999993008                                                                |
    | datumVan            | <datumVan>                                                               |
    | datumTot            | <datumTot>                                                               |
    | fields              | nationaliteiten.nationaliteit.code,nationaliteiten.datumIngangGeldigheid |
    Dan heeft de response een leeg 'nationaliteiten' array

    Voorbeelden:
    | sub-titel                                                                          | datumVan   | datumTot   |
    | raadpleeg periode ligt buiten geldigheid periode                                   | 1975-01-01 | 1975-04-30 |
    | datumTot raadpleeg periode is gelijk aan datum ingang geldigheid van nationaliteit | 1975-01-01 | 1975-05-01 |
    | datumVan raadpleeg periode is gelijk aan datumTot van nationaliteit                | 2005-01-31 | 2005-03-01 |
