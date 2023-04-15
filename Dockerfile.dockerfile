# Pobierz oficjalny obraz Buildkit jako podstawę
FROM docker.io/moby/buildkit:v1.6.0 AS buildkit

# Skonfiguruj środowisko, aby można było korzystać z protokołu SSH
RUN apk add --no-cache openssh-client

# Sklonuj repozytorium za pomocą protokołu SSH
RUN --mount=type=ssh git clone git@example.com:user/repo.git /app

# Zbuduj obraz na podstawie pliku Dockerfile wewnątrz repozytorium
RUN --mount=type=cache,target=/app/.cache/docker-buildkit \
    --mount=type=bind,source=/var/run/docker.sock,target=/var/run/docker.sock \
    --progress=plain \
    buildctl build \
    --frontend dockerfile.v0 \
    --frontend-opt filename=/app/Dockerfile \
    --local context=/app \
    --local dockerfile=/app \
    --output type=image,name=docker.io/username/lab6:latest \
    --export-cache type=inline \
    --export-cache type=registry,ref=docker.io/username/lab6:cache

# Zbudowany obraz zostanie wyeksportowany do kolejnego etapu
FROM scratch AS export
COPY --from=buildkit /exporter/ /exporter/

# Przekaż utworzony obraz do Docker Huba
FROM docker.io/d1xer/lab6:latest
RUN docker push docker.io/d1xer/lab6:latest
