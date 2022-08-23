# language: nl

Functionaliteit: Lever de juiste gegevens over een nationaliteit

  Als consumer van de BRP
  Wil ik alleen de nationaliteiten van een persoon ontvangen die de persoon daadwerkelijk heeft of had

  Daar waar in onderstaande scenario's in de Gegeven stap de tabel meer dan 1 rij waarden bevat, staat de meest actuele bovenaan en de oudste status onderaan.
  
  
  Rule: Een beëindigde nationaliteit met reden beëindigen "Correctie in verband met ten onrechte BE opgenomen gegevens" (405) wordt niet opgenomen
    
    Scenario: ten onrechte opgenomen nationaliteit
      Gegeven de persoon met burgerservicenummer '000000206' heeft een 'nationaliteit' met de volgende gegevens
      | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
      | 0031                  | 301                   | 20210131                        |
      En de 'nationaliteit' is gewijzigd met de volgende gegevens
      | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | datum ingang geldigheid (85.10) |
      |                       |                       | 405                      | 20210131                        |
      En de persoon met burgerservicenummer '000000206' heeft een 'nationaliteit' met de volgende gegevens
      | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | datum ingang geldigheid (85.10) |
      | 0001                  | 185                   |                          | 20210131                        |
      Als nationaliteithistorie wordt geraadpleegd met de volgende parameters
      | naam                | waarde                             |
      | type                | RaadpleegMetPeriode                |
      | burgerservicenummer | 000000206                          |
      | datumVan            | 2021-01-01                         |
      | datumTot            | 2022-01-01                         |
      | fields              | nationaliteiten.nationaliteit.code |
      Dan heeft de response de volgende 'nationaliteiten'
      | type          | nationaliteit.code |
      | Nationaliteit | 0001               |
