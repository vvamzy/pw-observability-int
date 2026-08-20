FROM python:3.10

WORKDIR /app

COPY app/requirements.txt .

RUN python -m pip install --no-cache-dir --upgrade \
    pip \
    setuptools>=78.1.1 \
    wheel>=0.46.2 \
    && python -m pip install --no-cache-dir -r requirements.txt

COPY app/ .

EXPOSE 8000

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]