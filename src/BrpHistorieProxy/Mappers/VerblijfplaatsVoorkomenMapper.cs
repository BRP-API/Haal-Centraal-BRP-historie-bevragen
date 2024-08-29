using HaalCentraal.BrpHistorieProxy.Generated;
using HaalCentraal.BrpHistorieProxy.Generated.Gba;

namespace BrpHistorieProxy.Mappers;

public static class VerblijfplaatsVoorkomenMapper
{
    public static bool HeeftDatumAanvangVolgendeVerblijf(this GbaVerblijfplaatsVoorkomen voorkomen) =>
        !string.IsNullOrWhiteSpace(voorkomen.DatumAanvangVolgendeAdreshouding) ||
        !string.IsNullOrWhiteSpace(voorkomen.DatumAanvangVolgendeAdresBuitenland);

    public static AbstractDatum? MapDatumTot(this GbaVerblijfplaatsVoorkomen voorkomen) =>
        voorkomen switch
        {
            { DatumAanvangVolgendeAdresBuitenland: var datum } when !string.IsNullOrWhiteSpace(datum) => datum.Map(),
            { DatumAanvangVolgendeAdreshouding: var datum } when !string.IsNullOrWhiteSpace(datum) => datum.Map(),
            _ => null
        };

    public static AbstractDatum? MapDatumVan(this GbaVerblijfplaatsVoorkomen voorkomen) =>
        voorkomen switch
        {
            { DatumAanvangAdresBuitenland: var datum } when !string.IsNullOrWhiteSpace(datum) => datum.Map(),
            { DatumAanvangAdreshouding: var datum } when !string.IsNullOrWhiteSpace(datum) => datum.Map(),
            _ => null
        };
}
