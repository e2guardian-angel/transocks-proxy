# Lightweight alpine OS, weight only 5mb, everything else is Go environment
FROM golang:alpine as builder

# Workdir is path in your docker image from where all your commands will be executed
WORKDIR /go

ENV GO111MODULE=on

# Install transocks
RUN CGO_ENABLED=0 GOOS=linux go install github.com/cybozu-go/transocks@latest

FROM alpine:latest
MAINTAINER Justin Schwartzbeck <justinmschw@gmail.com>

COPY --from=builder /go /go

WORKDIR /app

COPY entrypoint.sh /app/entrypoint.sh
COPY transocks.toml /app/transocks.toml
RUN chmod +x /app/entrypoint.sh
RUN adduser -u 32 -D -H transocks
RUN chown -R transocks:transocks /app

# Expose port for access to your app outside of container
EXPOSE 12345

USER transocks
# Starting bundled binary file
CMD [ "/app/entrypoint.sh" ]
