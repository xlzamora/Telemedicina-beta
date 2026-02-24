# ODONTOIA Monorepo

Estructura base del proyecto **ODONTOIA – Sistema Web Inteligente de Diagnóstico Preliminar Odontológico**.

## Requisitos

- .NET SDK 8.0+
- Node.js 20+
- npm 10+
- Python 3.10+

## Ejecutar backend

```bash
cd backend/WebApi
dotnet restore
dotnet run
```

API de salud: `GET http://localhost:5000/health` o `https://localhost:5001/health`

## Ejecutar frontend

```bash
cd frontend
npm install
npm run dev
```

## Ejecutar ml-model

```bash
cd ml-model
pip install -r requirements.txt
uvicorn app.main:app --reload
```
