/*
  Script: 01_create_database.sql
  Objetivo: Crear base de datos ODONTOIA_DB para SQL Server.
  Nota: Si no se especifica COLLATE, se usa el default del servidor.
*/

USE [master];
GO

IF DB_ID(N'ODONTOIA_DB') IS NULL
BEGIN
    CREATE DATABASE [ODONTOIA_DB];
END
GO

USE [ODONTOIA_DB];
GO

-- El esquema dbo ya existe por defecto en SQL Server. Se deja explícito para claridad.
IF SCHEMA_ID(N'dbo') IS NULL
BEGIN
    EXEC('CREATE SCHEMA [dbo] AUTHORIZATION [dbo];');
END
GO
