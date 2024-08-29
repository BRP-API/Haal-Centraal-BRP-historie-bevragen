namespace BrpHistorie.Infrastructure.Logging;

[AttributeUsage(AttributeTargets.Assembly)]
public class ApiVersionAttribute : Attribute
{
    public string Value { get; set; }

    public ApiVersionAttribute(string value)
    {
        Value = value;
    }
}
