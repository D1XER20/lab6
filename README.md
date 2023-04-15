# lab6
Lab6 Docker

ssh-keygen
Stworzenie plików id_rsa i id_rsa.pub z kluczami

docker run --rm --privileged docker.io/moby/buildkit
Uruchomienie Buildkit w kontenerze

docker run --rm --mount=type=ssh -w /app <ssh-key> git clone <git-repo-url>
Klonowanie repo z Dockerfile

DOCKER_BUILDKIT=1 docker build -t d1xer/lab6 .
Budowanie obrazu

docker push d1xer/lab6
Przesylanie do DockerHub
