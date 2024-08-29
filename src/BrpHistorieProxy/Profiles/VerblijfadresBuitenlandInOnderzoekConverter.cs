using AutoMapper;
using BrpHistorieProxy.Mappers;
using HaalCentraal.BrpHistorieProxy.Generated;
using HaalCentraal.BrpHistorieProxy.Generated.Gba;

namespace BrpHistorieProxy.Profiles;

public class VerblijfadresBuitenlandInOnderzoekConverter : ITypeConverter<GbaInOnderzoek, VerblijfadresBuitenlandInOnderzoek?>
{
    public VerblijfadresBuitenlandInOnderzoek? Convert(GbaInOnderzoek source, VerblijfadresBuitenlandInOnderzoek? destination, ResolutionContext context)
    {
        return source?.AanduidingGegevensInOnderzoek switch
        {
            "080000" or
            "081300" => GroepAdresBuitenlandInOnderzoek(source),
            "081310" => LandInOnderzoek(source),
            "081330" => Regel1InOnderzoek(source),
            "081340" => Regel2InOnderzoek(source),
            "081350" => Regel3InOnderzoek(source),
            _ => null,
        };
    }

    private static VerblijfadresBuitenlandInOnderzoek GroepAdresBuitenlandInOnderzoek(GbaInOnderzoek source) =>
        new ()
        {
            Regel1 = true,
            Regel2 = true,
            Regel3 = true,
            Land = true,
            DatumIngangOnderzoek = source?.DatumIngangOnderzoek.Map()
        };

    private static VerblijfadresBuitenlandInOnderzoek LandInOnderzoek(GbaInOnderzoek source) =>
        new ()
        {
            Land = true,
            DatumIngangOnderzoek = source?.DatumIngangOnderzoek.Map()
        };

    private static VerblijfadresBuitenlandInOnderzoek Regel1InOnderzoek(GbaInOnderzoek source) =>
        new ()
        {
            Regel1 = true,
            DatumIngangOnderzoek = source?.DatumIngangOnderzoek.Map()
        };

    private static VerblijfadresBuitenlandInOnderzoek Regel2InOnderzoek(GbaInOnderzoek source) =>
        new ()
        {
            Regel2 = true,
            DatumIngangOnderzoek = source?.DatumIngangOnderzoek.Map()
        };

    private static VerblijfadresBuitenlandInOnderzoek Regel3InOnderzoek(GbaInOnderzoek source) =>
        new ()
        {
            Regel3 = true,
            DatumIngangOnderzoek = source?.DatumIngangOnderzoek.Map()
        };

}
