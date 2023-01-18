# Releasenotes Haal-Centraal-BRP-historie-bevragen


## Versie 1.0.0

Alhoewel er nog geen eerdere officiële versie van de Haal-Centraal-BRP-historie-bevragen API als release is uitgebracht zijn de specificaties van deze endpoints als onderdeel van de specificatie van Haal-Centraal-BRP-bevragen het afgelopen jaar beschikbaar geweest via de repository. In de [v0.9.0 release van BRP-bevragen](https://github.com/BRP-API/Haal-Centraal-BRP-bevragen/tree/v0.9.0) zijn de historie-endpoints nog opgenomen. In de afgelopen maanden hebben we de historie-endpoints in een aparte API ondergebracht. Daarbij zijn nieuwe inzichten die het afgelopen jaar zijn opgedaan opgenomen. Recentelijk hebben we de specificaties ook aangepast op het hergebruik van componenten uit BRP-Bevragen release 1.2.0.
Dit is een globaal overzicht van wijzigingen die daarvoor zijn doorgevoerd.

We bieden bieden een [postman-collectie](https://github.com/BRP-API/Haal-Centraal-BRP-historie-bevragen/tree/master/test) t.b.v. testen aan.

### Openapi.yaml :

_**Breaking:**_

- Enkele parameternamen zijn aangepast vanwege consistentie met andere Haal-Centraal API's en/of de Design Decision om parameternamen in camelCase op te nemen  
  - datumvan --> datumVan
  - datumtotenmet --> datumTotEnMet  

  - Enkele property-namen zijn gewijzigd
    - Nationaliteithistorie.datumEindeGeldigheid --> Nationaliteithistorie.datumTot
    - Verblijfplaatshistorie_links.nummeraanduiding --> VerblijfplaatshistorieLinks.adres
    - Verblijfplaats is anders opgebouwd.
      - Schema-component BinnenlandsAdres is verwijderd. Er wordt nu hergebruik gemaakt van het component Adres en dat wordt direct aangevuld met de properties
        - BinnenlandsAdres.openbareRuimteNaam --> Verblijfplaats.straat
        - BinnenlandsAdres.functieAdres --> Verblijfplaats.functieAdres
        - BinnenlandsAdres.aanduidingBijHuisnummer --> Verblijfplaats.aanduidingBijHuisnummer
        - BinnenlandsAdres.identificatiecodeNummeraanduiding --> Verblijfplaats.nummeraanduidingIdentificatie
        - BinnenlandsAdres.woonplaatsnaam --> Verblijfplaats.woonplaats
        - Verblijfplaats.identificatiecodeVerblijfplaats --> Verblijfplaats.identificatiecodeAdresseerbaarObject --> Verblijfplaats.adresseerbaarObjectIdentificatie
        - Verblijfplaats.straatnaam --> Verblijfplaats.korteNaam
        - component verblijfBuitenland is komen te vervallen.
      - Schema-component Verblijfbuitenland is verwijderd. Properties zijn opgenomen in Verblijfplaats en enkele zijn hernoemd.
        - VerblijfBuitenland.adresRegel1 --> Verblijfplaats.adresregel1
        - VerblijfBuitenland.adresRegel2 --> Verblijfplaats.adresregel2  
        - VerblijfBuitenland.adresRegel3 --> Verblijfplaats.adresregel3  
        - VerblijfBuitenland.vertrokkenOnbekendWaarheen --> Verblijfplaats.vertrokkenOnbekendWaarheen
        - VerblijfBuitenland.land --> Verblijfplaats.land
      - VerblijfplaatsInOnderzoek.identificatiecodeNummeraanduiding --> VerblijfplaatsInOnderzoek.nummeraanduidingIdentificatie
      - VerblijfplaatsInOnderzoek.identificatiecodeVerblijfplaats --> VerblijfplaatsInOnderzoek.identificatiecodeAdresseerbaarObject --> VerblijfplaatsInOnderzoek.adresseerbaarObjectIdentificatie
      - VerblijfplaatsInOnderzoek.straatnaam --> VerblijfplaatsInOnderzoek.korteNaam
      - VerblijfplaatsInOnderzoek.naamOpenbareRuimte --> VerblijfplaatsInOnderzoek.straat
      - VerblijfplaatsInOnderzoek.woonplaatsnaam --> VerblijfplaatsInOnderzoek.woonplaats


  - Verwijderde properties:
    - Verblijfstitelhistorie.indicatieVerblijfstitelBeeindigd
    - Verblijfstitel.datumOpneming
    - VerblijfstitelInOnderzoek.datumOpneming



_**Non-breaking:**_
- server-url is aangepast (omdat het een aparte API is geworden.) --> https://github.com/BRP-API/Haal-Centraal-BRP-historie-bevragen
- OperationId's zijn aangepast ivm code-generatie issues en nu in UpperCamelCase.
- Bij properties zijn de maxLength, minLength, pattern en (waar overbodig) de title weggehaald.

- Schema-component Burgerservicenummer is verwijderd. De properties die deze als $REF gebruikten zijn als string gedefinieerd.


- Enkele namen van schema-componenten zijn aangepast vanwege consistentie met andere Haal-Centraal API's
  - NationaliteithistorieHalCollectie__embedded --> NationaliteithistorieHalCollectieEmbedded
  - Verwijzing naar common-schemacomponent Datum_onvolledig --> DatumOnvolledig
  - VerblijfplaatshistorieHalCollectie__embedded --> VerblijfplaatshistorieHalCollectieEmbedded
  - Verblijfplaatshistorie_links --> VerblijfplaatshistorieLinks
  - PartnerhistorieHalCollectie__embedded --> PartnerhistorieHalCollectieEmbedded
  - Partnerhistorie_links --> PartnerhistorieLinks
  - VerblijfstitelhistorieHalCollectie__embedded --> VerblijfstitelhistorieHalCollectieEmbedded
  - AangaanHuwelijkInOnderzoek --> AangaanHuwelijkPartnerschapInOnderzoek

- Toegevoegde properties:
  - OntbindingHuwelijkInOnderzoek.reden is toegevoegd
  - OntbindingHuwelijk.indicatieHuwelijkPartnerschapBeeindigd is toegevoegd
  - Partnerhistorie.naam.adellijkeTitelPredikaat is toegevoegd


### Features:

De feature files hebben als doel om functioneel de werking te beschrijven.

- nationaliteithistorie.feature is verplaatst naar [Haal-Centraal-BRP-historie-bevragen](./features)
- partnerhistorie.feature is verplaatst naar [Haal-Centraal-BRP-historie-bevragen](./features)
- verblijfplaatshistorie.feature is verplaatst naar [Haal-Centraal-BRP-historie-bevragen](./features)
- verblijfstitelhistorie.feature is verplaatst naar [Haal-Centraal-BRP-historie-bevragen](./features)
- onvolledige_datum.feature is verplaatst naar [Common](https://github.com/VNG-Realisatie/Haal-Centraal-common/tree/v1.2.0/features)
- fields.feature is verplaatst naar [Common](https://github.com/VNG-Realisatie/Haal-Centraal-common/tree/v1.2.0/features)
- foutafhandeling.feature is verplaatst naar [Common](https://github.com/VNG-Realisatie/Haal-Centraal-common/tree/v1.2.0/features)
- links.feature is verplaatst naar [Common](https://github.com/VNG-Realisatie/Haal-Centraal-common/tree/v1.2.0/features)
