# language: nl

@post-assert
Functionaliteit: Als gebruiker van de API wil ik geen onbekend waardes ontvangen
  zodat ik deze niet hoef te (kunnen) interpreteren en ik geen code voor hoef te schrijven om deze situatie af te vangen

Rule: Wanneer Datum huwelijkssluiting/aangaan geregistreerd partnerschap geheel onbekend is, wordt voor de filtering aangenomen dat de persoon deze partner altijd heeft gehad.
	  ???? Wat betekent hier 'altijd', vanaf de geboorte van de betreffende persoon? Dat zou betekenen dat als ik als peildatum de geboortedatum van de betreffende persoon neem deze partner wordt opgenomen.
	  ???? Maar wat betekent dit als de peildatum ligt voor de geboortedatum van de persoon? Dat er geen partnerhistorie wordt opgenomen? 
	  ???? Of moeten we sowieso een regel opnemen voor als de peildatum ligt voor de geboortedatum van de persoon? Bijv. dat er dan niets wordt teruggegeven.
	  ???? Welk gevolg heeft e.e.a. evt. voor de sortering in het geval van polygamie of een historisch huwelijk/geregistreerd partnerschap?

    Scenario: Datum huwelijkssluiting is volledig onbekend
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550002 |
      En de 'partner' heeft de volgende 'aangaanHuwelijkPartnerschap' gegevens
      | naam  | waarde |
      | datum | .      |
      Als partnerhistorie wordt gezocht met de volgende parameters
      | naam                | waarde                                          |
      | type                | RaadpleegMetPeildatum                           |
      | burgerservicenummer | 555550001                                       |
      | fields              | burgerservicenummer,aangaanHuwelijkPartnerschap |
      | peildatum           | 2020-10-17                                      |
      Dan heeft de response een partnerhistorie met alleen de volgende gegevens
      | naam                                          | waarde        |
      | burgerservicenummer                           | 555550002     |
	  | aangaanHuwelijkPartnerschap.datum.type        | DatumOnbekend |
	  | aangaanHuwelijkPartnerschap.datum.langformaat | onbekend      |
	  | aangaanHuwelijkPartnerschap.datum.onbekend    | true          |

    Scenario: Peildatum ligt na ontbinden huwelijk bij datum huwelijkssluiting volledig onbekend
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
      | datum | .        |
      Als partnerhistorie wordt gezocht met de volgende parameters
      | naam                | waarde                                          |
      | type                | RaadpleegMetPeildatum                           |
      | burgerservicenummer | 555550001                                       |
      | fields              | burgerservicenummer,aangaanHuwelijkPartnerschap |
      | peildatum           | 2020-10-17                                      |
      Dan heeft de response een lege array

Rule: Wanneer Datum ontbinding huwelijk/geregistreerd partnerschap geheel onbekend is, wordt voor de filtering aangenomen dat de persoon deze partner nu nog heeft

    Scenario: Datum ontbinding huwelijk/geregistreerd partnerschap is volledig onbekend
      Gegeven het systeem heeft een persoon met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550002 |
      En de 'partner' heeft de volgende 'ontbindingHuwelijkPartnerschap' gegevens
      | naam  | waarde |
      | datum | .      |
      En de 'partner' heeft de volgende historische gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550002 |
      En de 'partner' heeft de volgende historische 'aangaanHuwelijkPartnerschap' gegevens
      | naam  | waarde   |
      | datum | 20171103 |
      Als partnerhistorie wordt gezocht met de volgende parameters
      | naam                | waarde                                                                         |
      | type                | RaadpleegMetPeriode                                                            |
      | burgerservicenummer | 555550001                                                                      |
      | fields              | burgerservicenummer,aangaanHuwelijkPartnerschap,ontbindingHuwelijkPartnerschap |
      | datumVan            | 2019-01-01                                                                     |
      | datumTot            | 2020-12-31                                                                     |
      Dan heeft de response een partnerhistorie met de volgende gegevens
      | naam                                             | waarde          |
      | burgerservicenummer                              | 555550002       |
	  | aangaanHuwelijkPartnerschap.datum.type           | Datum           |
	  | aangaanHuwelijkPartnerschap.datum.langformaat    | 3 november 2017 |
	  | aangaanHuwelijkPartnerschap.datum.datum          | 2017-11-03      |
	  | ontbindingHuwelijkPartnerschap.datum.type        | DatumOnbekend   |
	  | ontbindingHuwelijkPartnerschap.datum.langformaat | onbekend        |
	  | ontbindingHuwelijkPartnerschap.datum.onbekend    | true            |
	  
    Scenario: Peildatum ligt voor datum huwelijkssluiting bij datum ontbinding huwelijk volledig onbekend
	  Gegeven de persoon met burgerservicenummer 555550001 heeft de volgende huwelijken/partnerschappen in de registratie
      | Categorie | Burgerservicenummer (01.20) | Datum aangaan (06.10) | Datum ontbinding (07.10) | 
      | 5         | 555550002                   | 20171103              | .                        | 
      Als partnerhistorie wordt gezocht met de volgende parameters
      | naam                | waarde                                          |
      | type                | RaadpleegMetPeildatum                           |
      | burgerservicenummer | 555550001                                       |
      | fields              | burgerservicenummer,aangaanHuwelijkPartnerschap |
      | peildatum           | 2016-03-01                                      |
      Dan heeft de response een lege array

Rule: Wanneer Datum huwelijkssluiting/aangaan geregistreerd partnerschap gedeeltelijk onbekend is, wordt voor de filtering aangenomen dat de persoon deze partner gedurende de gehele onzekerheidsperiode heeft gehad.

    Scenario: Peildatum ligt voor jaar datum huwelijkssluiting met maand en dag onbekend
	  Gegeven de persoon met burgerservicenummer 555550001 heeft de volgende huwelijken/partnerschappen in de registratie
      | Categorie | Burgerservicenummer (01.20) | Datum aangaan (06.10) | Datum ontbinding (07.10) | 
      | 5         | 555550002                   | 20170000              |                          | 
      Als partnerhistorie wordt gezocht met de volgende parameters
      | naam                | waarde                                          |
      | type                | RaadpleegMetPeildatum                           |
      | burgerservicenummer | 555550001                                       |
      | fields              | burgerservicenummer,aangaanHuwelijkPartnerschap |
      | peildatum           | 2016-03-01                                      |
      Dan heeft de response een lege array

    Scenario: Peildatum in jaar datum huwelijkssluiting met maand en dag onbekend
	  Gegeven de persoon met burgerservicenummer 555550001 heeft de volgende huwelijken/partnerschappen in de registratie
      | Categorie | Burgerservicenummer (01.20) | Datum aangaan (06.10) | Datum ontbinding (07.10) | 
      | 5         | 555550002                   | 20170000              |                          | 
      Als partnerhistorie wordt gezocht met de volgende parameters
      | naam                | waarde                                          |
      | type                | RaadpleegMetPeildatum                           |
      | burgerservicenummer | 555550001                                       |
      | fields              | burgerservicenummer,aangaanHuwelijkPartnerschap |
      | peildatum           | 2017-03-01                                      |
      Dan heeft de response een partnerhistorie met de volgende gegevens
      | naam                                             | waarde    |
      | burgerservicenummer                              | 555550002 |
	  | aangaanHuwelijkPartnerschap.datum.type           | JaarDatum |
	  | aangaanHuwelijkPartnerschap.datum.langformaat    | 2017      |
	  | aangaanHuwelijkPartnerschap.datum.jaar           | 2017      |

    Scenario: Peildatum is 1e dag van maand datum huwelijkssluiting met dag onbekend
	  Gegeven de persoon met burgerservicenummer 555550001 heeft de volgende huwelijken/partnerschappen in de registratie
      | Categorie | Burgerservicenummer (01.20) | Datum aangaan (06.10) | Datum ontbinding (07.10) | 
      | 5         | 555550002                   | 20170500              |                          | 
      Als partnerhistorie wordt gezocht met de volgende parameters
      | naam                | waarde                                          |
      | type                | RaadpleegMetPeildatum                           |
      | burgerservicenummer | 555550001                                       |
      | fields              | burgerservicenummer,aangaanHuwelijkPartnerschap |
      | peildatum           | 2017-05-01                                      |
      Dan heeft de response een partnerhistorie met de volgende gegevens
      | naam                                             | waarde         |
      | burgerservicenummer                              | 555550002      |
	  | aangaanHuwelijkPartnerschap.datum.type           | JaarMaandDatum |
	  | aangaanHuwelijkPartnerschap.datum.langformaat    | mei 2017       |
	  | aangaanHuwelijkPartnerschap.datum.jaar           | 2017           |
	  | aangaanHuwelijkPartnerschap.datum.maand          | 5              |

    Scenario: datumTot is 1 januari van jaar datum huwelijkssluiting met maand en dag onbekend
	  Gegeven de persoon met burgerservicenummer 555550001 heeft de volgende huwelijken/partnerschappen in de registratie
      | Categorie | Burgerservicenummer (01.20) | Datum aangaan (06.10) | Datum ontbinding (07.10) | 
      | 5         | 555550002                   | 20170000              |                          | 
      Als partnerhistorie wordt gezocht met de volgende parameters
      | naam                | waarde                                          |
      | type                | RaadpleegMetPeriode                             |
      | burgerservicenummer | 555550001                                       |
      | fields              | burgerservicenummer,aangaanHuwelijkPartnerschap |
      | datumVan            | 2016-01-01                                      |
	  | datumTot            | 2017-01-01
      Dan heeft de response een lege array

    Scenario: datumTot is 2 januari van jaar datum huwelijkssluiting met maand en dag onbekend
	  Gegeven de persoon met burgerservicenummer 555550001 heeft de volgende huwelijken/partnerschappen in de registratie
      | Categorie | Burgerservicenummer (01.20) | Datum aangaan (06.10) | Datum ontbinding (07.10) | 
      | 5         | 555550002                   | 20170000              |                          | 
      Als partnerhistorie wordt gezocht met de volgende parameters
      | naam                | waarde                                          |
      | type                | RaadpleegMetPeriode                             |
      | burgerservicenummer | 555550001                                       |
      | fields              | burgerservicenummer,aangaanHuwelijkPartnerschap |
      | datumVan            | 2016-01-01                                      |
	  | datumTot            | 2017-01-02
      Dan heeft de response een partnerhistorie met de volgende gegevens
      | naam                                             | waarde    |
      | burgerservicenummer                              | 555550002 |
	  | aangaanHuwelijkPartnerschap.datum.type           | JaarDatum |
	  | aangaanHuwelijkPartnerschap.datum.langformaat    | 2017      |
	  | aangaanHuwelijkPartnerschap.datum.jaar           | 2017      |

    Scenario: datumTot is 1e dag van maand datum huwelijkssluiting met dag onbekend
	  Gegeven de persoon met burgerservicenummer 555550001 heeft de volgende huwelijken/partnerschappen in de registratie
      | Categorie | Burgerservicenummer (01.20) | Datum aangaan (06.10) | Datum ontbinding (07.10) | 
      | 5         | 555550002                   | 20170500              |                          | 
      Als partnerhistorie wordt gezocht met de volgende parameters
      | naam                | waarde                                          |
      | type                | RaadpleegMetPeriode                             |
      | burgerservicenummer | 555550001                                       |
      | fields              | burgerservicenummer,aangaanHuwelijkPartnerschap |
      | datumVan            | 2016-05-01                                      |
	  | datumTot            | 2017-05-01
      Dan heeft de response een lege array

    Scenario: datumTot is 2e dag van maand datum huwelijkssluiting met dag onbekend
	  Gegeven de persoon met burgerservicenummer 555550001 heeft de volgende huwelijken/partnerschappen in de registratie
      | Categorie | Burgerservicenummer (01.20) | Datum aangaan (06.10) | Datum ontbinding (07.10) | 
      | 5         | 555550002                   | 20170500              |                          | 
      Als partnerhistorie wordt gezocht met de volgende parameters
      | naam                | waarde                                          |
      | type                | RaadpleegMetPeriode                             |
      | burgerservicenummer | 555550001                                       |
      | fields              | burgerservicenummer,aangaanHuwelijkPartnerschap |
      | datumVan            | 2016-05-01                                      |
	  | datumTot            | 2017-05-02
      Dan heeft de response een partnerhistorie met de volgende gegevens
      | naam                                             | waarde         |
      | burgerservicenummer                              | 555550002      |
	  | aangaanHuwelijkPartnerschap.datum.type           | JaarMaandDatum |
	  | aangaanHuwelijkPartnerschap.datum.langformaat    | mei 2017       |
	  | aangaanHuwelijkPartnerschap.datum.jaar           | 2017           |
	  | aangaanHuwelijkPartnerschap.datum.maand          | 5              |
	
Rule: Wanneer Datum ontbinding huwelijk/geregistreerd partnerschap gedeeltelijk onbekend is, wordt voor de filtering aangenomen dat de persoon deze partner gedurende de gehele onzekerheidsperiode heeft gehad.

    Scenario: Peildatum is 31 december van jaar datum ontbinding huwelijk met maand en dag onbekend
	  Gegeven de persoon met burgerservicenummer 555550001 heeft de volgende huwelijken/partnerschappen in de registratie
      | Categorie | Burgerservicenummer (01.20) | Datum aangaan (06.10) | Datum ontbinding (07.10) | 
      | 5         | 555550002                   | 20171103              | 2019000                  | 
      Als partnerhistorie wordt gezocht met de volgende parameters
      | naam                | waarde                                                                         |
      | type                | RaadpleegMetPeildatum                                                          |
      | burgerservicenummer | 555550001                                                                      |
      | fields              | burgerservicenummer,aangaanHuwelijkPartnerschap,ontbindingHuwelijkPartnerschap |
      | peildatum           | 2019-12-31                                                                     |
      Dan heeft de response een partnerhistorie met de volgende gegevens
      | naam                                             | waarde          |
      | burgerservicenummer                              | 555550002       |
	  | aangaanHuwelijkPartnerschap.datum.type           | Datum           |
	  | aangaanHuwelijkPartnerschap.datum.langformaat    | 3 november 2017 |
	  | aangaanHuwelijkPartnerschap.datum.datum          | 2017-11-03      |
	  | ontbindingHuwelijkPartnerschap.datum.type        | JaarDatum       |
	  | ontbindingHuwelijkPartnerschap.datum.langformaat | 2019            |
	  | ontbindingHuwelijkPartnerschap.datum.jaar        | 2019            |

    Scenario: Peildatum is 1 januari van jaar na datum ontbinding huwelijk met maand en dag onbekend
	  Gegeven de persoon met burgerservicenummer 555550001 heeft de volgende huwelijken/partnerschappen in de registratie
      | Categorie | Burgerservicenummer (01.20) | Datum aangaan (06.10) | Datum ontbinding (07.10) | 
      | 5         | 555550002                   | 20171103              | 20190000                 | 
      Als partnerhistorie wordt gezocht met de volgende parameters
      | naam                | waarde                                                                         |
      | type                | RaadpleegMetPeildatum                                                          |
      | burgerservicenummer | 555550001                                                                      |
      | fields              | burgerservicenummer,aangaanHuwelijkPartnerschap,ontbindingHuwelijkPartnerschap |
      | peildatum           | 2020-01-01                                                                     |
      Dan heeft de response een lege array

    Scenario: Peildatum is laatste dag van maand datum ontbinding huwelijk met dag onbekend
	  Gegeven de persoon met burgerservicenummer 555550001 heeft de volgende huwelijken/partnerschappen in de registratie
      | Categorie | Burgerservicenummer (01.20) | Datum aangaan (06.10) | Datum ontbinding (07.10) | 
      | 5         | 555550002                   | 20171103              | 20190400                 | 
      Als partnerhistorie wordt gezocht met de volgende parameters
      | naam                | waarde                                                                         |
      | type                | RaadpleegMetPeildatum                                                          |
      | burgerservicenummer | 555550001                                                                      |
      | fields              | burgerservicenummer,aangaanHuwelijkPartnerschap,ontbindingHuwelijkPartnerschap |
      | peildatum           | 2019-04-30                                                                     |
      Dan heeft de response een partnerhistorie met de volgende gegevens
      | naam                                             | waarde          |
      | burgerservicenummer                              | 555550002       |
	  | aangaanHuwelijkPartnerschap.datum.type           | Datum           |
	  | aangaanHuwelijkPartnerschap.datum.langformaat    | 3 november 2017 |
	  | aangaanHuwelijkPartnerschap.datum.datum          | 2017-11-03      |
	  | ontbindingHuwelijkPartnerschap.datum.type        | JaarMaandDatum  |
	  | ontbindingHuwelijkPartnerschap.datum.langformaat | april 2019      |
	  | ontbindingHuwelijkPartnerschap.datum.jaar        | 2019            |
	  | aangaanHuwelijkPartnerschap.datum.type           | JaarMaandDatum |
	  | aangaanHuwelijkPartnerschap.datum.langformaat    | mei 2017       |
	  | aangaanHuwelijkPartnerschap.datum.jaar           | 2017           |
	  | aangaanHuwelijkPartnerschap.datum.maand          | 5              |

    Scenario: datumVan is 31 december van jaar datum ontbinding huwelijk met maand en dag onbekend
    Scenario: datumVan is 1 januari van jaar na datum ontbinding huwelijk met maand en dag onbekend
    Scenario: datumVan is laatste dag van maand datum ontbinding huwelijk met dag onbekend
