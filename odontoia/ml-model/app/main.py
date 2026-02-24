from fastapi import FastAPI

app = FastAPI(title="ODONTOIA ML API")


@app.get("/health")
def health() -> str:
    return "OK"
