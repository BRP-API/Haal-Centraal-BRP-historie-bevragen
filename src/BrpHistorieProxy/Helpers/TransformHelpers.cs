using AutoMapper;
using BrpHistorie.Infrastructure.Json;
using HaalCentraal.BrpHistorieProxy.Generated;
using Newtonsoft.Json;
using Gba = HaalCentraal.BrpHistorieProxy.Generated.Gba;

namespace BrpHistorieProxy.Helpers;

public static class TransformHelpers
{
    public static string Transform(this string payload, IMapper mapper)
    {
        var response = JsonConvert.DeserializeObject<Gba.VerblijfplaatshistorieQueryResponse>(payload);

        return mapper.Map<VerblijfplaatshistorieQueryResponse>(response)
                     .ToJsonWithoutNullAndDefaultValues();
    }
}
