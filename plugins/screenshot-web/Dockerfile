FROM python:3.12-slim

RUN pip install --no-cache-dir shot-scraper \
    && shot-scraper install \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        libnss3 libatk-bridge2.0-0 libdrm2 libxcomposite1 \
        libxdamage1 libxrandr2 libgbm1 libasound2 libpango-1.0-0 \
        libcairo2 libatspi2.0-0 libxshmfence1 \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /work
ENTRYPOINT ["shot-scraper"]
