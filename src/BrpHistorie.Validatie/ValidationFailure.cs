namespace BrpHistorie.Validatie;

public class ValidationFailure
{
    public ValidationFailure(string code, string name, string reason)
    {
        Code = code;
        Name = name;
        Reason = reason;
    }

    public string Code { get; }
    public string Name { get; }
    public string Reason { get; }
}
