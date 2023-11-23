namespace HaalCentraal.BrpHistorieProxy.Generated;

[Newtonsoft.Json.JsonConverter(typeof(JsonInheritanceConverter), "type")]
[JsonInheritanceAttribute("RaadpleegMetPeildatum", typeof(RaadpleegMetPeildatum))]
[JsonInheritanceAttribute("RaadpleegMetPeriode", typeof(RaadpleegMetPeriode))]
[System.CodeDom.Compiler.GeneratedCode("NJsonSchema", "13.20.0.0 (NJsonSchema v10.9.0.0 (Newtonsoft.Json v13.0.0.0))")]
public partial class HistorieQuery
{
    [Newtonsoft.Json.JsonProperty("burgerservicenummer", Required = Newtonsoft.Json.Required.DisallowNull, NullValueHandling = Newtonsoft.Json.NullValueHandling.Ignore)]
    public string? Burgerservicenummer { get; set; }

    /// <summary>
    /// consumers die niet zijn geautoriseerd voor verblijfplaats buitenland kunnen deze parameter gebruiken om alleen binnenlandse verblijfplaats voorkomens te vragen
    /// <br/>
    /// </summary>
    [Newtonsoft.Json.JsonProperty("exclusiefVerblijfplaatsBuitenland", Required = Newtonsoft.Json.Required.DisallowNull, NullValueHandling = Newtonsoft.Json.NullValueHandling.Ignore)]
    public bool? ExclusiefVerblijfplaatsBuitenland { get; set; }

    private System.Collections.Generic.IDictionary<string, object>? _additionalProperties;

    [Newtonsoft.Json.JsonExtensionData]
    public System.Collections.Generic.IDictionary<string, object> AdditionalProperties
    {
        get { return _additionalProperties ?? (_additionalProperties = new System.Collections.Generic.Dictionary<string, object>()); }
        set { _additionalProperties = value; }
    }

}
