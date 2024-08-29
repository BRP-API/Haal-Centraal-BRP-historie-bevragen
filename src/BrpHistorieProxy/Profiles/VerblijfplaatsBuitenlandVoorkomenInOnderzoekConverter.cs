using AutoMapper;
using BrpHistorieProxy.Mappers;
using HaalCentraal.BrpHistorieProxy.Generated;
using HaalCentraal.BrpHistorieProxy.Generated.Gba;

namespace BrpHistorieProxy.Profiles;

public class VerblijfplaatsBuitenlandVoorkomenInOnderzoekConverter : ITypeConverter<GbaInOnderzoek, VerblijfplaatsBuitenlandVoorkomenInOnderzoek?>
{
    public VerblijfplaatsBuitenlandVoorkomenInOnderzoek? Convert(GbaInOnderzoek source, VerblijfplaatsBuitenlandVoorkomenInOnderzoek? destination, ResolutionContext context)
    {
        return source?.AanduidingGegevensInOnderzoek switch
        {
            "080000" => CategorieVerblijfplaatsInOnderzoek(source),
            "081300" => GroepAdresBuitenlandInOnderzoek(source),
            "081310" => LandInOnderzoek(source),
            "081320" => DatumAanvangAdresBuitenlandInOnderzoek(source),
            _ => null,
        };
    }

    private static VerblijfplaatsBuitenlandVoorkomenInOnderzoek CategorieVerblijfplaatsInOnderzoek(GbaInOnderzoek source) =>
        new ()
        {
            DatumVan = true,
            Type = true,
            DatumIngangOnderzoek = source?.DatumIngangOnderzoek.Map()
        };

    private static VerblijfplaatsBuitenlandVoorkomenInOnderzoek GroepAdresBuitenlandInOnderzoek(GbaInOnderzoek source) =>
        new ()
        {
            DatumVan = true,
            Type = true,
            DatumIngangOnderzoek = source?.DatumIngangOnderzoek.Map()
        };

    private static VerblijfplaatsBuitenlandVoorkomenInOnderzoek LandInOnderzoek(GbaInOnderzoek source) =>
        new ()
        {
            Type = true,
            DatumIngangOnderzoek = source?.DatumIngangOnderzoek.Map()
        };

    private static VerblijfplaatsBuitenlandVoorkomenInOnderzoek DatumAanvangAdresBuitenlandInOnderzoek(GbaInOnderzoek source) =>
        new ()
        {
            DatumVan = true,
            DatumIngangOnderzoek = source?.DatumIngangOnderzoek.Map()
        };

}
