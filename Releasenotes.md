# Releasenotes Haal-Centraal-BRP-historie-bevragen


## Versie 1.0.0

Alhoewel er nog geen eerdere officiële versie van de Haal-Centraal-BRP-historie-bevragen API als release is uitgebracht zijn de specificaties van deze endpoints als onderdeel van de specificatie van Haal-Centraal-BRP-bevragen het afgelopen jaar redelijk stabiel geweest.
Voor het uitbrengen van release v1.0.0 is besloten om de historie-endpoints in een aparte API onder te brengen en daarvoor een eigen github-repository te maken. Daarbij zijn nieuwe inzichten die het afgelopen jaar zijn opgedaan opgenomen. Dit is een globaal (en niet limitatief) overzicht van wijzigingen die doorgevoerd zijn voordat v1.0.0 is uitgebracht. Enkele van deze wijzigingen zijn breaking ten opzichte van v0.9.0.

We bieden nu ook SDK's aan met gegenereerde [plumbing-code](./code). Daarnaast bieden we een[postman-collectie](./test) t.b.v. testen aan.

### Openapi.yaml :

- server-url is aangepast (omdat het een aparte API is geworden.) --> https://github.com/VNG-Realisatie/Haal-Centraal-BRP-historie-bevragen _**(breaking)**_
- OperationId's zijn aangepast ivm code-generatie issues en nu in UpperCamelCase. _**(breaking)**_
- Alle descriptions zijn omgezet naar markdown.
- Bij properties zijn de maxLength, minLength, pattern en (waar overbodig) de title weggehaald.
- Descriptions zijn aangepast om beter bij de gebruikersbeleving aan te sluiten, overbodige descriptions zijn verwijderd.
- Enkele parameternamen zijn aangepast vanwege consistentie met andere Haal-Centraal API's en/of de Design Decision om parameternamen in camelCase op te nemen  
  - datumvan --> datumVan _**(breaking)**_
  - datumtotenmet --> datumTotEnMet  _**(breaking)**_


- Enkele namen van schema-componenten zijn aangepast vanwege consistentie met andere Haal-Centraal API's
  - NationaliteithistorieHalCollectie__embedded --> NationaliteithistorieHalCollectieEmbedded
  - Verwijzing naar common-schemacomponent Datum_onvolledig --> DatumOnvolledig
  - VerblijfplaatshistorieHalCollectie__embedded --> VerblijfplaatshistorieHalCollectieEmbedded
  - Verblijfplaatshistorie_links --> VerblijfplaatshistorieLinks
  - PartnerhistorieHalCollectie__embedded --> PartnerhistorieHalCollectieEmbedded
  - Partnerhistorie_links --> PartnerhistorieLinks
  - VerblijfstitelhistorieHalCollectie__embedded --> VerblijfstitelhistorieHalCollectieEmbedded
  - AangaanHuwelijkInOnderzoek --> AangaanHuwelijkPartnerschapInOnderzoek

- Schema-component Burgerservicenummer is verwijderd

- Enkele property-namen zijn gewijzigd
  - nationaliteithistorie.datumEindeGeldigheid --> nationaliteithistorie.datumTot
  - Verblijfplaatshistorie_links.nummeraanduiding --> VerblijfplaatshistorieLinks.adres
  - Verblijfplaats is anders opgebouwd.
    - Schema-component BinnenlandsAdres is verwijderd. Er wordt nu hergebruik gemaakt van het component Adres ipv het component BinnenlandsAdres
      - BinnenlandsAdres.openbareRuimteNaam --> Verblijfplaats.straat _**(breaking)**_
      - BinnenlandsAdres.functieAdres --> Verblijfplaats.functieAdres _**(breaking)**_
      - BinnenlandsAdres.aanduidingBijHuisnummer --> Verblijfplaats.aanduidingBijHuisnummer _**(breaking)**_
      - BinnenlandsAdres.identificatiecodeNummeraanduiding --> Verblijfplaats.nummeraanduidingIdentificatie _**(breaking)**_
      - BinnenlandsAdres.woonplaatsnaam --> Verblijfplaats.woonplaats _**(breaking)**_
      - Verblijfplaats.identificatiecodeAdresseerbaarObject --> Verblijfplaats.adresseerbaarObjectIdentificatie _**(breaking)**_
      - Verblijfplaats.straatnaam --> Verblijfplaats.korteNaam _**(breaking)**_
      - component verblijfBuitenland is komen te vervallen. _**(breaking)**_
    - Schema-component Verblijfbuitenland is verwijderd. Properties zijn opgenomen in Verblijfplaats.
      - VerblijfBuitenland.adresRegel1 --> Verblijfplaats.adresregel1 _**(breaking)**_
      - VerblijfBuitenland.adresRegel2 --> Verblijfplaats.adresregel2 (br _**(breaking)**_
      - VerblijfBuitenland.vertrokkenOnbekendWaarheen --> Verblijfplaats.vertrokkenOnbekendWaarheen _**(breaking)**_
      - VerblijfBuitenland.land --> Verblijfplaats.land _**(breaking)**_
    - VerblijfplaatsInOnderzoek.identificatiecodeNummeraanduiding --> VerblijfplaatsInOnderzoek.nummeraanduidingIdentificatie _**(breaking)**_
    - VerblijfplaatsInOnderzoek.identificatiecodeAdresseerbaarObject --> VerblijfplaatsInOnderzoek.adresseerbarObjectIdentificatie _**(breaking)**_
    - VerblijfplaatsInOnderzoek.straatnaam --> VerblijfplaatsInOnderzoek.korteNaam _**(breaking)**_
    - VerblijfplaatsInOnderzoek.naamOpenbareRuimte --> VerblijfplaatsInOnderzoek.straat _**(breaking)**_
    - VerblijfplaatsInOnderzoek.woonplaatsnaam --> VerblijfplaatsInOnderzoek.woonplaats _**(breaking)**_

- Toegevoegde properties:
  - OntbindingHuwelijkInOnderzoek.reden is toegevoegd

- Er is in de toelichting van Hallinks opgenomen dat een Hallink ook een templated link kan zijn.

### Features:

In het algemeen is de testdata verwijderd uit de feature-files. De feature files hebben als doel om functioneel de werking te beschrijven.

- nationaliteithistorie.feature is verplaatst naar [Haal-Centraal-BRP-historie-bevragen](./features)
- partnerhistorie.feature is verplaatst naar [Haal-Centraal-BRP-historie-bevragen](./features)
- verblijfplaatshistorie.feature is verplaatst naar [Haal-Centraal-BRP-historie-bevragen](./features)
- verblijfstitelhistorie.feature is verplaatst naar [Haal-Centraal-BRP-historie-bevragen](./features)
- onvolledige_datum.feature is verplaatst naar [Common](https://github.com/VNG-Realisatie/Haal-Centraal-common/tree/v1.2.0/features)
- expand.feature is verplaatst naar [Common](https://github.com/VNG-Realisatie/Haal-Centraal-common/tree/v1.2.0/features)
- fields.feature is verplaatst naar [Common](https://github.com/VNG-Realisatie/Haal-Centraal-common/tree/v1.2.0/features)
- foutafhandeling.feature is verplaatst naar [Common](https://github.com/VNG-Realisatie/Haal-Centraal-common/tree/v1.2.0/features)
- links.feature is verplaatst naar [Common](https://github.com/VNG-Realisatie/Haal-Centraal-common/tree/v1.2.0/features)
- wildcard.feature is verplaatst naar [Common](https://github.com/VNG-Realisatie/Haal-Centraal-common/tree/v1.2.0/features)
