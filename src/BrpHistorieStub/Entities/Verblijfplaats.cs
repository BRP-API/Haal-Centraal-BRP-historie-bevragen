namespace HaalCentraal.BrpHistorieStub.Entities;

public class Verblijfplaats
{
    public string? Straat { get; set; }
    public int? Huisnummer { get; set; }
    public string? Huisletter { get; set; }
    public string? Huisnummertoevoeging { get; set; }
    public Waarde? AanduidingBijHuisnummer { get; set; }
    public string? Postcode { get; set; }
    public string? Woonplaats { get; set; }

    public string? Locatiebeschrijving { get; set; }

    public Waarde? Land { get; set; }
    public string? Regel1 { get; set; }
    public string? Regel2 { get; set; }
    public string? Regel3 { get; set; }

    public string? AdresseerbaarObjectIdentificatie { get; set; }
    public string? NummeraanduidingIdentificatie { get; set; }

    public string? DatumAanvangAdresBuitenland { get; set; }
    public string? DatumEindeAdresBuitenland { get; set; }

    public string? DatumAanvangAdreshouding { get; set; }
    public string? DatumEindeAdreshouding { get; set; }

    public Waarde? FunctieAdres { get; set; }

    public string? NaamOpenbareRuimte { get; set; }
    public Waarde? GemeenteVanInschrijving { get; set; }

    public VerblijfplaatsInOnderzoek? InOnderzoek { get; set; }
}

public class VerblijfplaatsInOnderzoek
{
    public string? AanduidingGegevensInOnderzoek { get; set; }
    public string? DatumIngangOnderzoek { get; set; }
}

public class Waarde
{
    public string? Code { get; set; }
}
