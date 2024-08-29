using Newtonsoft.Json;

namespace BrpHistorie.Infrastructure.Json;

public static class JsonConvertExtensions
{
    public static string ToJson(this object obj)
    {
        return JsonConvert.SerializeObject(obj);
    }

    public static string ToJsonWithoutNullAndDefaultValues(this object? obj)
    {
        return JsonConvert.SerializeObject(obj, new JsonSerializerSettings
        {
            NullValueHandling = NullValueHandling.Ignore,
            DefaultValueHandling = DefaultValueHandling.Ignore
        });
    }
}
