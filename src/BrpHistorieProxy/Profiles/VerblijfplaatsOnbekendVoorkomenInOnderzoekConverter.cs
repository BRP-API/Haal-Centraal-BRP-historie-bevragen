using AutoMapper;
using BrpHistorieProxy.Mappers;
using HaalCentraal.BrpHistorieProxy.Generated;
using HaalCentraal.BrpHistorieProxy.Generated.Gba;

namespace BrpHistorieProxy.Profiles;

public class VerblijfplaatsOnbekendVoorkomenInOnderzoekConverter : ITypeConverter<GbaInOnderzoek, VerblijfplaatsOnbekendVoorkomenInOnderzoek?>
{
    public VerblijfplaatsOnbekendVoorkomenInOnderzoek? Convert(GbaInOnderzoek source, VerblijfplaatsOnbekendVoorkomenInOnderzoek? destination, ResolutionContext context)
    {
        return source?.AanduidingGegevensInOnderzoek switch
        {
            "080000" or
            "081300" => GroepAdresBuitenlandInOnderzoek(source),
            "081310" => LandInOnderzoek(source),
            "081320" => DatumAanvangAdresBuitenlandInOnderzoek(source),
            _ => null,
        };
    }

    private static VerblijfplaatsOnbekendVoorkomenInOnderzoek GroepAdresBuitenlandInOnderzoek(GbaInOnderzoek source) =>
        new ()
        {
            DatumVan = true,
            Type = true,
            DatumIngangOnderzoek = source?.DatumIngangOnderzoek.Map()
        };

    private static VerblijfplaatsOnbekendVoorkomenInOnderzoek LandInOnderzoek(GbaInOnderzoek source) =>
        new ()
        {
            Type = true,
            DatumIngangOnderzoek = source?.DatumIngangOnderzoek.Map()
        };

    private static VerblijfplaatsOnbekendVoorkomenInOnderzoek DatumAanvangAdresBuitenlandInOnderzoek(GbaInOnderzoek source) =>
        new ()
        {
            DatumVan = true,
            DatumIngangOnderzoek = source?.DatumIngangOnderzoek.Map()
        };
}
