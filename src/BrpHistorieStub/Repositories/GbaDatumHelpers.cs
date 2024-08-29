using System.Globalization;
using System.Text.RegularExpressions;

namespace HaalCentraal.BrpHistorieStub.Repositories;

public static class GbaDatumHelpers
{
    private static readonly Regex GbaDatumRegex = new("^(?<jaar>[0-9]{4})(?<maand>[0-9]{2})(?<dag>[0-9]{2})$", RegexOptions.None, TimeSpan.FromMilliseconds(100));

    public static long ToNumber(this string gbaDatum) => long.Parse(gbaDatum);

    public static long ToNumber(this DateTimeOffset datum) => datum.ToString("yyyyMMdd").ToNumber();

    private static (int jaar, int maand, int dag) Parse(this string datum)
    {
        var match = GbaDatumRegex.Match(datum);

        return (
            int.Parse(match.Groups["jaar"].Value, CultureInfo.InvariantCulture),
            int.Parse(match.Groups["maand"].Value, CultureInfo.InvariantCulture),
            int.Parse(match.Groups["dag"].Value, CultureInfo.InvariantCulture)
            );
    }

    private static DateTimeOffset ToDateTimeOffset(int jaar, int maand, int dag)
    {
        return new DateTimeOffset(new DateTime(jaar, maand, dag, 0, 0, 0, DateTimeKind.Utc));
    }

    public static DateTimeOffset ToDateTimeOffset(this long gbaDatum)
    {
        (int jaar, int maand, int dag) = gbaDatum.ToString().Parse();

        return ToDateTimeOffset(jaar, maand, dag);
    }

    public static DateTimeOffset ToDateTimeOffset(this int gbaDatum) => ((long)gbaDatum).ToDateTimeOffset();

    private static bool IsOnbekendDatum(int jaar, int maand, int dag)
    {
        return jaar == 0 && maand == 0 && dag == 0;
    }

    private static bool IsJaarDatum(int jaar, int maand, int dag)
    {
        return jaar > 0 && maand == 0 && dag == 0;
    }

    private static bool IsJaarMaandDatum(int jaar, int maand, int dag)
    {
        return jaar > 0 && maand > 0 && dag == 0;
    }

    public static long ToFloorNumber(this string? gbaDatum)
    {
        if (string.IsNullOrWhiteSpace(gbaDatum)) return 0;

        (int jaar, int maand, int dag) = gbaDatum.Parse();

        return ToFloorNumber(jaar, maand, dag);
    }

    private static long ToFloorNumber(int jaar, int maand, int dag)
    {
        if (IsOnbekendDatum(jaar, maand, dag)) return 0;
        if (IsJaarDatum(jaar, maand, dag)) return ToDateTimeOffset(jaar, 1, 1).ToNumber();
        if (IsJaarMaandDatum(jaar, maand, dag)) return ToDateTimeOffset(jaar, maand, 1).ToNumber();

        return ToDateTimeOffset(jaar, maand, dag).ToNumber();
    }

    public static long ToCeilingNumber(this string? gbaDatum)
    {
        if (string.IsNullOrWhiteSpace(gbaDatum)) return long.MaxValue;

        (int jaar, int maand, int dag) = gbaDatum.Parse();

        return ToCeilingNumber(jaar, maand, dag);
    }

    private static long ToCeilingNumber(int jaar, int maand, int dag)
    {
        if (IsOnbekendDatum(jaar, maand, dag)) return long.MaxValue;
        if (IsJaarDatum(jaar, maand, dag)) return ToDateTimeOffset(jaar, 1, 1).AddYears(1).ToNumber();
        if (IsJaarMaandDatum(jaar, maand, dag)) return ToDateTimeOffset(jaar, maand, 1).AddMonths(1).ToNumber();

        return ToDateTimeOffset(jaar, maand, dag).ToNumber();
    }

    public static IEnumerable<long> ToGbaDatum(this string? gbaDatum)
    {
        if (string.IsNullOrWhiteSpace(gbaDatum) ||
            !long.TryParse(gbaDatum, out _)) return Array.Empty<long>();

        try
        {
            var match = GbaDatumRegex.Match(gbaDatum);
            if (match.Success)
            {
                (var jaar, var maand, var dag) = gbaDatum.Parse();

                if (jaar > 0 && maand > 0 && dag > 0)
                {
                    return new[] { ToCeilingNumber(jaar, maand, dag) };
                }
                else if (IsOnbekendDatum(jaar, maand, dag))
                {
                    return Array.Empty<long>();
                }
                else
                {
                    return new[] { ToFloorNumber(jaar, maand, dag), ToCeilingNumber(jaar, maand, dag) };
                }
            }

            return Array.Empty<long>();
        }
        catch (Exception)
        {
            return Array.Empty<long>();
        }
    }

    public static (bool geheelOnvolledig, bool deelsOnvolledig) IsOnvolledigDatum(this string gbaDatum)
    {
        (int jaar, int maand, int dag) = gbaDatum.Parse();

        return (jaar == 0, jaar > 0 && (maand == 0 || dag == 0));
    }
}
