using Domain.Common;
using Domain.Enums;
using Domain.Exceptions;

namespace Domain.Entities;

public sealed class ResultadoML : BaseEntity
{
    public PrioridadCaso Prioridad { get; private set; }
    public decimal ProbabilidadBaja { get; private set; }
    public decimal ProbabilidadMedia { get; private set; }
    public decimal ProbabilidadAlta { get; private set; }
    public string VersionModelo { get; private set; }

    public ResultadoML(
        PrioridadCaso prioridad,
        decimal probabilidadBaja,
        decimal probabilidadMedia,
        decimal probabilidadAlta,
        string versionModelo)
    {
        if (string.IsNullOrWhiteSpace(versionModelo))
        {
            throw new DomainException("La versión del modelo es obligatoria.");
        }

        Prioridad = prioridad;
        ProbabilidadBaja = probabilidadBaja;
        ProbabilidadMedia = probabilidadMedia;
        ProbabilidadAlta = probabilidadAlta;
        VersionModelo = versionModelo.Trim();

        ValidarProbabilidades();
    }

    public void ValidarProbabilidades()
    {
        if (ProbabilidadBaja < 0 || ProbabilidadBaja > 1 ||
            ProbabilidadMedia < 0 || ProbabilidadMedia > 1 ||
            ProbabilidadAlta < 0 || ProbabilidadAlta > 1)
        {
            throw new DomainException("Las probabilidades deben estar en el rango [0,1].");
        }

        var suma = ProbabilidadBaja + ProbabilidadMedia + ProbabilidadAlta;
        if (Math.Abs(suma - 1m) > 0.0001m)
        {
            throw new DomainException("La suma de probabilidades debe ser aproximadamente 1.");
        }
    }
}
