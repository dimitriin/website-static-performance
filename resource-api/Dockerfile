FROM golang:1.15 AS build

WORKDIR /src/
COPY main.go go.* /src/
RUN go build -o /bin/resource-api

FROM debian:buster-slim

RUN set -exu ;\
    export DEBIAN_FRONTEND=noninteractive ;\
    apt-get update ;\
    apt-get install --no-install-recommends --no-install-suggests -y \
        ca-certificates \
        mime-support;\
    rm -rf /var/lib/apt/lists/*

COPY --from=build /bin/resource-api /bin/resource-api
ENTRYPOINT ["/bin/resource-api"]