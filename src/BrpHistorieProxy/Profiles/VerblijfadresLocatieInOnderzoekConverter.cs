using AutoMapper;
using BrpHistorieProxy.Mappers;
using HaalCentraal.BrpHistorieProxy.Generated;
using HaalCentraal.BrpHistorieProxy.Generated.Gba;

namespace BrpHistorieProxy.Profiles;

public class VerblijfadresLocatieInOnderzoekConverter : ITypeConverter<GbaInOnderzoek, VerblijfadresLocatieInOnderzoek?>
{
    public VerblijfadresLocatieInOnderzoek? Convert(GbaInOnderzoek source, VerblijfadresLocatieInOnderzoek? destination, ResolutionContext context)
    {
        return source?.AanduidingGegevensInOnderzoek switch
        {
            "080000" or
            "081200" or
            "081210" or
            "089999" => GroepLocatieInOnderzoek(source),
            _ => null,
        };
    }

    private static VerblijfadresLocatieInOnderzoek? GroepLocatieInOnderzoek(GbaInOnderzoek source) =>
        new ()
        {
            Locatiebeschrijving = true,
            DatumIngangOnderzoek = source?.DatumIngangOnderzoek.Map()
        };

}
