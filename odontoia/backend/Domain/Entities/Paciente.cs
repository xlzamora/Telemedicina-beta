using Domain.Common;
using Domain.Enums;
using Domain.Exceptions;
using Domain.ValueObjects;

namespace Domain.Entities;

public sealed class Paciente : BaseEntity
{
    public NombreCompleto Nombre { get; private set; }
    public DocumentoIdentidad Documento { get; private set; }
    public DateTime? FechaNacimiento { get; private set; }
    public Sexo Sexo { get; private set; }
    public string? Telefono { get; private set; }
    public string? Email { get; private set; }
    public string? Direccion { get; private set; }

    public Paciente(
        NombreCompleto nombre,
        DocumentoIdentidad documento,
        Sexo sexo,
        DateTime? fechaNacimiento = null,
        string? telefono = null,
        string? email = null,
        string? direccion = null)
    {
        Nombre = nombre ?? throw new DomainException("El nombre del paciente es obligatorio.");
        Documento = documento ?? throw new DomainException("El documento del paciente es obligatorio.");
        Sexo = sexo;
        FechaNacimiento = fechaNacimiento;
        Telefono = string.IsNullOrWhiteSpace(telefono) ? null : telefono.Trim();
        Email = string.IsNullOrWhiteSpace(email) ? null : email.Trim();
        Direccion = string.IsNullOrWhiteSpace(direccion) ? null : direccion.Trim();
    }
}
