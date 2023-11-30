#language: nl

@stap-documentatie
Functionaliteit: Ouder stap definities

  Achtergrond:
    Gegeven de 1e 'SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres' statement heeft als resultaat '4999'
    En de 1e 'SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl' statement heeft als resultaat '9999'

  Abstract Scenario: persoon heeft ouder
    Gegeven de persoon met burgerservicenummer '000000012' heeft een ouder '<ouder-type>' met de volgende gegevens
    | naam                  | waarde |
    | geslachtsnaam (02.40) | Jansen |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie          | text                                                                                                                                                  | values                       |
    | 1    | inschrijving       | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                            |
    |      | persoon            | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      | 9999,0,0,P,000000012         |
    |      | ouder-<ouder-type> | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,geslachts_naam) VALUES($1,$2,$3,$4,$5)                                         | 9999,0,0,<ouder-type>,Jansen |

    Voorbeelden:
    | ouder-type |
    | 1          |
    | 2          |

  Scenario: persoon met 2 ouders
    Gegeven de persoon met burgerservicenummer '000000012' heeft een ouder '1' met de volgende gegevens
    | naam                  | waarde |
    | geslachtsnaam (02.40) | Jansen |
    En de persoon heeft een ouder '2' met de volgende gegevens
    | naam                  | waarde    |
    | geslachtsnaam (02.40) | Pietersen |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie    | text                                                                                                                                                  | values               |
    | 1    | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                    |
    |      | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      | 9999,0,0,P,000000012 |
    |      | ouder-1      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,geslachts_naam) VALUES($1,$2,$3,$4,$5)                                         | 9999,0,0,1,Jansen    |
    |      | ouder-2      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,geslachts_naam) VALUES($1,$2,$3,$4,$5)                                         | 9999,0,0,2,Pietersen |

  Abstract Scenario: persoon heeft ouder en inschrijving op een adres met identificatie
    Gegeven adres 'A1' heeft de volgende gegevens
    | straatnaam (11.10) |
    | Boterdiep          |
    En de persoon met burgerservicenummer '000000012' heeft een ouder '<ouder-type>' met de volgende gegevens
    | naam                  | waarde |
    | geslachtsnaam (02.40) | Jansen |
    En de persoon is ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20230102                           |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie          | text                                                                                                                                                  | values                       |
    | 1    | adres-A1           | INSERT INTO public.lo3_adres(adres_id,straat_naam) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING *                 | Boterdiep                    |
    | 2    | inschrijving       | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                            |
    |      | persoon            | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      | 9999,0,0,P,000000012         |
    |      | ouder-<ouder-type> | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,geslachts_naam) VALUES($1,$2,$3,$4,$5)                                         | 9999,0,0,<ouder-type>,Jansen |
    |      | verblijfplaats     | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adreshouding_start_datum) VALUES($1,$2,$3,$4)                                         | 9999,4999,0,20230102         |

    Voorbeelden:
    | ouder-type |
    | 1          |
    | 2          |
