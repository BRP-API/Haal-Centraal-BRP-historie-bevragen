namespace HaalCentraal.BrpHistorieProxy.Generated;

[System.CodeDom.Compiler.GeneratedCode("NJsonSchema", "13.20.0.0 (NJsonSchema v10.9.0.0 (Newtonsoft.Json v13.0.0.0))")]
public partial class RaadpleegMetPeriode : HistorieQuery
{
    /// <summary>
    /// De begindatum van de periode waarover de resource wordt opgevraagd.
    /// <br/>
    /// </summary>
    [Newtonsoft.Json.JsonProperty("datumVan", Required = Newtonsoft.Json.Required.Default, NullValueHandling = Newtonsoft.Json.NullValueHandling.Ignore)]
    public string? DatumVan { get; set; }

    /// <summary>
    /// De einddatum van de periode waarover de resource wordt opgevraagd.
    /// <br/>
    /// </summary>
    [Newtonsoft.Json.JsonProperty("datumTot", Required = Newtonsoft.Json.Required.Default, NullValueHandling = Newtonsoft.Json.NullValueHandling.Ignore)]
    public string? DatumTot { get; set; }

}
