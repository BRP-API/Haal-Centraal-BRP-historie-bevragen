using AutoMapper;
using HaalCentraal.BrpHistorieProxy.Generated;
using HaalCentraal.BrpHistorieProxy.Generated.Gba;

namespace BrpHistorieProxy.Profiles;

public static class VerblijfplaatsVoorkomenConverterExtensions
{
    public static bool IsOnbekendVerblijfplaatsBuitenlandVoorkomen(this GbaVerblijfplaatsVoorkomen source) =>
        source.Land != null &&
        source.Land.Code == "0000";

    public static bool IsVerblijfplaatsBuitenlandVoorkomen(this GbaVerblijfplaatsVoorkomen source) =>
        source.Land != null &&
        source.Land.Code != "0000";

    public static bool IsAdresVoorkomen(this GbaVerblijfplaatsVoorkomen source) => !string.IsNullOrWhiteSpace(source.Straat);

    public static bool IsLocatieVoorkomen(this GbaVerblijfplaatsVoorkomen source) => !string.IsNullOrWhiteSpace(source.Locatiebeschrijving);
}

public class VerblijfplaatsVoorkomenConverter : ITypeConverter<GbaVerblijfplaatsVoorkomen, AbstractVerblijfplaatsVoorkomen?>
{
    public AbstractVerblijfplaatsVoorkomen? Convert(GbaVerblijfplaatsVoorkomen source, AbstractVerblijfplaatsVoorkomen? destination, ResolutionContext context)
    {
        if (source == null)
        {
            return null;
        }
        if (source.IsOnbekendVerblijfplaatsBuitenlandVoorkomen())
        {
            return context.Mapper.Map<VerblijfplaatsOnbekendVoorkomen>(source);
        }
        if (source.IsVerblijfplaatsBuitenlandVoorkomen())
        {
            return context.Mapper.Map<VerblijfplaatsBuitenlandVoorkomen>(source);
        }
        if (source.IsAdresVoorkomen())
        {
            return context.Mapper.Map<AdresVoorkomen>(source);
        }
        if (source.IsLocatieVoorkomen())
        {
            return context.Mapper.Map<LocatieVoorkomen>(source);
        }
        return null;
    }
}