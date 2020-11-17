/* 
 * BRP historie bevragen
 *
 * API voor het zoeken en raadplegen van historische verblijfplaatsen, partners, nationaliteiten en verblijfstitels uit de BRP (inclusief de RNI).  Zie de [Functionele documentatie](https://github.com/VNG-Realisatie/Haal-Centraal-BRP-historie-bevragen/tree/v1.0.0/features) voor nadere toelichting. 
 *
 * The version of the OpenAPI document: 0.0.1 (develop)
 * 
 * Generated by: https://github.com/openapitools/openapi-generator.git
 */

using System;
using System.Linq;
using System.IO;
using System.Text;
using System.Text.RegularExpressions;
using System.Collections;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Runtime.Serialization;
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;
using System.ComponentModel.DataAnnotations;
using OpenAPIDateConverter = Org.OpenAPITools.Client.OpenAPIDateConverter;

namespace Org.OpenAPITools.Model
{
    /// <summary>
    /// Geeft aan dat de persoon behandeld wordt als Nederlander, of dat door de rechter is vastgesteld dat de persoon niet de Nederlandse nationaliteit bezit * &#x60;behandeld_als_nederlander&#x60; - B * &#x60;vastgesteld_niet_nederlander&#x60; - V 
    /// </summary>
    /// <value>Geeft aan dat de persoon behandeld wordt als Nederlander, of dat door de rechter is vastgesteld dat de persoon niet de Nederlandse nationaliteit bezit * &#x60;behandeld_als_nederlander&#x60; - B * &#x60;vastgesteld_niet_nederlander&#x60; - V </value>
    
    [JsonConverter(typeof(StringEnumConverter))]
    
    public enum AanduidingBijzonderNederlanderschapEnum
    {
        /// <summary>
        /// Enum Behandeldalsnederlander for value: behandeld_als_nederlander
        /// </summary>
        [EnumMember(Value = "behandeld_als_nederlander")]
        Behandeldalsnederlander = 1,

        /// <summary>
        /// Enum Vastgesteldnietnederlander for value: vastgesteld_niet_nederlander
        /// </summary>
        [EnumMember(Value = "vastgesteld_niet_nederlander")]
        Vastgesteldnietnederlander = 2

    }

}