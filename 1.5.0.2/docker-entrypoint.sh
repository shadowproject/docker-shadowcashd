#!/bin/sh
set -e

# copy latest blockchain
cd $SHADOWCASH_DATA

if [ ! -f "blockchain.zip" ]
then
    echo "blockchain.zip does not exists, downloading..."
    curl -SLO https://github.com/shadowproject/blockchain/releases/download/latest/blockchain.zip
    echo "blockchain.zip downloaded, extracting..."
    unzip blockchain.zip
fi

if [ ! -f "shadowcoin.conf" ]
then
    echo "shadowcoin.conf does not exists, creating..."
    touch shadowcoin.conf
    RPCUSERNAME=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
    RPCPASSWORD=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
    echo "rpcallowip=127.0.0.1" >> shadowcoin.conf
    echo "rpcuser=$RPCUSERNAME" >> shadowcoin.conf
    echo "rpcpassword=$RPCPASSWORD" >> shadowcoin.conf
fi

if [ $(echo "$1" | cut -c1) = "-" ]; then
    echo "$0: assuming arguments for shadowcoind"

    set -- shadowcoind "$@"
fi

if [ $(echo "$1" | cut -c1) = "-" ] || [ "$1" = "shadowcoind" ]; then
    mkdir -p "$SHADOWCASH_DATA"
    chmod 700 "$SHADOWCASH_DATA"
    chown -R shadowcash "$SHADOWCASH_DATA"

    echo "$0: setting data directory to $SHADOWCASH_DATA"

    set -- "$@" -datadir="$SHADOWCASH_DATA"
fi

if [ "$1" = "shadowcoind" ]; then
    echo
    exec gosu shadowcash "$@"
fi

echo
exec "$@"
