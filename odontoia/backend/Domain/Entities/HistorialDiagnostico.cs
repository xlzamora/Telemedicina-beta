using Domain.Common;
using Domain.Exceptions;

namespace Domain.Entities;

public sealed class HistorialDiagnostico : BaseEntity
{
    public int EvaluacionId { get; private set; }
    public string DiagnosticoPreliminar { get; private set; }
    public string Recomendaciones { get; private set; }
    public string DisclaimerLegal { get; private set; }

    public HistorialDiagnostico(
        int evaluacionId,
        string diagnosticoPreliminar,
        string recomendaciones,
        string disclaimerLegal)
    {
        if (evaluacionId <= 0)
        {
            throw new DomainException("El identificador de evaluación debe ser mayor a cero.");
        }

        if (string.IsNullOrWhiteSpace(diagnosticoPreliminar))
        {
            throw new DomainException("El diagnóstico preliminar es obligatorio.");
        }

        if (string.IsNullOrWhiteSpace(recomendaciones))
        {
            throw new DomainException("Las recomendaciones son obligatorias.");
        }

        if (string.IsNullOrWhiteSpace(disclaimerLegal))
        {
            throw new DomainException("El disclaimer legal es obligatorio.");
        }

        EvaluacionId = evaluacionId;
        DiagnosticoPreliminar = diagnosticoPreliminar.Trim();
        Recomendaciones = recomendaciones.Trim();
        DisclaimerLegal = disclaimerLegal.Trim();
    }
}
