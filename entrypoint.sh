#!/bin/sh

if [ -e $PROXY_PORT ]; then
    export PROXY_PORT=3128;
fi

if [ -e $PROXY_IP ]; then
    export PROXY_IP=127.0.0.1;
fi

# Generate toml
TRANSOCKS_TOML=/etc/transocks.toml
sed -i "s/PROXY_IP/$PROXY_IP/g" /app/transocks.toml
sed -i "s/PROXY_PORT/$PROXY_PORT/g" /app/transocks.toml

/go/bin/transocks -f /app/transocks.toml
