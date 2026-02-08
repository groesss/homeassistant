#!/bin/bash

# String, nach dem gesucht werden soll
SEARCH_STRING="$1"

# Verzeichnis, in dem gesucht wird (Home Assistant Config)
SEARCH_DIR=.

# Anzahl der Kontextzeilen
CONTEXT=2

if [ -z "$SEARCH_STRING" ]; then
    echo "Usage: $0 \"Suchbegriff\""
    exit 1
fi

echo "Suche nach '$SEARCH_STRING' in allen Dateien unter $SEARCH_DIR ..."

# Nur YAML-Dateien durchsuchen, rekursiv, mit Zeilennummer, Farbe, und Kontext
grep -Rin -C $CONTEXT --color=always "$SEARCH_STRING" "$SEARCH_DIR"

