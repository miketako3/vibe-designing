#!/bin/bash

# Arguments
# $1: The name of the TLA+ specification file (without .tla extension)
SPEC=$1

if [ -z "$SPEC" ]; then
  echo "Usage: $0 <spec-name>. example: $0 specs/SimpleSpec/spec.tla"
  exit 1
fi

# Check if the TLA+ specification file exists
if [ ! -f "$SPEC" ]; then
  echo "Error: TLA+ specification file '$SPEC' not found."
  exit 1
fi

PROP="$(dirname "$SPEC")/properties.tla"

# Translate the TLA+ specification to a TLA+ model
docker compose run --rm tlc pcal.trans "${SPEC}"
# insert properties.tla before END TRANSLATION.
{
  awk '/\* END TRANSLATION/ {print; exit} {print}' "${SPEC}"
  cat "${PROP}"
  echo "============================================================================="
} > "${SPEC}.tmp" && mv "${SPEC}.tmp" "$SPEC"
# Check if the translation was successful
docker compose run --rm tlc tlc2.TLC "${SPEC}"
