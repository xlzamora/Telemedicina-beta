using Domain.Common;
using Domain.Exceptions;

namespace Domain.Entities;

public sealed class SintomaEvaluado : BaseEntity
{
    public string CodigoSintoma { get; private set; }
    public string Nombre { get; private set; }
    public int Intensidad { get; private set; }
    public bool Presente { get; private set; }

    public SintomaEvaluado(string codigoSintoma, string nombre, int intensidad, bool presente)
    {
        if (string.IsNullOrWhiteSpace(codigoSintoma))
        {
            throw new DomainException("El código del síntoma es obligatorio.");
        }

        if (string.IsNullOrWhiteSpace(nombre))
        {
            throw new DomainException("El nombre del síntoma es obligatorio.");
        }

        if (intensidad < 0 || intensidad > 10)
        {
            throw new DomainException("La intensidad del síntoma debe estar entre 0 y 10.");
        }

        CodigoSintoma = codigoSintoma.Trim();
        Nombre = nombre.Trim();
        Intensidad = intensidad;
        Presente = presente;
    }
}
