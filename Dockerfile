# Lightweight alpine OS, weight only 5mb, everything else is Go environment
FROM golang:1.16.2-alpine3.13 as builder

# Workdir is path in your docker image from where all your commands will be executed
WORKDIR /go

# Install transocks
RUN go get -u github.com/cybozu-go/transocks/...

FROM alpine:3.12

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
CMD [ "sh", "/app/entrypoint.sh" ]
