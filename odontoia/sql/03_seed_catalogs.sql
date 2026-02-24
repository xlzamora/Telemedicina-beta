/*
  Script: 03_seed_catalogs.sql
  Objetivo: Sembrar catálogos mínimos del sistema ODONTOIA.
*/

USE [ODONTOIA_DB];
GO

/* =========================
   CatalogoEstadoEvaluacion
   ========================= */
IF NOT EXISTS (SELECT 1 FROM dbo.CatalogoEstadoEvaluacion WHERE Codigo = N'PENDIENTE')
    INSERT INTO dbo.CatalogoEstadoEvaluacion (Codigo, Nombre, Descripcion)
    VALUES (N'PENDIENTE', N'Pendiente', N'Evaluación registrada y pendiente de procesamiento por el modelo');

IF NOT EXISTS (SELECT 1 FROM dbo.CatalogoEstadoEvaluacion WHERE Codigo = N'PROCESADA')
    INSERT INTO dbo.CatalogoEstadoEvaluacion (Codigo, Nombre, Descripcion)
    VALUES (N'PROCESADA', N'Procesada', N'Evaluación con resultado de clasificación generado');

IF NOT EXISTS (SELECT 1 FROM dbo.CatalogoEstadoEvaluacion WHERE Codigo = N'ANULADA')
    INSERT INTO dbo.CatalogoEstadoEvaluacion (Codigo, Nombre, Descripcion)
    VALUES (N'ANULADA', N'Anulada', N'Evaluación anulada por inconsistencia o solicitud clínica');
GO

/* =========================
   CatalogoPrioridad
   ========================= */
IF NOT EXISTS (SELECT 1 FROM dbo.CatalogoPrioridad WHERE Codigo = N'BAJA')
    INSERT INTO dbo.CatalogoPrioridad (Codigo, Nombre, Descripcion)
    VALUES (N'BAJA', N'Preventivo', N'Riesgo bajo, mantener controles preventivos.');

IF NOT EXISTS (SELECT 1 FROM dbo.CatalogoPrioridad WHERE Codigo = N'MEDIA')
    INSERT INTO dbo.CatalogoPrioridad (Codigo, Nombre, Descripcion)
    VALUES (N'MEDIA', N'Requiere Evaluación', N'Se recomienda evaluación odontológica programada.');

IF NOT EXISTS (SELECT 1 FROM dbo.CatalogoPrioridad WHERE Codigo = N'ALTA')
    INSERT INTO dbo.CatalogoPrioridad (Codigo, Nombre, Descripcion)
    VALUES (N'ALTA', N'Urgente', N'Requiere atención odontológica prioritaria.');
GO

/* =========================
   CatalogoSintomas
   ========================= */
IF NOT EXISTS (SELECT 1 FROM dbo.CatalogoSintomas WHERE Codigo = N'DOLOR')
    INSERT INTO dbo.CatalogoSintomas (Codigo, Nombre, Descripcion)
    VALUES (N'DOLOR', N'Dolor dental', N'Dolor espontáneo o provocado en diente, encía o maxilar.');

IF NOT EXISTS (SELECT 1 FROM dbo.CatalogoSintomas WHERE Codigo = N'INFLAMACION')
    INSERT INTO dbo.CatalogoSintomas (Codigo, Nombre, Descripcion)
    VALUES (N'INFLAMACION', N'Inflamación', N'Aumento de volumen o edema en tejidos orales.');

IF NOT EXISTS (SELECT 1 FROM dbo.CatalogoSintomas WHERE Codigo = N'SANGRADO')
    INSERT INTO dbo.CatalogoSintomas (Codigo, Nombre, Descripcion)
    VALUES (N'SANGRADO', N'Sangrado', N'Sangrado gingival espontáneo o al cepillado.');

IF NOT EXISTS (SELECT 1 FROM dbo.CatalogoSintomas WHERE Codigo = N'MOVILIDAD')
    INSERT INTO dbo.CatalogoSintomas (Codigo, Nombre, Descripcion)
    VALUES (N'MOVILIDAD', N'Movilidad dental', N'Sensación o evidencia de movilidad en piezas dentales.');

IF NOT EXISTS (SELECT 1 FROM dbo.CatalogoSintomas WHERE Codigo = N'FIEBRE')
    INSERT INTO dbo.CatalogoSintomas (Codigo, Nombre, Descripcion)
    VALUES (N'FIEBRE', N'Fiebre', N'Fiebre asociada a posible proceso infeccioso odontológico.');

IF NOT EXISTS (SELECT 1 FROM dbo.CatalogoSintomas WHERE Codigo = N'TRAUMA')
    INSERT INTO dbo.CatalogoSintomas (Codigo, Nombre, Descripcion)
    VALUES (N'TRAUMA', N'Trauma bucodental', N'Golpe o lesión reciente en región bucal/dental.');
GO

/* =========================
   CatalogoMensajes (disclaimer estándar)
   ========================= */
IF NOT EXISTS (SELECT 1 FROM dbo.CatalogoMensajes WHERE Codigo = N'DISCLAIMER_PRELIMINAR_ODONTOIA')
    INSERT INTO dbo.CatalogoMensajes (Codigo, Mensaje)
    VALUES
    (
        N'DISCLAIMER_PRELIMINAR_ODONTOIA',
        N'Este diagnóstico preliminar es orientativo y no reemplaza la evaluación clínica presencial de un odontólogo. Ante dolor intenso, fiebre, sangrado persistente o trauma, acuda de inmediato a atención profesional.'
    );
GO
