#language: nl

Functionaliteit: Dan stap definities

  Scenario: Dan heeft de response de volgende gegevens (veld naam = tabel kolom naam)
    Gegeven de response body is gelijk aan
    """
    {
      "geheimhoudingPersoonsgegevens": "7"
    }
    """
    Dan heeft de response de volgende gegevens
    | geheimhoudingPersoonsgegevens |
    | 7                             |

  Scenario: Dan heeft de response de volgende gegevens
    Gegeven de response body is gelijk aan
    """
    {
      "geheimhoudingPersoonsgegevens": "7"
    }
    """
    Dan heeft de response de volgende gegevens
    | naam                          | waarde |
    | geheimhoudingPersoonsgegevens | 7      |

  Scenario: Dan heeft de response een verblijfplaats met de volgende gegevens
    Gegeven de response body is gelijk aan
    """
    {
      "verblijfplaatsen": [
        {
          "adresseerbaarObjectIdentificatie": "0800010000000001",
          "straat": "Laan",
          "datumAanvangAdreshouding": "20100818",
          "gemeenteVanInschrijving": {
            "code": "0800",
            "omschrijving": "Hoogeloon, Hapert en Casteren"
          }
        }
      ]
    }
    """
    Dan heeft de response verblijfplaatsen met de volgende gegevens
    | adresseerbaarObjectIdentificatie | straat | datumAanvangAdreshouding | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving |
    | 0800010000000001                 | Laan   | 20100818                 | 0800                         | Hoogeloon, Hapert en Casteren        |

  Scenario: Dan heeft de response meerdere verblijfplaatsen met de volgende gegevens
    Gegeven de response body is gelijk aan
    """
    {
      "verblijfplaatsen": [
        {
          "adresseerbaarObjectIdentificatie": "0800010000000002",
          "straat": "Luttestraat",
          "datumAanvangAdreshouding": "20200415",
          "gemeenteVanInschrijving": {
            "code": "0800",
            "omschrijving": "Hoogeloon, Hapert en Casteren"
          }
        },
        {
          "land": {
            "code": "6014",
            "omschrijving": "Verenigde Staten van Amerika"
          },
          "datumAanvangAdresBuitenland": "20181201",
          "datumAanvangVolgendeAdreshouding": "20200415"
        },
        {
          "locatiebeschrijving": "Woonboot bij de Grote Sloot",
          "datumAanvangAdreshouding": "20160526",
          "datumAanvangVolgendeAdresBuitenland": "20181201",
          "gemeenteVanInschrijving": {
            "code": "0800",
            "omschrijving": "Hoogeloon, Hapert en Casteren"
          }
        }
      ]
    }
    """
    Dan heeft de response verblijfplaatsen met de volgende gegevens
    | land.code | land.omschrijving            | straat      | adresseerbaarObjectIdentificatie | locatiebeschrijving         | datumAanvangAdreshouding | datumAanvangVolgendeAdreshouding | datumAanvangAdresBuitenland | datumAanvangVolgendeAdresBuitenland | gemeenteVanInschrijving.code | gemeenteVanInschrijving.omschrijving |
    |           |                              | Luttestraat | 0800010000000002                 |                             | 20200415                 |                                  |                             |                                     | 0800                         | Hoogeloon, Hapert en Casteren        |
    | 6014      | Verenigde Staten van Amerika |             |                                  |                             |                          | 20200415                         | 20181201                    |                                     |                              |                                      |
    |           |                              |             |                                  | Woonboot bij de Grote Sloot | 20160526                 |                                  |                             | 20181201                            | 0800                         | Hoogeloon, Hapert en Casteren        |

  Scenario: Dan heeft de response de volgende 'opschortingBijhouding' gegevens
    Gegeven de response body is gelijk aan
    """
    {
      "opschortingBijhouding": {
        "reden": {
          "code": "O",
          "omschrijving": "overlijden"
        },
        "datum": "20150401"
      }
    }
    """
    Dan heeft de response de volgende 'opschortingBijhouding' gegevens
    | reden.code | reden.omschrijving | datum    |
    | O          | overlijden         | 20150401 |
