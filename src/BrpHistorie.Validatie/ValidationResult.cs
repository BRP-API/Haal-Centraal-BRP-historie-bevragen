namespace BrpHistorie.Validatie;

public class ValidationResult
{
    public bool IsValid { get; }
    public List<ValidationFailure> Errors { get; }

    public static ValidationResult CreateFrom(FluentValidation.Results.ValidationResult result)
    {
        return new ValidationResult(result.IsValid, result.Errors);
    }

    private ValidationResult(bool isValid, List<FluentValidation.Results.ValidationFailure> errors)
    {
        IsValid = isValid;
        Errors = (from error in errors
                  select CreateFrom(error)).ToList();
    }

    private static ValidationFailure? CreateFrom(FluentValidation.Results.ValidationFailure validationFailure)
    {
        var messageParts = validationFailure.ErrorMessage.Split("||");

        return messageParts.Length switch
        {
            2 => new ValidationFailure(
                    messageParts[0],
                    $"{char.ToLowerInvariant(validationFailure.PropertyName[0])}{validationFailure.PropertyName[1..]}",
                    messageParts[1]),
            3 => new ValidationFailure(messageParts[1], messageParts[0], messageParts[2]),
            _ => null,
        };
    }
}
