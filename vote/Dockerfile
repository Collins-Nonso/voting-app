
FROM python:3.11-slim AS base

RUN apt-get update && \
    apt-get install -y --no-install-recommends curl && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /usr/local/app

COPY requirements.txt ./requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Create a dedicated, unprivileged application user
RUN useradd --create-home --uid 10001 appuser && \
    chown -R appuser:appuser /usr/local/app

# Development stage
FROM base AS dev

RUN pip install --no-cache-dir watchdog

ENV FLASK_ENV=development
ENV PORT=8080

USER 10001:10001

CMD ["python", "app.py"]

# Production stage
FROM base AS final

COPY --chown=10001:10001 . .

ENV PORT=8080

EXPOSE 8080

USER 10001:10001

CMD ["gunicorn", "app:app", "-b", "0.0.0.0:8080", "--log-file", "-", "--access-logfile", "-", "--workers", "4", "--keep-alive", "0"]
