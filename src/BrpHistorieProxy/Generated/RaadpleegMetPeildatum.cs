namespace HaalCentraal.BrpHistorieProxy.Generated;

[System.CodeDom.Compiler.GeneratedCode("NJsonSchema", "13.20.0.0 (NJsonSchema v10.9.0.0 (Newtonsoft.Json v13.0.0.0))")]
public partial class RaadpleegMetPeildatum : HistorieQuery
{
    /// <summary>
    /// De datum waarop de resource wordt opgevraagd.
    /// <br/>
    /// </summary>
    [Newtonsoft.Json.JsonProperty("peildatum", Required = Newtonsoft.Json.Required.Default, NullValueHandling = Newtonsoft.Json.NullValueHandling.Ignore)]
    public string? Peildatum { get; set; }

}
