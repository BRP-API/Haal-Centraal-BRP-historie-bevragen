using AutoMapper;
using BrpHistorieProxy.Mappers;
using HaalCentraal.BrpHistorieProxy.Generated;
using HaalCentraal.BrpHistorieProxy.Generated.Gba;

namespace BrpHistorieProxy.Profiles;

public class LocatieVoorkomenInOnderzoekConverter : ITypeConverter<GbaInOnderzoek, LocatieVoorkomenInOnderzoek?>
{
    public LocatieVoorkomenInOnderzoek? Convert(GbaInOnderzoek source, LocatieVoorkomenInOnderzoek? destination, ResolutionContext context)
    {
        return source?.AanduidingGegevensInOnderzoek switch
        {
            "080000" or
            "089999" => CategorieVerblijfplaatsInOnderzoek(source),
            "081000" => GroepAdreshoudingInOnderzoek(source),
            "081010" => FunctieAdresInOnderzoek(source),
            "081030" => DatumAanvangAdreshoudingInOnderzoek(source),
            "081200" or
            "081210" => GroepLocatieInOnderzoek(source),
            _ => null,
        };
    }

    private static LocatieVoorkomenInOnderzoek CategorieVerblijfplaatsInOnderzoek(GbaInOnderzoek source) =>
        new ()
        {
            DatumVan = true,
            FunctieAdres = true,
            Type = true,
            DatumIngangOnderzoek = source?.DatumIngangOnderzoek.Map()
        };

    private static LocatieVoorkomenInOnderzoek GroepAdreshoudingInOnderzoek(GbaInOnderzoek source) =>
        new ()
        {
            DatumVan = true,
            FunctieAdres = true,
            DatumIngangOnderzoek = source?.DatumIngangOnderzoek.Map()
        };

    private static LocatieVoorkomenInOnderzoek FunctieAdresInOnderzoek(GbaInOnderzoek source) =>
        new ()
        {
            FunctieAdres = true,
            DatumIngangOnderzoek = source?.DatumIngangOnderzoek.Map()
        };

    private static LocatieVoorkomenInOnderzoek DatumAanvangAdreshoudingInOnderzoek(GbaInOnderzoek source) =>
        new ()
        {
            DatumVan = true,
            DatumIngangOnderzoek = source?.DatumIngangOnderzoek.Map()
        };

    private static LocatieVoorkomenInOnderzoek GroepLocatieInOnderzoek(GbaInOnderzoek source) =>
        new ()
        {
            Type = true,
            DatumIngangOnderzoek = source?.DatumIngangOnderzoek.Map()
        };

}