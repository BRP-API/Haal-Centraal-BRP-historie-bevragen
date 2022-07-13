# language: nl

@post-assert
Functionaliteit: Selecteer het/de correcte (historische) huwelijken geregistreerde partnerschappen.

Rule: Bij vragen van partnerhistorie op peildatum wordt de partner geleverd waarbij de Datum huwelijkssluiting/aangaan geregistreerd partnerschap op of voor de peildatum ligt én de eventuele Datum ontbinding huwelijk/geregistreerd partnerschap na de peildatum.

    Abstract Scenario: Peildatum in actuele huwelijk/partnerschap
      Gegeven de persoon met burgerservicenummer 555550001 heeft de volgende huwelijken/partnerschappen in de registratie
      | Categorie | Burgerservicenummer (01.20) | Datum aangaan (06.10) | Datum ontbinding (07.10) | 
      | 5         | 555550002                   | 20171103              |                          | 
      | 55        | 555550003                   | 20101022              | 20140315                 | 
      Als partnerhistorie wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | burgerservicenummer             |
      | peildatum           | 20181017                        |
      Dan heeft de response een partnerhistorie met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550002 |

    Scenario: Peildatum in ontbonden huwelijk/partnerschap
      Gegeven de persoon met burgerservicenummer 555550001 heeft de volgende huwelijken/partnerschappen in de registratie
      | Categorie | Burgerservicenummer (01.20) | Datum aangaan (06.10) | Datum ontbinding (07.10) | 
      | 5         | 555550002                   | 20171103              |                          | 
      | 55        | 555550003                   | 20101022              | 20140315                 | 
      Als partnerhistorie wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | burgerservicenummer             |
      | peildatum           | 20120229                        |
      Dan heeft de response een partnerhistorie met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550003 |

    Scenario: Persoon heeft nooit partner gehad
      Gegeven de persoon met burgerservicenummer 555550001 heeft geen huwelijken/partnerschappen in de registratie
      Als partnerhistorie wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | burgerservicenummer             |
      | peildatum           | 20120229                        |
      Dan heeft de response een lege array

    Scenario: Peildatum na ontbinden huwelijk/partnerschap
      Gegeven de persoon met burgerservicenummer 555550001 heeft de volgende huwelijken/partnerschappen in de registratie
      | Categorie | Burgerservicenummer (01.20) | Datum aangaan (06.10) | Datum ontbinding (07.10) | 
      | 5         | 555550003                   | 20101022              | 20140315                 | 
      Als partnerhistorie wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | burgerservicenummer             |
      | peildatum           | 20160813                        |
      Dan heeft de response een lege array

    Scenario: Peildatum voor huwelijkssluiting
      Gegeven de persoon met burgerservicenummer 555550001 heeft de volgende huwelijken/partnerschappen in de registratie
      | Categorie | Burgerservicenummer (01.20) | Datum aangaan (06.10) | Datum ontbinding (07.10) | 
      | 5         | 555550003                   | 20101022              |                          | 
      Als partnerhistorie wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | burgerservicenummer             |
      | peildatum           | 19980923                        |
      Dan heeft de response een lege array

    Scenario: Peildatum tussen twee partners
      Gegeven de persoon met burgerservicenummer 555550001 heeft de volgende huwelijken/partnerschappen in de registratie
      | Categorie | Burgerservicenummer (01.20) | Datum aangaan (06.10) | Datum ontbinding (07.10) | 
      | 5         | 555550002                   | 20171103              |                          | 
      | 55        | 555550003                   | 20101022              | 20140315                 | 
      Als partnerhistorie wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | burgerservicenummer             |
      | peildatum           | 20161021                        |
      Dan heeft de response een lege array

    Scenario: Peildatum is gelijk aan Datum huwelijkssluiting/aangaan geregistreerd partnerschap
      Gegeven de persoon met burgerservicenummer 555550001 heeft de volgende huwelijken/partnerschappen in de registratie
      | Categorie | Burgerservicenummer (01.20) | Datum aangaan (06.10) | Datum ontbinding (07.10) | 
      | 5         | 555550002                   | 20171103              |                          | 
      | 55        | 555550003                   | 20101022              | 20140315                 | 
      Als partnerhistorie wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | burgerservicenummer             |
      | peildatum           | 20171103                        |
      Dan heeft de response een partnerhistorie met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550002 |

    Scenario: Peildatum is gelijk aan Datum ontbinding huwelijk/geregistreerd partnerschap
      Gegeven de persoon met burgerservicenummer 555550001 heeft de volgende huwelijken/partnerschappen in de registratie
      | Categorie | Burgerservicenummer (01.20) | Datum aangaan (06.10) | Datum ontbinding (07.10) | 
      | 5         | 555550002                   | 20171103              |                          | 
      | 55        | 555550003                   | 20101022              | 20140315                 | 
      Als partnerhistorie wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | burgerservicenummer             |
      | peildatum           | 20140315                        |
      Dan heeft de response een lege array

Rule: Bij vragen van partnerhistorie op periode worden alleen de partners geleverd waarbij de Datum huwelijkssluiting/aangaan geregistreerd partnerschap niet op of na de datumTot ligt of de eventuele Datum ontbinding huwelijk/geregistreerd partnerschap niet voor of op de datumVan ligt.

    Scenario: Periode in actuele huwelijk/partnerschap
      Gegeven de persoon met burgerservicenummer 555550001 heeft de volgende huwelijken/partnerschappen in de registratie
      | Categorie | Burgerservicenummer (01.20) | Datum aangaan (06.10) | Datum ontbinding (07.10) | 
      | 5         | 555550002                   | 20171103              |                          | 
      | 55        | 555550003                   | 20101022              | 20140315                 | 
      Als partnerhistorie wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | burgerservicenummer             |
      | datumVan            | 20180101                        |
      | datumTot            | 20181231                        |
      Dan heeft de response een partnerhistorie met  de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550002 |

    Scenario: Periode overlapt met actuele huwelijk/partnerschap
      Gegeven de persoon met burgerservicenummer 555550001 heeft de volgende huwelijken/partnerschappen in de registratie
      | Categorie | Burgerservicenummer (01.20) | Datum aangaan (06.10) | Datum ontbinding (07.10) | 
      | 5         | 555550002                   | 20171103              |                          | 
      | 55        | 555550003                   | 20101022              | 20140315                 | 
      Als partnerhistorie wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | burgerservicenummer             |
      | datumVan            | 20160101                        |
      | datumTot            | 20181231                        |
      Dan heeft de response een partnerhistorie met  de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550002 |

    Scenario: Periode overlapt met ontbonden huwelijk/partnerschap
      Gegeven de persoon met burgerservicenummer 555550001 heeft de volgende huwelijken/partnerschappen in de registratie
      | Categorie | Burgerservicenummer (01.20) | Datum aangaan (06.10) | Datum ontbinding (07.10) | 
      | 5         | 555550002                   | 20171103              |                          | 
      | 55        | 555550003                   | 20101022              | 20140315                 | 
      Als partnerhistorie wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | burgerservicenummer             |
      | datumVan            | 20090101                        |
      | datumTot            | 20131231                        |
      Dan heeft de response een partnerhistorie met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550003 |

    Scenario: Periode overlapt met actuele en ontbonden huwelijk/partnerschap
      Gegeven de persoon met burgerservicenummer 555550001 heeft de volgende huwelijken/partnerschappen in de registratie
      | Categorie | Burgerservicenummer (01.20) | Datum aangaan (06.10) | Datum ontbinding (07.10) | 
      | 5         | 555550002                   | 20171103              |                          | 
      | 55        | 555550003                   | 20101022              | 20140315                 | 
      Als partnerhistorie wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | burgerservicenummer             |
      | datumVan            | 20110101                        |
      | datumTot            | 20181231                        |
      Dan heeft de response een partnerhistorie met  de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550002 |
      En heeft de response een partnerhistorie met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550003 |

    Scenario: Periode overlapt met actuele en ontbonden huwelijken/partnerschappen
      Gegeven de persoon met burgerservicenummer 555550001 heeft de volgende huwelijken/partnerschappen in de registratie
      | Categorie | Burgerservicenummer (01.20) | Datum aangaan (06.10) | Datum ontbinding (07.10) | 
      | 5         | 555550002                   | 20171103              |                          | 
      | 55        | 555550003                   | 20101022              | 20140315                 | 
      | 55        | 555550004                   | 19970703              | 20050828                 | 
      Als partnerhistorie wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | burgerservicenummer             |
      | datumVan            | 19990101                        |
      | datumTot            | 20181231                        |
      Dan heeft de response een partnerhistorie met  de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550002 |
      En heeft de response een partnerhistorie met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550003 |
      En heeft de response een partnerhistorie met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550004 |

    Scenario: Periode voor huwelijkssluiting
      Gegeven de persoon met burgerservicenummer 555550001 heeft de volgende huwelijken/partnerschappen in de registratie
      | Categorie | Burgerservicenummer (01.20) | Datum aangaan (06.10) | Datum ontbinding (07.10) | 
      | 5         | 555550002                   | 20171103              |                          | 
      Als partnerhistorie wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | burgerservicenummer             |
      | datumVan            | 19990101                        |
      | datumTot            | 20101231                        |
      Dan heeft de response een lege array

    Scenario: Periode tussen twee partners
      Gegeven de persoon met burgerservicenummer 555550001 heeft de volgende huwelijken/partnerschappen in de registratie
      | Categorie | Burgerservicenummer (01.20) | Datum aangaan (06.10) | Datum ontbinding (07.10) | 
      | 5         | 555550002                   | 20171103              |                          | 
      | 55        | 555550003                   | 20101022              | 20140315                 | 
      Als partnerhistorie wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | burgerservicenummer             |
      | datumVan            | 20150101                        |
      | datumTot            | 20161231                        |
      Dan heeft de response een lege array

    Scenario: datumTot is gelijk aan Datum huwelijkssluiting/aangaan geregistreerd partnerschap
      Gegeven de persoon met burgerservicenummer 555550001 heeft de volgende huwelijken/partnerschappen in de registratie
      | Categorie | Burgerservicenummer (01.20) | Datum aangaan (06.10) | Datum ontbinding (07.10) | 
      | 5         | 555550002                   | 20171103              |                          | 
      | 55        | 555550003                   | 20101022              | 20140315                 | 
      Als partnerhistorie wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | burgerservicenummer             |
      | datumVan            | 20150101                        |
      | datumTot            | 20171103                        |
      Dan heeft de response een lege array

    Scenario: datumVan is gelijk aan Datum ontbinding huwelijk/geregistreerd partnerschap
      Gegeven de persoon met burgerservicenummer 555550001 heeft de volgende huwelijken/partnerschappen in de registratie
      | Categorie | Burgerservicenummer (01.20) | Datum aangaan (06.10) | Datum ontbinding (07.10) | 
      | 5         | 555550002                   | 20171103              |                          | 
      | 55        | 555550003                   | 20101022              | 20140315                 | 
      Als partnerhistorie wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | burgerservicenummer             |
      | datumVan            | 20140315                        |
      | datumTot            | 20161231                        |
      Dan heeft de response een lege array
