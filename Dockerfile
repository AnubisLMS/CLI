ARG PYTHON_VERSION=3.7
FROM python:${PYTHON_VERSION}-slim-bullseye AS build
WORKDIR /build

COPY freeze.txt /build/
RUN set -eux; \
    apt update; \
    apt install -y make; \
    pip install --no-cache-dir -r freeze.txt; \
    rm -rf /usr/share/doc; \
    rm -rf /var/cache/apt/*; \
    rm -rf /var/lib/apt/lists/*
COPY . .
RUN make docs

FROM nginxinc/nginx-unprivileged:1.23-alpine
COPY --from=build /build/docs/html/ /usr/share/nginx/html/
