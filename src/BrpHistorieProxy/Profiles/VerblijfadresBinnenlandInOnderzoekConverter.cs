using AutoMapper;
using BrpHistorieProxy.Mappers;
using HaalCentraal.BrpHistorieProxy.Generated;
using HaalCentraal.BrpHistorieProxy.Generated.Gba;

namespace BrpHistorieProxy.Profiles;

public class VerblijfadresBinnenlandInOnderzoekConverter : ITypeConverter<GbaInOnderzoek, VerblijfadresBinnenlandInOnderzoek?>
{
    public VerblijfadresBinnenlandInOnderzoek? Convert(GbaInOnderzoek source, VerblijfadresBinnenlandInOnderzoek? destination, ResolutionContext context)
    {
        return source?.AanduidingGegevensInOnderzoek switch
        {
            "080000" or
            "081100" or
            "089999" => CategorieVerblijfplaatsInOnderzoek(source),
            "080900" or
            "080910" => GroepGemeenteInOnderzoek(source),
            "081110" => StraatnaamInOnderzoek(source),
            "081115" => NaamOpenbareRuimteInOnderzoek(source),
            "081120" => HuisnummerInOnderzoek(source),
            "081130" => HuisletterInOnderzoek(source),
            "081140" => HuisnummertoevoegingInOnderzoek(source),
            "081150" => AanduidingBijHuisnummerInOnderzoek(source),
            "081160" => PostcodeInOnderzoek(source),
            "081170" => WoonplaatsnaamInOnderzoek(source),
            _ => null,
        };
    }

    private static VerblijfadresBinnenlandInOnderzoek CategorieVerblijfplaatsInOnderzoek(GbaInOnderzoek source) =>
        new ()
        {
            AanduidingBijHuisnummer = true,
            Huisletter = true,
            Huisnummer = true,
            Huisnummertoevoeging = true,
            KorteStraatnaam = true,
            Postcode = true,
            OfficieleStraatnaam = true,
            Woonplaats = true,
            DatumIngangOnderzoek = source?.DatumIngangOnderzoek.Map()
        };

    private static VerblijfadresBinnenlandInOnderzoek GroepGemeenteInOnderzoek(GbaInOnderzoek source) =>
        new()
        {
            Woonplaats = true,
            DatumIngangOnderzoek = source?.DatumIngangOnderzoek.Map()
        };

    private static VerblijfadresBinnenlandInOnderzoek StraatnaamInOnderzoek(GbaInOnderzoek source) =>
        new()
        {
            KorteStraatnaam = true,
            DatumIngangOnderzoek = source?.DatumIngangOnderzoek.Map()
        };

    private static VerblijfadresBinnenlandInOnderzoek NaamOpenbareRuimteInOnderzoek(GbaInOnderzoek source) =>
        new()
        {
            OfficieleStraatnaam = true,
            DatumIngangOnderzoek = source?.DatumIngangOnderzoek.Map()
        };

    private static VerblijfadresBinnenlandInOnderzoek HuisnummerInOnderzoek(GbaInOnderzoek source) =>
        new()
        {
            Huisnummer = true,
            DatumIngangOnderzoek = source?.DatumIngangOnderzoek.Map()
        };

    private static VerblijfadresBinnenlandInOnderzoek HuisletterInOnderzoek(GbaInOnderzoek source) =>
        new()
        {
            Huisletter = true,
            DatumIngangOnderzoek = source?.DatumIngangOnderzoek.Map()
        };

    private static VerblijfadresBinnenlandInOnderzoek HuisnummertoevoegingInOnderzoek(GbaInOnderzoek source) =>
        new()
        {
            Huisnummertoevoeging = true,
            DatumIngangOnderzoek = source?.DatumIngangOnderzoek.Map()
        };

    private static VerblijfadresBinnenlandInOnderzoek AanduidingBijHuisnummerInOnderzoek(GbaInOnderzoek source) =>
        new()
        {
            AanduidingBijHuisnummer = true,
            DatumIngangOnderzoek = source?.DatumIngangOnderzoek.Map()
        };

    private static VerblijfadresBinnenlandInOnderzoek PostcodeInOnderzoek(GbaInOnderzoek source) =>
        new()
        {
            Postcode = true,
            DatumIngangOnderzoek = source?.DatumIngangOnderzoek.Map()
        };

    private static VerblijfadresBinnenlandInOnderzoek WoonplaatsnaamInOnderzoek(GbaInOnderzoek source) =>
        new()
        {
            Woonplaats = true,
            DatumIngangOnderzoek = source?.DatumIngangOnderzoek.Map()
        };

}