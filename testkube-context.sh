#!/bin/sh

set -e

TK_DIR="$HOME/.testkube"

CFG_PATH="$TK_DIR/config.json"
CURRENT_PATH="$TK_DIR/current"
CTX_DIR="$TK_DIR/contexts"

mkdir -p "$CTX_DIR"
CONTEXTS="$(ls -A1 "$CTX_DIR")"
touch "$CURRENT_PATH"
CURRENT="$(cat $CURRENT_PATH || echo "")"
if [ "$CONTEXTS" == "" ] && [ -f "$CFG_PATH" ]; then
  cp "$CFG_PATH" "$CTX_DIR/default"
  echo "default" > "$CURRENT_PATH"
  CONTEXTS="default"
  CURRENT="default"
fi

if [ "$CURRENT" != "" ]; then
  cp $CFG_PATH $CTX_DIR/$CURRENT
fi

require_name() {
  if [ -z $1 ]; then
    echo "You need to provide context name"
    exit 1
  fi
}

require_exists() {
  if ! [ -f "$CTX_DIR/$1" ]; then
    echo "Context $1 does not exist. Existing contexts:"
    list
    exit 1
  fi
}

delete() {
  echo "Deleting $1"
}

use() {
  cp "$CTX_DIR/$1" "$CFG_PATH"
  echo "$1" > "$CURRENT_PATH"
  CURRENT="$1"
  list
}

new() {
  if [ -f "$CTX_DIR" ]; then
    echo "Context $1 already exists."
    exit 1
  fi
  echo "{}" > "$CTX_DIR/$1"
  echo "Created context: $1"
  use $1
}

list() {
  if [ "$CONTEXTS" == "" ]; then
    echo "No contexts found"
  else
    for c in $CONTEXTS
    do
      CONTEXT_TYPE=$(jq -r '.contextType' "$CTX_DIR/$c")
      API_URI=$(jq -r '.cloudContext.apiUri' "$CTX_DIR/$c" | sed "s|.*://||")
      ORG_NAME=$(jq -r '.cloudContext.organizationName' "$CTX_DIR/$c")
      ENV_NAME=$(jq -r '.cloudContext.environmentName' "$CTX_DIR/$c")
      LABEL="$c"
      if [ "$CONTEXT_TYPE" == "cloud" ]; then
        LABEL="$LABEL ($API_URI / $ORG_NAME / $ENV_NAME)"
      elif [ -z "$CONTEXT_TYPE" ]; then
        LABEL="$LABEL (empty)"
      else
        LABEL="$LABEL ($CONTEXT_TYPE)"
      fi
      if [ "$c" == "$CURRENT" ]; then
        echo "[*] $LABEL"
      else
        echo "[ ] $LABEL"
      fi
    done
  fi
}

case "$1" in
  d | del | delete | remove) require_name $2 ; require_exists $2; delete $2 ;;
  u | use) require_name $2 ; require_exists $2; use $2 ;;
  c | create | new | add) require_name $2 ; new $2 ;;
  "" | l | list) list ;;
  *) echo "Unknown command: $1. Allowed commands: d|del|delete|remove <name>, u|use <name>, c|add|new|create <name>, l|list" ;;
esac
