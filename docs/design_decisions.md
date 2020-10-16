# Design decisions HaalCentraal BRP Historie Bevragen
Dit document beschrijft ontwerpkeuzes die gemaakt zijn voor het ontwerpen en specificeren van de API's.

## Algemene Design Decisions
In het document [design_desicions.md](https://github.com/VNG-Realisatie/Haal-Centraal-common/blob/master/docs/design_decisions.md) dat in de Haal-Centraal-common repository is opgenomen staan beslissingen opgesomd waar alle Haal Centraal API's zich aan conformeren.

## Resourcedefinitie binnen API voor elke gelinkte resource (heroverwegen ?)
Voor elke gelinkte resource (relatie) moet er binnen het BRP Historie bevragen API (ten minste tijdelijk) een resource beschreven (ontsloten) zijn. Voor een gelinkte resource buiten het BRP-domein wordt alleen het opvragen van de actuele status van de enkele resource gespecificeerd.

*Ratio*
Relaties worden opgenomen als uri naar de betreffende resource. De API voor het opvragen van de ingeschreven persoon moet dus URI's kunnen samenstellen die verwijzen naar de betreffende objecten (resources) en waar deze objecten (resources) ook daadwerkelijk op te vragen zijn.
Zo lang deze resources nog niet ontsloten zijn (in een API op betreffende bron) moeten deze dus binnen deze API beschreven worden.

## Identificatie van BAG-objecten in de BRP-Bevraging is een string
De identificatie van BAG-objecten wordt geïmplementeerd als string, waarin de delen worden samengevoegd:identificatiecode = gemeentecode + objecttypecode + objectvolgnummer.

*Ratio*

In het RSGB is de identificatie van BAG-objecten (bijvoorbeeld identificatiecode van een nummeraanduiding) opgenomen als complex datatype. In de BAG-registratie is dit echter één string waarin de deel-elementen uit het complex datatype zijn samengevoegd.
Zie issue [#1](https://github.com/VNG-Realisatie/Bevragingen-ingeschreven-personen/issues/1).

## Verblijfadres wordt relatie naar de nummeraanduiding plus een gegevensgroep
Het verblijfadres van een persoon wordt bij de persoon opgenomen als gegevensgroep. Daarin staan de adresgegevens zoals die in het GBA bekend zijn. In deze gegevensgroep zijn de relevantie adresgegevens platgeslagen, zodat de gebruiker eenvoudig alle adresgegevens beschikbaar heeft in het antwoord.

Wanneer het verblijfadres een BAG-adres is, wordt ook een relatie (link) naar de nummeraanduiding in het BAG opgenomen.

*Ratio*
Functionele vraag is: ik wil in één vraag een persoon met adres hebben.
Een groot deel van de vragen om persoonsgegevens is er direct behoefte aan de adresgegevens, zonder geïnteresseerd te zijn in de structuur in BAG (zoals naar nummeraanduiding, woonplaats, ligplaats, adresseerbaar object).
Zie https://www.rvig.nl/brp/vraag-en-antwoord/mag-een-persoon-worden-ingeschreven-op-een-locatieomschrijving-in-de-gba-als-er-geen-authentiek-bag-adres-is
Deze oplossing is ook een oplossing voor issue [22](https://github.com/VNG-Realisatie/Bevragingen-ingeschreven-personen/issues/22) en [14](https://github.com/VNG-Realisatie/Bevragingen-ingeschreven-personen/issues/14).

## Verblijfplaats wordt gevuld met adresgegevens uit het GBA als er geen BAG adres beschikbaar is
De verblijfplaats toont de adresgegevens zoals die in het GBA staan geregistreerd als er geen BAG nummeraanduiding en openbare ruimtenaam uit de BAG beschikbaar is.

*Ratio*
Vanuit het GBA hoeft er geen verbinding te zijn naar het BAG om de juiste adresgegevens op te halen.
Er is niet altijd een BAG-adres.
Zie https://www.rvig.nl/brp/vraag-en-antwoord/mag-een-persoon-worden-ingeschreven-op-een-locatieomschrijving-in-de-gba-als-er-geen-authentiek-bag-adres-is

## Geboortedatum wordt gegevensgroep met dag, maand en jaar
Ten behoeve van het ondersteunen van onvolledige datums, wordt de geboortedatum in de response een gegevensgroep "geboorte" met 4 properties:
- geboortejaar: date-fullyear
- geboortemaand: date-month
- geboortedag: date-mday
- geboortedatum: date

Deze velden zijn gedefinieerd in ISO8601-typen.
Als er een volledige geboortedatum is, worden alle 4 velden ingevuld, anders alleen de bekende delen.

*Ratio*
In de API moet het mogelijk zijn een persoon met gedeeltelijk onbekende geboortedatum op te nemen, zie issue [6](https://github.com/VNG-Realisatie/Bevragingen-ingeschreven-personen/issues/6).
De gekozen oplossing is het eenvoudigst te implementeren.

## gemeenteVanInschrijving is een property met gemeentecode

*Ratio*
Gemeente is een objecttype (en daarmee waarschijnlijk een resource van de BAG). Daarom zou je verwachten dat gemeenteVanInschrijving een relatie is. In het model is het echter een attribuut met de gemeentecode.
We houden dit een attribuut met gemeentecode, omdat dit gegeven wordt niet actief bijgehouden.

## Uitgangspunt voor modellering is de basisregistratie
Voor persoonsgegevens gebruiken we LO GBA 3.10.

*Ratio*
Het gaat om bevragen bij de bron. De bron voor persoonsgegevens is het GBA. Daarom moet het logisch ontwerp van de GBA worden gebruikt en er geen afwijkende RSGB-modellering zijn van persoonsgegevens.

## Opvragen van historie kan via specifieke endpoints
Opvragen van historie wordt gedefinieerd met aparte endpoints. Als een provider ervoor kiest om deze niet te implementeren wordt er een 501 geretourneerd. De historische bevraging krijgen dus resourcenaam waaruit blijkt dart het om een historische resource gaat.
Met deze API kan de historie op het betreffende aspect opgevraagd worden.

Hiermee wordt het zoeken/raadplegen van de volgende historie ondersteund:
- nationaliteithistorie (welke nationaliteiten heeft een persoon gehad)
- verblijfplaatshistorie (welke verblijfplaatsen heeft een persoon gehad)
- partnerhistorie (welke partnerrelaties heeft een persoon gehad)
- verblijftitelhistorie (welke verblijftitels heeft een persoon gehad)


Er kan gekozen worden om de status op peildatum te raadplegen met de queryparameter peildatum.
Er kan gekozen worden de historische voorkomens te raadplegen binnen een periode met queryparameters datumVan en datumTotEnMet.

- Het antwoordbericht van /verblijfplaatshistorie bevat \_links en \_embedded met de historische voorkomens van de verblijfplaats van de persoon. Hierin zit ook de property datumIngangGeldigheid.
- Het antwoordbericht van /verblijfstitelhistorie bevat de historische voorkomens van de verblijfstitel van de ingeschreven persoon en de properties datumEinde en datumIngang.
- Het antwoordbericht van /partnerhistorie bevat de historische voorkomens van partner-relaties (huwelijken of geregistreerd partnerschappen). Hierin zit in de groep aangaanHuwelijkPartnerschap een datum en in de groep ontbindingHuwelijkPartnerschap een datum.
- Het antwoordbericht van /nationaliteithistorie bevat de historische nationaliteiten die voor een persoon geregistreerd zijn. Hierin zitten de properties datumIngangGeldigheid en datumEindeGeldigheid. 


## Burgerservicenummer is unieke sleutel voor een ingeschreven natuurlijk persoon
De resource ingeschrevenPersonen wordt uniek geïdentificeerd met de sleutel burgerservicenummer.
Dus is het pad naar de gegevens van één persoon gedefinieerd als /ingeschrevenpersonen/{burgerservicenummer}

*Ratio*
Het burgerservicenummer is het persoonsnummer voor contact van een burger met de overheid. Andere registraties die verwijzen naar een persoon zullen geen andere unieke identificatie kennen dan het burgerservicenummer. Zolang andere registraties (zoals BRK en HR) alleen het burgerservicenummer als functionele sleutel van de persoon kennen kan er geen technische sleutel (UUID) gebruikt worden voor het ophalen van een enkele resource.
Ook voor apps die op bais van DigiD de persoonsgegevens ophalen kennen alleen het burgerservicenummer, geen technische sleutel.

## Bij het zoeken van personen is er een maximum aantal resultaten
Personen mogen alleen gericht worden gezocht. Daarom moet het aantal mogelijke resultaten op een zoekvraag worden gelimiteerd. Wanneer met opgegeven zoekparameters het aantal resultaten groter is dan het maximum, wordt een foutmelding gegeven en krijgt de gebruiker verder geen gevonden personen terug in het antwoord.
Er is dus ook geen paginering nodig in deze API.

Er wordt in de API standaard geen aantal als maximum vastgesteld. De provider van de API mag dit aantal zelf bepalen en optimaliseren op basis van ervaringen in het gebruik van de API.

## In onderzoek kan betrekking hebben op groepen van attributen én op individuele attributen
Groepen van attributen (zoals "naam" die o.a. voornamen en geslachtsnaam bevat) kunnen in zijn geheel in onderzoek zijn, maar ook kunnen individuele attributen in de groep (zoals alleen de voornamen) in onderzoek zijn.

Wanneer een hele groep attributen (als groep) in onderzoek is, wordt in het antwoord op de bevraging van de persoon elk attribuut van de groep aangegeven als in onderzoek.
