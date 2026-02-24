using Domain.Common;

namespace Domain.Entities;

public sealed class AntecedenteClinico : BaseEntity
{
    public bool Diabetes { get; private set; }
    public bool Hipertension { get; private set; }
    public bool Alergias { get; private set; }
    public bool? Embarazo { get; private set; }
    public string? MedicacionActual { get; private set; }
    public string? Observaciones { get; private set; }

    public AntecedenteClinico(
        bool diabetes,
        bool hipertension,
        bool alergias,
        bool? embarazo = null,
        string? medicacionActual = null,
        string? observaciones = null)
    {
        Diabetes = diabetes;
        Hipertension = hipertension;
        Alergias = alergias;
        Embarazo = embarazo;
        MedicacionActual = string.IsNullOrWhiteSpace(medicacionActual) ? null : medicacionActual.Trim();
        Observaciones = string.IsNullOrWhiteSpace(observaciones) ? null : observaciones.Trim();
    }
}
