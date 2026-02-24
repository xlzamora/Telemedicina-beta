using Domain.Exceptions;

namespace Domain.ValueObjects;

public sealed class NombreCompleto : IEquatable<NombreCompleto>
{
    public string Nombres { get; }
    public string Apellidos { get; }

    public NombreCompleto(string nombres, string apellidos)
    {
        if (string.IsNullOrWhiteSpace(nombres))
        {
            throw new DomainException("Los nombres son obligatorios.");
        }

        if (string.IsNullOrWhiteSpace(apellidos))
        {
            throw new DomainException("Los apellidos son obligatorios.");
        }

        Nombres = nombres.Trim();
        Apellidos = apellidos.Trim();
    }

    public bool Equals(NombreCompleto? other)
    {
        if (other is null)
        {
            return false;
        }

        return string.Equals(Nombres, other.Nombres, StringComparison.OrdinalIgnoreCase)
               && string.Equals(Apellidos, other.Apellidos, StringComparison.OrdinalIgnoreCase);
    }

    public override bool Equals(object? obj) => Equals(obj as NombreCompleto);

    public override int GetHashCode() => HashCode.Combine(
        StringComparer.OrdinalIgnoreCase.GetHashCode(Nombres),
        StringComparer.OrdinalIgnoreCase.GetHashCode(Apellidos));
}
