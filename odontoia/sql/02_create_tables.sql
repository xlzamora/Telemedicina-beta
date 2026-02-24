/*
  Script: 02_create_tables.sql
  Objetivo: Crear tablas transaccionales y catálogos del sistema ODONTOIA.
  Reglas:
  - Soft delete con IsDeleted
  - Auditoría básica: CreatedAt, UpdatedAt
  - FKs con ON DELETE NO ACTION
*/

USE [ODONTOIA_DB];
GO

/* =========================
   Catálogos base
   ========================= */

IF OBJECT_ID(N'dbo.CatalogoSexo', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.CatalogoSexo
    (
        IdSexo          TINYINT IDENTITY(1,1) NOT NULL,
        Codigo          NVARCHAR(10) NOT NULL,
        Nombre          NVARCHAR(50) NOT NULL,
        Activo          BIT NOT NULL CONSTRAINT DF_CatalogoSexo_Activo DEFAULT (1),
        CONSTRAINT PK_CatalogoSexo PRIMARY KEY (IdSexo),
        CONSTRAINT UQ_CatalogoSexo_Codigo UNIQUE (Codigo)
    );
END
GO

IF OBJECT_ID(N'dbo.CatalogoEstadoEvaluacion', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.CatalogoEstadoEvaluacion
    (
        IdEstadoEvaluacion  TINYINT IDENTITY(1,1) NOT NULL,
        Codigo              NVARCHAR(20) NOT NULL,
        Nombre              NVARCHAR(100) NOT NULL,
        Descripcion         NVARCHAR(250) NULL,
        Activo              BIT NOT NULL CONSTRAINT DF_CatalogoEstadoEvaluacion_Activo DEFAULT (1),
        CONSTRAINT PK_CatalogoEstadoEvaluacion PRIMARY KEY (IdEstadoEvaluacion),
        CONSTRAINT UQ_CatalogoEstadoEvaluacion_Codigo UNIQUE (Codigo)
    );
END
GO

IF OBJECT_ID(N'dbo.CatalogoSintomas', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.CatalogoSintomas
    (
        IdSintoma       INT IDENTITY(1,1) NOT NULL,
        Codigo          NVARCHAR(30) NOT NULL,
        Nombre          NVARCHAR(120) NOT NULL,
        Descripcion     NVARCHAR(300) NULL,
        Activo          BIT NOT NULL CONSTRAINT DF_CatalogoSintomas_Activo DEFAULT (1),
        CONSTRAINT PK_CatalogoSintomas PRIMARY KEY (IdSintoma),
        CONSTRAINT UQ_CatalogoSintomas_Codigo UNIQUE (Codigo)
    );
END
GO

IF OBJECT_ID(N'dbo.CatalogoPrioridad', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.CatalogoPrioridad
    (
        IdPrioridad     TINYINT IDENTITY(1,1) NOT NULL,
        Codigo          NVARCHAR(20) NOT NULL,
        Nombre          NVARCHAR(120) NOT NULL,
        Descripcion     NVARCHAR(300) NULL,
        Activo          BIT NOT NULL CONSTRAINT DF_CatalogoPrioridad_Activo DEFAULT (1),
        CONSTRAINT PK_CatalogoPrioridad PRIMARY KEY (IdPrioridad),
        CONSTRAINT UQ_CatalogoPrioridad_Codigo UNIQUE (Codigo)
    );
END
GO

IF OBJECT_ID(N'dbo.CatalogoMensajes', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.CatalogoMensajes
    (
        IdMensaje       INT IDENTITY(1,1) NOT NULL,
        Codigo          NVARCHAR(50) NOT NULL,
        Mensaje         NVARCHAR(MAX) NOT NULL,
        Activo          BIT NOT NULL CONSTRAINT DF_CatalogoMensajes_Activo DEFAULT (1),
        CONSTRAINT PK_CatalogoMensajes PRIMARY KEY (IdMensaje),
        CONSTRAINT UQ_CatalogoMensajes_Codigo UNIQUE (Codigo)
    );
END
GO

/* =========================
   Entidades principales
   ========================= */

IF OBJECT_ID(N'dbo.Pacientes', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.Pacientes
    (
        IdPaciente          INT IDENTITY(1,1) NOT NULL,
        Nombres             NVARCHAR(120) NOT NULL,
        Apellidos           NVARCHAR(120) NOT NULL,
        Documento           NVARCHAR(30) NOT NULL,
        FechaNacimiento     DATE NULL,
        IdSexo              TINYINT NULL,
        Telefono            NVARCHAR(30) NULL,
        Email               NVARCHAR(150) NULL,
        Direccion           NVARCHAR(250) NULL,
        CreatedAt           DATETIME2(3) NOT NULL CONSTRAINT DF_Pacientes_CreatedAt DEFAULT (SYSUTCDATETIME()),
        UpdatedAt           DATETIME2(3) NOT NULL CONSTRAINT DF_Pacientes_UpdatedAt DEFAULT (SYSUTCDATETIME()),
        IsDeleted           BIT NOT NULL CONSTRAINT DF_Pacientes_IsDeleted DEFAULT (0),
        CONSTRAINT PK_Pacientes PRIMARY KEY (IdPaciente),
        CONSTRAINT UQ_Pacientes_Documento UNIQUE (Documento),
        CONSTRAINT FK_Pacientes_CatalogoSexo FOREIGN KEY (IdSexo)
            REFERENCES dbo.CatalogoSexo(IdSexo)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
    );
END
GO

IF OBJECT_ID(N'dbo.EvaluacionesClinicas', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.EvaluacionesClinicas
    (
        IdEvaluacion            BIGINT IDENTITY(1,1) NOT NULL,
        IdPaciente              INT NOT NULL,
        FechaEvaluacion         DATETIME2(3) NOT NULL CONSTRAINT DF_Evaluaciones_FechaEvaluacion DEFAULT (SYSUTCDATETIME()),
        MotivoConsulta          NVARCHAR(500) NOT NULL,
        Observaciones           NVARCHAR(1000) NULL,
        IdEstadoEvaluacion      TINYINT NOT NULL,
        CreatedAt               DATETIME2(3) NOT NULL CONSTRAINT DF_Evaluaciones_CreatedAt DEFAULT (SYSUTCDATETIME()),
        UpdatedAt               DATETIME2(3) NOT NULL CONSTRAINT DF_Evaluaciones_UpdatedAt DEFAULT (SYSUTCDATETIME()),
        IsDeleted               BIT NOT NULL CONSTRAINT DF_Evaluaciones_IsDeleted DEFAULT (0),
        CONSTRAINT PK_EvaluacionesClinicas PRIMARY KEY (IdEvaluacion),
        CONSTRAINT FK_Evaluaciones_Pacientes FOREIGN KEY (IdPaciente)
            REFERENCES dbo.Pacientes(IdPaciente)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION,
        CONSTRAINT FK_Evaluaciones_Estado FOREIGN KEY (IdEstadoEvaluacion)
            REFERENCES dbo.CatalogoEstadoEvaluacion(IdEstadoEvaluacion)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
    );
END
GO

IF OBJECT_ID(N'dbo.EvaluacionSintomas', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.EvaluacionSintomas
    (
        IdEvaluacion        BIGINT NOT NULL,
        IdSintoma           INT NOT NULL,
        Valor               INT NOT NULL,
        Presente            BIT NOT NULL,
        CONSTRAINT PK_EvaluacionSintomas PRIMARY KEY (IdEvaluacion, IdSintoma),
        CONSTRAINT FK_EvaluacionSintomas_Evaluacion FOREIGN KEY (IdEvaluacion)
            REFERENCES dbo.EvaluacionesClinicas(IdEvaluacion)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION,
        CONSTRAINT FK_EvaluacionSintomas_Sintoma FOREIGN KEY (IdSintoma)
            REFERENCES dbo.CatalogoSintomas(IdSintoma)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION,
        CONSTRAINT CK_EvaluacionSintomas_Valor CHECK (Valor BETWEEN 0 AND 10)
    );
END
GO

IF OBJECT_ID(N'dbo.AntecedentesClinicos', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.AntecedentesClinicos
    (
        IdAntecedente       BIGINT IDENTITY(1,1) NOT NULL,
        IdEvaluacion        BIGINT NOT NULL,
        Alergias            BIT NOT NULL,
        Diabetes            BIT NOT NULL,
        Hipertension        BIT NOT NULL,
        Embarazo            BIT NULL,
        MedicacionActual    NVARCHAR(500) NULL,
        Observaciones       NVARCHAR(1000) NULL,
        CreatedAt           DATETIME2(3) NOT NULL CONSTRAINT DF_Antecedentes_CreatedAt DEFAULT (SYSUTCDATETIME()),
        UpdatedAt           DATETIME2(3) NOT NULL CONSTRAINT DF_Antecedentes_UpdatedAt DEFAULT (SYSUTCDATETIME()),
        IsDeleted           BIT NOT NULL CONSTRAINT DF_Antecedentes_IsDeleted DEFAULT (0),
        CONSTRAINT PK_AntecedentesClinicos PRIMARY KEY (IdAntecedente),
        CONSTRAINT UQ_Antecedentes_IdEvaluacion UNIQUE (IdEvaluacion),
        CONSTRAINT FK_Antecedentes_Evaluacion FOREIGN KEY (IdEvaluacion)
            REFERENCES dbo.EvaluacionesClinicas(IdEvaluacion)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
    );
END
GO

IF OBJECT_ID(N'dbo.ResultadosML', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.ResultadosML
    (
        IdResultadoML            BIGINT IDENTITY(1,1) NOT NULL,
        IdEvaluacion             BIGINT NOT NULL,
        IdPrioridad              TINYINT NOT NULL,
        ProbBaja                 DECIMAL(5,4) NOT NULL,
        ProbMedia                DECIMAL(5,4) NOT NULL,
        ProbAlta                 DECIMAL(5,4) NOT NULL,
        ModeloVersion            NVARCHAR(50) NOT NULL,
        UmbralDecision           DECIMAL(5,4) NULL,
        JsonFeaturesEnviadas     NVARCHAR(MAX) NULL,
        CreatedAt                DATETIME2(3) NOT NULL CONSTRAINT DF_ResultadosML_CreatedAt DEFAULT (SYSUTCDATETIME()),
        UpdatedAt                DATETIME2(3) NOT NULL CONSTRAINT DF_ResultadosML_UpdatedAt DEFAULT (SYSUTCDATETIME()),
        IsDeleted                BIT NOT NULL CONSTRAINT DF_ResultadosML_IsDeleted DEFAULT (0),
        CONSTRAINT PK_ResultadosML PRIMARY KEY (IdResultadoML),
        CONSTRAINT UQ_ResultadosML_IdEvaluacion UNIQUE (IdEvaluacion),
        CONSTRAINT FK_ResultadosML_Evaluacion FOREIGN KEY (IdEvaluacion)
            REFERENCES dbo.EvaluacionesClinicas(IdEvaluacion)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION,
        CONSTRAINT FK_ResultadosML_Prioridad FOREIGN KEY (IdPrioridad)
            REFERENCES dbo.CatalogoPrioridad(IdPrioridad)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION,
        CONSTRAINT CK_ResultadosML_ProbBaja CHECK (ProbBaja BETWEEN 0 AND 1),
        CONSTRAINT CK_ResultadosML_ProbMedia CHECK (ProbMedia BETWEEN 0 AND 1),
        CONSTRAINT CK_ResultadosML_ProbAlta CHECK (ProbAlta BETWEEN 0 AND 1),
        CONSTRAINT CK_ResultadosML_Umbral CHECK (UmbralDecision IS NULL OR UmbralDecision BETWEEN 0 AND 1)
    );
END
GO

IF OBJECT_ID(N'dbo.HistorialDiagnostico', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.HistorialDiagnostico
    (
        IdHistorial              BIGINT IDENTITY(1,1) NOT NULL,
        IdEvaluacion             BIGINT NOT NULL,
        DiagnosticoPreliminar    NVARCHAR(300) NOT NULL,
        Recomendaciones          NVARCHAR(MAX) NOT NULL,
        NivelConfianzaTexto      NVARCHAR(50) NULL,
        Disclaimer               NVARCHAR(MAX) NOT NULL,
        CreatedAt                DATETIME2(3) NOT NULL CONSTRAINT DF_Historial_CreatedAt DEFAULT (SYSUTCDATETIME()),
        UpdatedAt                DATETIME2(3) NOT NULL CONSTRAINT DF_Historial_UpdatedAt DEFAULT (SYSUTCDATETIME()),
        IsDeleted                BIT NOT NULL CONSTRAINT DF_Historial_IsDeleted DEFAULT (0),
        CONSTRAINT PK_HistorialDiagnostico PRIMARY KEY (IdHistorial),
        CONSTRAINT FK_Historial_Evaluacion FOREIGN KEY (IdEvaluacion)
            REFERENCES dbo.EvaluacionesClinicas(IdEvaluacion)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
    );
END
GO

IF OBJECT_ID(N'dbo.AuditoriaEventos', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.AuditoriaEventos
    (
        IdEvento         BIGINT IDENTITY(1,1) NOT NULL,
        Entidad          NVARCHAR(100) NOT NULL,
        EntidadId        NVARCHAR(100) NOT NULL,
        Accion           NVARCHAR(20) NOT NULL,
        Detalle          NVARCHAR(MAX) NULL,
        FechaEvento      DATETIME2(3) NOT NULL CONSTRAINT DF_AuditoriaEventos_FechaEvento DEFAULT (SYSUTCDATETIME()),
        Usuario          NVARCHAR(100) NULL,
        CONSTRAINT PK_AuditoriaEventos PRIMARY KEY (IdEvento),
        CONSTRAINT CK_AuditoriaEventos_Accion CHECK (Accion IN (N'INSERT', N'UPDATE', N'DELETE', N'PROCESS'))
    );
END
GO

/* =========================
   Índices recomendados
   ========================= */

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_Pacientes_Apellidos_Nombres' AND object_id = OBJECT_ID(N'dbo.Pacientes'))
BEGIN
    CREATE INDEX IX_Pacientes_Apellidos_Nombres
        ON dbo.Pacientes (Apellidos ASC, Nombres ASC);
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_Evaluaciones_IdPaciente_FechaEvaluacion' AND object_id = OBJECT_ID(N'dbo.EvaluacionesClinicas'))
BEGIN
    CREATE INDEX IX_Evaluaciones_IdPaciente_FechaEvaluacion
        ON dbo.EvaluacionesClinicas (IdPaciente ASC, FechaEvaluacion DESC);
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_HistorialDiagnostico_IdEvaluacion' AND object_id = OBJECT_ID(N'dbo.HistorialDiagnostico'))
BEGIN
    CREATE INDEX IX_HistorialDiagnostico_IdEvaluacion
        ON dbo.HistorialDiagnostico (IdEvaluacion ASC);
END
GO
