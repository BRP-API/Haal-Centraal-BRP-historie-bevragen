#language: nl

Functionaliteit: leveren van inOnderzoek bij raadplegen met peildatum


Achtergrond:
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | straatnaam (11.10) | huisnummer (11.20) | postcode (11.60) |
      | 0800                 | Teststraat         | 1                  | 1234AB           |
      En adres 'A2' heeft de volgende gegevens
      | gemeentecode (92.10) | straatnaam (11.10) | huisnummer (11.20) | postcode (11.60) |
      | 0800                 | Teststraat         | 2                  | 1234CD           |


  Rule: in onderzoek gegevens op een geleverde verblijfplaats worden geleverd

    Scenario: Op peildatum heeft de persoon adres in Nederland met in onderzoek gegevens
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
      | 0800                              | 20021014                           | 81100                           | 20240501                       |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 000000012             |
      | peildatum           | 2006-01-01            |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | datumAanvangAdreshouding | straat     | huisnummer | postcode | inOnderzoek.aanduidingGegevensInOnderzoek | inOnderzoek.datumIngangOnderzoek |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 20021014                 | Teststraat | 1          | 1234AB   | 081100                                    | 20240501                         |

    Scenario: Op peildatum heeft de persoon verblijfplaats buitenland met in onderzoek gegevens
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20021014                           |
      En de persoon is vervolgens ingeschreven op een buitenlands adres met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adres buitenland (13.20) | land adres buitenland (13.10) | regel 1 adres buitenland (13.30) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
      | 1999                              | 20070516                               | 6014                          | Die Straße                       | 081300                          | 20240501                       |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 000000012             |
      | peildatum           | 2008-01-01            |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | land.code | land.omschrijving            | regel1     | datumAanvangAdresBuitenland | inOnderzoek.aanduidingGegevensInOnderzoek | inOnderzoek.datumIngangOnderzoek |
      | 1999                         | Registratie Niet Ingezetenen (RNI)   | 6014      | Verenigde Staten van Amerika | Die Straße | 20070516                    | 081300                                    | 20240501                         |


  Rule: in onderzoek gegevens op de verblijfplaats chronologisch volgend op een geleverde verblijfplaats worden geleverd

    Scenario: Op peildatum heeft de persoon verblijfplaats en volgende verblijfplaats in Nederland heeft in onderzoek gegevens
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20021014                           |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
      | 0800                              | 20040526                           | 081100                          | 20240501                       |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 000000012             |
      | peildatum           | 2003-01-01            |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | datumAanvangAdreshouding | datumAanvangVolgendeAdreshouding | straat     | huisnummer | postcode | inOnderzoekVolgendeVerblijfplaats.aanduidingGegevensInOnderzoek | inOnderzoekVolgendeVerblijfplaats.datumIngangOnderzoek |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 20021014                 | 20040526                         | Teststraat | 1          | 1234AB   | 081100                                                          | 20240501                                               |

    Scenario: Op peildatum heeft de persoon verblijfplaats en volgende verblijfplaats in buitenland heeft in onderzoek gegevens
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20021014                           |
      En de persoon is vervolgens ingeschreven op een buitenlands adres met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adres buitenland (13.20) | land adres buitenland (13.10) | regel 1 adres buitenland (13.30) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
      | 1999                              | 20070516                               | 6014                          | Die Straße                       | 081300                          | 20240501                       |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 000000012             |
      | peildatum           | 2006-01-01            |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | datumAanvangAdreshouding | datumAanvangVolgendeAdresBuitenland | straat     | huisnummer | postcode | inOnderzoekVolgendeVerblijfplaats.aanduidingGegevensInOnderzoek | inOnderzoekVolgendeVerblijfplaats.datumIngangOnderzoek |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 20021014                 | 20070516                            | Teststraat | 1          | 1234AB   | 081300                                                          | 20240501                                               |


  Rule: beëindigd onderzoek op een geleverde verblijfplaats wordt niet geleverd

    Scenario: Op peildatum heeft de persoon adres in Nederland met beëindigd onderzoek
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | datum einde onderzoek (83.30) |
      | 0800                              | 20021014                           | 81100                           | 20240501                       | 20240529                      |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 000000012             |
      | peildatum           | 2006-01-01            |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | datumAanvangAdreshouding | straat     | huisnummer | postcode |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 20021014                 | Teststraat | 1          | 1234AB   |


  Rule: beëindigd onderzoek op een volgende verblijfplaats wordt niet geleverd

    Scenario: Op peildatum heeft de persoon verblijfplaats en volgende verblijfplaats in Nederland heeft beëindigd onderzoek 
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20021014                           |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | datum einde onderzoek (83.30) |
      | 0800                              | 20040526                           | 081100                          | 20240501                       | 20240529                      |
      Als gba verblijfplaatshistorie wordt gezocht met de volgende parameters
      | naam                | waarde                |
      | type                | RaadpleegMetPeildatum |
      | burgerservicenummer | 000000012             |
      | peildatum           | 2003-01-01            |
      Dan heeft de response verblijfplaatsen met de volgende gegevens
      | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving | datumAanvangAdreshouding | datumAanvangVolgendeAdreshouding | straat     | huisnummer | postcode |
      | 0800                         | Hoogeloon, Hapert en Casteren        | 20021014                 | 20040526                         | Teststraat | 1          | 1234AB   |
