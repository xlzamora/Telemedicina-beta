using Domain.Common;
using Domain.Enums;
using Domain.Exceptions;

namespace Domain.Entities;

public sealed class EvaluacionClinica : BaseEntity
{
    public int PacienteId { get; private set; }
    public DateTime FechaEvaluacion { get; private set; }
    public string MotivoConsulta { get; private set; }
    public EstadoEvaluacion Estado { get; private set; }
    public List<SintomaEvaluado> Sintomas { get; private set; }
    public AntecedenteClinico Antecedentes { get; private set; }
    public ResultadoML? ResultadoML { get; private set; }

    public EvaluacionClinica(int pacienteId, string motivoConsulta, DateTime? fechaEvaluacion = null)
    {
        if (pacienteId <= 0)
        {
            throw new DomainException("El identificador de paciente debe ser mayor a cero.");
        }

        if (string.IsNullOrWhiteSpace(motivoConsulta))
        {
            throw new DomainException("El motivo de consulta es obligatorio.");
        }

        PacienteId = pacienteId;
        MotivoConsulta = motivoConsulta.Trim();
        FechaEvaluacion = fechaEvaluacion ?? DateTime.UtcNow;
        Estado = EstadoEvaluacion.Pendiente;
        Sintomas = new List<SintomaEvaluado>();
        Antecedentes = new AntecedenteClinico(false, false, false);
    }

    public void AgregarSintoma(string codigoSintoma, string nombre, int intensidad, bool presente)
    {
        var sintoma = new SintomaEvaluado(codigoSintoma, nombre, intensidad, presente);
        Sintomas.Add(sintoma);
        MarkUpdated();
    }

    public void RegistrarAntecedentes(
        bool diabetes,
        bool hipertension,
        bool alergias,
        bool? embarazo = null,
        string? medicacionActual = null,
        string? observaciones = null)
    {
        Antecedentes = new AntecedenteClinico(diabetes, hipertension, alergias, embarazo, medicacionActual, observaciones);
        MarkUpdated();
    }

    public void AsignarResultadoML(ResultadoML resultado)
    {
        ResultadoML = resultado ?? throw new DomainException("El resultado de ML es obligatorio.");
        MarkUpdated();
    }

    public void MarcarProcesada()
    {
        if (ResultadoML is null)
        {
            throw new DomainException("No se puede procesar una evaluación sin resultado ML.");
        }

        Estado = EstadoEvaluacion.Procesada;
        MarkUpdated();
    }
}
