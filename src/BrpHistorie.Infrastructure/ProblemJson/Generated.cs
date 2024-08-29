using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BrpHistorie.Infrastructure.ProblemJson;

[System.CodeDom.Compiler.GeneratedCode("NJsonSchema", "13.20.0.0 (NJsonSchema v10.9.0.0 (Newtonsoft.Json v13.0.0.0))")]
public partial class BadRequestFoutbericht : Foutbericht
{
    /// <summary>
    /// Foutmelding per fout in een parameter. Alle gevonden fouten worden één keer teruggemeld.
    /// </summary>
    [Newtonsoft.Json.JsonProperty("invalidParams", Required = Newtonsoft.Json.Required.DisallowNull, NullValueHandling = Newtonsoft.Json.NullValueHandling.Ignore)]
    public System.Collections.Generic.List<InvalidParams>? InvalidParams { get; set; }

}

/// <summary>
/// Terugmelding bij een fout. JSON representatie in lijn met [RFC7807](https://tools.ietf.org/html/rfc7807).
/// </summary>
[System.CodeDom.Compiler.GeneratedCode("NJsonSchema", "13.20.0.0 (NJsonSchema v10.9.0.0 (Newtonsoft.Json v13.0.0.0))")]
public partial class Foutbericht
{
    /// <summary>
    /// Link naar meer informatie over deze fout
    /// </summary>
    [Newtonsoft.Json.JsonProperty("type", Required = Newtonsoft.Json.Required.DisallowNull, NullValueHandling = Newtonsoft.Json.NullValueHandling.Ignore)]
    public System.Uri? Type { get; set; }

    /// <summary>
    /// Beschrijving van de fout
    /// </summary>
    [Newtonsoft.Json.JsonProperty("title", Required = Newtonsoft.Json.Required.DisallowNull, NullValueHandling = Newtonsoft.Json.NullValueHandling.Ignore)]
    public string? Title { get; set; }

    /// <summary>
    /// Http status code
    /// </summary>
    [Newtonsoft.Json.JsonProperty("status", Required = Newtonsoft.Json.Required.DisallowNull, NullValueHandling = Newtonsoft.Json.NullValueHandling.Ignore)]
    public int? Status { get; set; }

    /// <summary>
    /// Details over de fout
    /// </summary>
    [Newtonsoft.Json.JsonProperty("detail", Required = Newtonsoft.Json.Required.DisallowNull, NullValueHandling = Newtonsoft.Json.NullValueHandling.Ignore)]
    public string? Detail { get; set; }

    /// <summary>
    /// Uri van de aanroep die de fout heeft veroorzaakt
    /// </summary>
    [Newtonsoft.Json.JsonProperty("instance", Required = Newtonsoft.Json.Required.DisallowNull, NullValueHandling = Newtonsoft.Json.NullValueHandling.Ignore)]
    public System.Uri? Instance { get; set; }

    /// <summary>
    /// Systeemcode die het type fout aangeeft
    /// </summary>
    [Newtonsoft.Json.JsonProperty("code", Required = Newtonsoft.Json.Required.DisallowNull, NullValueHandling = Newtonsoft.Json.NullValueHandling.Ignore)]
    public string? Code { get; set; }

    private System.Collections.Generic.IDictionary<string, object>? _additionalProperties;

    [Newtonsoft.Json.JsonExtensionData]
    public System.Collections.Generic.IDictionary<string, object> AdditionalProperties
    {
        get { return _additionalProperties ?? (_additionalProperties = new System.Collections.Generic.Dictionary<string, object>()); }
        set { _additionalProperties = value; }
    }

}

/// <summary>
/// Details over fouten in opgegeven parameters
/// </summary>
[System.CodeDom.Compiler.GeneratedCode("NJsonSchema", "13.20.0.0 (NJsonSchema v10.9.0.0 (Newtonsoft.Json v13.0.0.0))")]
public partial class InvalidParams
{
    [Newtonsoft.Json.JsonProperty("type", Required = Newtonsoft.Json.Required.DisallowNull, NullValueHandling = Newtonsoft.Json.NullValueHandling.Ignore)]
    public System.Uri? Type { get; set; }

    /// <summary>
    /// Naam van de parameter
    /// </summary>
    [Newtonsoft.Json.JsonProperty("name", Required = Newtonsoft.Json.Required.DisallowNull, NullValueHandling = Newtonsoft.Json.NullValueHandling.Ignore)]
    public string? Name { get; set; }

    /// <summary>
    /// Systeemcode die het type fout aangeeft
    /// </summary>
    [Newtonsoft.Json.JsonProperty("code", Required = Newtonsoft.Json.Required.DisallowNull, NullValueHandling = Newtonsoft.Json.NullValueHandling.Ignore)]
    public string? Code { get; set; }

    /// <summary>
    /// Beschrijving van de fout op de parameterwaarde
    /// </summary>
    [Newtonsoft.Json.JsonProperty("reason", Required = Newtonsoft.Json.Required.DisallowNull, NullValueHandling = Newtonsoft.Json.NullValueHandling.Ignore)]
    public string? Reason { get; set; }

    private System.Collections.Generic.IDictionary<string, object>? _additionalProperties;

    [Newtonsoft.Json.JsonExtensionData]
    public System.Collections.Generic.IDictionary<string, object> AdditionalProperties
    {
        get { return _additionalProperties ?? (_additionalProperties = new System.Collections.Generic.Dictionary<string, object>()); }
        set { _additionalProperties = value; }
    }

}
