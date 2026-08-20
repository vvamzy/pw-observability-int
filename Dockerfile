FROM python:3.10-slim

WORKDIR /app

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY app/requirements.txt .

RUN pip install --no-cache-dir --upgrade \
    pip \
    setuptools>=78.1.1 \
    jaraco.context>=6.1.0 \
    wheel>=0.46.2 && \
    pip install --no-cache-dir -r requirements.txt

COPY app/ .

EXPOSE 8000

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]