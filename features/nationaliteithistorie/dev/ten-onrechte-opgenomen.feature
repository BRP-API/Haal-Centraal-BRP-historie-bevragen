# language: nl

Functionaliteit: Lever de juiste gegevens over een nationaliteit

  Als consumer van de BRP
  Wil ik alleen de nationaliteiten van een persoon ontvangen die de persoon daadwerkelijk heeft of had
  
  
  Rule: Een beëindigde nationaliteit met reden beëindigen "Correctie in verband met ten onrechte BE opgenomen gegevens" (405) wordt niet opgenomen
    
    Scenario: ten onrechte opgenomen nationaliteit
      Gegeven de persoon met burgerservicenummer '999993008' heeft een 'nationaliteit' met de volgende gegevens
      | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | datum ingang geldigheid (85.10) |
      |                       |                       | 405                      | 20210131                        |
      | 0031                  | 301                   |                          | 20210131                        |
      En de persoon met burgerservicenummer '999993008' heeft een 'nationaliteit' met de volgende gegevens
      | nationaliteit (05.10) | reden opnemen (63.10) | reden beëindigen (64.10) | datum ingang geldigheid (85.10) |
      | 0001                  | 185                   |                          | 20210131                        |
      Als nationaliteithistorie wordt geraadpleegd met de volgende parameters
      | naam                | waarde                             |
      | type                | RaadpleegMetPeriode                |
      | burgerservicenummer | 999993008                          |
      | datumVan            | 2021-01-01                         |
      | datumTot            | 2022-01-01                         |
      | fields              | nationaliteiten.nationaliteit.code |
      Dan heeft de response de volgende 'nationaliteiten'
      | type          | nationaliteit.code |
      | Nationaliteit | 0001               |
