#!/usr/bin/env bash
set -e

SOURCE_DB="origin_inventory_development"
DEST_DIR="/mnt/c/Users/jmedina/OneDrive - ORIGIN EXPERT/Bureau/DBTEMP"
DEST_DB="$DEST_DIR/origin_inventory_development.dump"

if ! pg_isready -q; then
  echo "Error: PostgreSQL is not running."
  exit 1
fi

mkdir -p "$DEST_DIR"

# Custom format (-Fc), restore with:
#   pg_restore -d origin_inventory_development --clean --if-exists "$DEST_DB"
pg_dump -Fc "$SOURCE_DB" > "$DEST_DB"
echo "DB Copied"
