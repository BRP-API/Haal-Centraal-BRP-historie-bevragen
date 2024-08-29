using BrpHistorie.Validatie;
using HaalCentraal.BrpHistorieProxy.Generated;
using Newtonsoft.Json.Linq;

namespace BrpHistorieProxy.Validators;

public static class HistorieQueryValidator
{
    public static ValidationResult Validate(this HistorieQuery? historieQuery, string requestBody)
    {
        var result = historieQuery switch
        {
            RaadpleegMetPeildatum query => new RaadpleegMetPeildatumValidator().Validate(query),
            RaadpleegMetPeriode query => new RaadpleegMetPeriodeValidator().Validate(query),
            _ => new HistorieQueryRequestBodyValidator().Validate(JObject.Parse(requestBody)),
        };

        return ValidationResult.CreateFrom(result);
    }
}
