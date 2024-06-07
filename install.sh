#!/bin/sh

if ! [[ -x "$(command -v jq)" ]]; then
  echo "jq is required."
  exit 1
fi

if ! [[ -x "$(command -v wget)" ]]; then
  echo "wget is required."
  exit 1
fi

BIN_PATH=/usr/bin

wget https://raw.githubusercontent.com/rangoo94/testkube-context/main/testkube-context.sh > $BIN_PATH/tkc
chmod +x $BIN_PATH/tkc

echo "$ tkc"
tkc
