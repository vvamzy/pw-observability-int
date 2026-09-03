FROM python:3.12-slim-bookworm

ENV PATH="/usr/local/bin:$PATH"

RUN groupadd -g 1000 appadmingrp && \
    useradd -u 1000 -g appadmingrp -m -s /bin/bash appadmin

WORKDIR /app

COPY app/requirements.txt .

RUN python -m pip install --no-cache-dir \
    --upgrade pip setuptools wheel && \
    python -m pip install --no-cache-dir -r requirements.txt

COPY --chown=appadmin:appadmingrp app/ .

USER appadmin

EXPOSE 8000

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]