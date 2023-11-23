namespace BrpHistorie.Infrastructure;

public static class StringExtensions
{
    public static string RemoveAllWhitespace(this string str)
    {
        return string.Join("", str.Split(default(string[]), StringSplitOptions.RemoveEmptyEntries));
    }
}
