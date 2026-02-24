using Domain.Exceptions;

namespace Domain.ValueObjects;

public sealed class DocumentoIdentidad : IEquatable<DocumentoIdentidad>
{
    public string Numero { get; }

    public DocumentoIdentidad(string numero)
    {
        if (string.IsNullOrWhiteSpace(numero))
        {
            throw new DomainException("El documento de identidad es obligatorio.");
        }

        Numero = numero.Trim();
    }

    public bool Equals(DocumentoIdentidad? other)
    {
        if (other is null)
        {
            return false;
        }

        return string.Equals(Numero, other.Numero, StringComparison.OrdinalIgnoreCase);
    }

    public override bool Equals(object? obj) => Equals(obj as DocumentoIdentidad);

    public override int GetHashCode() => StringComparer.OrdinalIgnoreCase.GetHashCode(Numero);
}
