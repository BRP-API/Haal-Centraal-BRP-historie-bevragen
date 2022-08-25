# language: nl

Functionaliteit: Lever de omschrijving van een nationaliteit

  Als consumer van de BRP
  Wil ik de nationaliteit omschrijving bij de code ontvangen
  Zodat ik de nationaliteit aan eindgebruikers kan tonen


  Rule: Op basis van de nationaliteit-code wordt de bijbehorende omschrijving gehaald uit de tabel 'Nationaliteiten' (Landelijke tabel 32)

    Abstract Scenario: persoon heeft nationaliteit "<nationaliteit omschrijving>"
      Gegeven landelijke tabel "Nationaliteiten" heeft de volgende waarde
      | code                 | omschrijving                 |
      | <nationaliteit code> | <nationaliteit omschrijving> |
      # INSERT INTO public.lo3_nationaliteit(nationaliteit_code, nationaliteit_oms) VALUES (<nationaliteit code>, '<nationaliteit omschrijving>')
	    # ON CONFLICT (nationaliteit_code) DO UPDATE SET nationaliteit_oms = '<nationaliteit omschrijving>';
      En de persoon met burgerservicenummer '<burgerservicenummer>' heeft een 'nationaliteit' met de volgende gegevens
      | nationaliteit (05.10) | reden opnemen (63.10) | datum ingang geldigheid (85.10) |
      | <nationaliteit code>  | 301                   | 20150426                        |
      Als nationaliteithistorie wordt geraadpleegd met de volgende parameters
      | naam                | waarde                        |
      | type                | RaadpleegMetPeildatum         |
      | burgerservicenummer | <burgerservicenummer>         |
      | peildatum           | 2022-08-16                    |
      | fields              | nationaliteiten.nationaliteit |
      Dan heeft de response de volgende 'nationaliteiten'
      | type          | nationaliteit.code   | nationaliteit.omschrijving   |
      | Nationaliteit | <nationaliteit code> | <nationaliteit omschrijving> |

      Voorbeelden:
      | burgerservicenummer | nationaliteit code | nationaliteit omschrijving                 |
      | 000000371           | 0144               | Burger van São Tomé en Principe            |
      | 000000383           | 0113               | Equatoriaal-Guinese                        |
      | 000000395           | 0338               | Burger van de Verenigde Arabische Emiraten |
