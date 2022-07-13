# language: nl

@post-assert
Functionaliteit: als gebruiker van de API wil ik dat zoekresultaten worden gesorteerd op Datum huwelijkssluiting/aangaan geregistreerd partnerschap
    zodat ik in een lijst resultaten het gewenste huwelijk/geregistreerd partnerschap sneller kan vinden

Rule: Partners worden in het antwoord aflopend gesorteerd op Datum huwelijkssluiting/aangaan geregistreerd partnerschap, zodat het laatst gesloten huwelijk/partnerschap bovenaan staat

	Scenario: Ontbonden en actueel huwelijk/partnerschap
	  Gegeven de persoon met burgerservicenummer 555550001 heeft de volgende huwelijken/partnerschappen in de registratie
      | Categorie | Burgerservicenummer (01.20) | Datum aangaan (06.10) | Datum ontbinding (07.10) | 
      | 5         | 555550002                   | 20171103              |                          | 
      | 55        | 555550003                   | 20101022              | 20140315                 | 
      | 55        | 555550004                   | 20010913              | 20070416                 | 
      Als partnerhistorie wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | burgerservicenummer             |
      | datumVan            | 19990101                        |
      | datumTot            | 20181231                        |
      Dan heeft de response de partnerhistorie in de volgende volgorde
      | burgerservicenummer |
	  | 555550002           |
	  | 555550003           |
	  | 555550004           |

	Scenario: Twee ontbonden huwelijken
	  Gegeven de persoon met burgerservicenummer 555550001 heeft de volgende huwelijken/partnerschappen in de registratie
      | Categorie | Burgerservicenummer (01.20) | Datum aangaan (06.10) | Datum ontbinding (07.10) | 
      | 5         | 555550003                   | 20101022              | 20140315                 | 
      | 55        | 555550004                   | 20021111              | 20090427                 | 
      Als partnerhistorie wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | burgerservicenummer             |
      | datumVan            | 19990101                        |
      | datumTot            | 20181231                        |
      Dan heeft de response de partnerhistorie in de volgende volgorde
      | burgerservicenummer |
	  | 555550003           |
	  | 555550004           |

	Scenario: poligamie (twee actuele partners)
	  Gegeven de persoon met burgerservicenummer 555550001 heeft de volgende huwelijken/partnerschappen in de registratie
      | Categorie | Burgerservicenummer (01.20) | Datum aangaan (06.10) | Datum ontbinding (07.10) | 
      | 5         | 555550002                   | 20171103              |                          | 
      | 5         | 555550003                   | 20101022              |                          | 
      Als partnerhistorie wordt gezocht met de volgende parameters
      | naam                | waarde                          |
      | type                | RaadpleegMetBurgerservicenummer |
      | burgerservicenummer | 555550001                       |
      | fields              | burgerservicenummer             |
      | datumVan            | 20090101                        |
      | datumTot            | 20181231                        |
      Dan heeft de response de partnerhistorie in de volgende volgorde
      | burgerservicenummer |
	  | 555550002           |
	  | 555550003           |
