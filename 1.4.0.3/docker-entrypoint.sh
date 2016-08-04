#!/bin/sh
set -e

# copy latest blockchain
cd $SHADOWCASH_DATA
FILE="blockchain.zip"

if [ ! -f $FILE ]
then
    echo "$FILE does not exists, downloading..."
    curl -SLO https://github.com/shadowproject/blockchain/releases/download/latest/blockchain.zip
    echo "$FILE downloaded, extracting..."
    unzip blockchain.zip
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
