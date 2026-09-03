FROM python:3.12-slim-bookworm

RUN groupadd -g 1000 appadmin && \
    useradd -u 1000 -g appadmingrp -m -s /bin/bash appadmin

USER appadmin

WORKDIR /app

COPY --chown=appadmin:appadmingrp app/requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY app/ .

EXPOSE 8000

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]