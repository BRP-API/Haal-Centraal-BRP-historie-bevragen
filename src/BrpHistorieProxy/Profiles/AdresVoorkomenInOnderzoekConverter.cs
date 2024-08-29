using AutoMapper;
using BrpHistorieProxy.Mappers;
using HaalCentraal.BrpHistorieProxy.Generated;
using HaalCentraal.BrpHistorieProxy.Generated.Gba;

namespace BrpHistorieProxy.Profiles;

public class AdresVoorkomenInOnderzoekConverter : ITypeConverter<GbaInOnderzoek, AdresVoorkomenInOnderzoek?>
{
    public AdresVoorkomenInOnderzoek? Convert(GbaInOnderzoek source, AdresVoorkomenInOnderzoek? destination, ResolutionContext context)
    {
        return source?.AanduidingGegevensInOnderzoek switch
        {
            "080000" or
            "089999" => CategorieAdresInOnderzoek(source),
            "081000" => GroepAdreshoudingInOnderzoek(source),
            "081010" => FunctieAdresInOnderzoek(source),
            "081030" or
            "081320" => DatumAanvangVerblijfInOnderzoek(source),
            "081100" => GroepAdresInOnderzoek(source),
            "081110" => StraatnaamInOnderzoek(source),
            "081180" => IdentificatiecodeVerblijfplaatsInOnderzoek(source),
            "081190" => IdentificatiecodeNummeraanduidingInOnderzoek(source),
            "081300" => GroepAdresBuitenlandInOnderzoek(source),
            _ => null,
        };
    }

    private static AdresVoorkomenInOnderzoek CategorieAdresInOnderzoek(GbaInOnderzoek source) =>
        new ()
        {
            AdresseerbaarObjectIdentificatie = true,
            DatumVan = true,
            FunctieAdres = true,
            NummeraanduidingIdentificatie = true,
            Type = true,
            DatumIngangOnderzoek = source?.DatumIngangOnderzoek.Map()
        };

    private static AdresVoorkomenInOnderzoek GroepAdreshoudingInOnderzoek(GbaInOnderzoek source) =>
        new ()
        {
            DatumVan = true,
            FunctieAdres = true,
            DatumIngangOnderzoek = source?.DatumIngangOnderzoek.Map()
        };

    private static AdresVoorkomenInOnderzoek FunctieAdresInOnderzoek(GbaInOnderzoek source) =>
        new ()
        {
            FunctieAdres = true,
            DatumIngangOnderzoek = source?.DatumIngangOnderzoek.Map()
        };

    private static AdresVoorkomenInOnderzoek DatumAanvangVerblijfInOnderzoek(GbaInOnderzoek source) =>
        new ()
        {
            DatumVan = true,
            DatumIngangOnderzoek = source?.DatumIngangOnderzoek.Map()
        };

    private static AdresVoorkomenInOnderzoek GroepAdresInOnderzoek(GbaInOnderzoek source) =>
        new ()
        {
            AdresseerbaarObjectIdentificatie = true,
            NummeraanduidingIdentificatie = true,
            Type = true,
            DatumIngangOnderzoek = source?.DatumIngangOnderzoek.Map()
        };

    private static AdresVoorkomenInOnderzoek StraatnaamInOnderzoek(GbaInOnderzoek source) =>
        new()
        {
            Type = true,
            DatumIngangOnderzoek = source?.DatumIngangOnderzoek.Map()
        };

    private static AdresVoorkomenInOnderzoek IdentificatiecodeVerblijfplaatsInOnderzoek(GbaInOnderzoek source) =>
        new()
        {
            AdresseerbaarObjectIdentificatie = true,
            DatumIngangOnderzoek = source?.DatumIngangOnderzoek.Map()
        };

    private static AdresVoorkomenInOnderzoek IdentificatiecodeNummeraanduidingInOnderzoek(GbaInOnderzoek source) =>
        new()
        {
            NummeraanduidingIdentificatie = true,
            DatumIngangOnderzoek = source?.DatumIngangOnderzoek.Map()
        };

    private static AdresVoorkomenInOnderzoek GroepAdresBuitenlandInOnderzoek(GbaInOnderzoek source) =>
        new ()
        {
            DatumVan = true,
            Type = true,
            DatumIngangOnderzoek = source?.DatumIngangOnderzoek.Map()
        };
}
