from fastapi import FastAPI
from prometheus_client import Counter, generate_latest
from fastapi.responses import Response

app = FastAPI(title="DevOps Observability Demo")

REQUEST_COUNT = Counter(
    "http_requests_total",
    "Total HTTP Requests"
)


@app.get("/")
def root():
    REQUEST_COUNT.inc()

    return {
        "application": "observability-pw-int-test",
        "status": "running"
    }


@app.get("/health")
def health():
    REQUEST_COUNT.inc()

    return {
        "status": "healthy"
    }


@app.get("/api/orders")
def orders():
    REQUEST_COUNT.inc()

    return {
        "orders": [
            {"id": 1, "status": "completed"},
            {"id": 2, "status": "processing"},
            {"id": 3, "status": "completed"}
        ]
    }


@app.get("/metrics")
def metrics():
    return Response(
        generate_latest(),
        media_type="text/plain"
    )