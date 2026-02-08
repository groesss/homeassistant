#!/bin/bash

# === Prüfen, ob Script mit sudo ausgeführt wird ===
#if [ "$(id -u)" -ne 0 ]; then
#    echo "❌ Dieses Script muss mit sudo ausgeführt werden."
#    echo "👉 Beispiel: sudo $0 input_boolean.alt input_boolean.neu"
#    exit 1
#fi

# === Parameter prüfen ===
if [ "$#" -ne 2 ]; then
    echo "❌ Fehler: Bitte gib ALT-ID und NEU-ID an."
    echo "👉 Beispiel: sudo $0 input_boolean.wohnzimmer_tv_kindersicherung input_boolean.wohnzimmer_tv_kindersicherung"
    exit 1
fi

OLD_ID="$1"
NEW_ID="$2"

# === Konfigurationsverzeichnis ===
CONFIG_DIR="."
BACKUP_DIR="/config_backup_$(date +%Y%m%d_%H%M%S)"

# === Besitzer und Gruppe des Originals ermitteln ===
OWNER=$(stat -c '%U' "$CONFIG_DIR")
GROUP=$(stat -c '%G' "$CONFIG_DIR")

#echo "📦 Erstelle Backup von $CONFIG_DIR nach $BACKUP_DIR..."
#cp -a "$CONFIG_DIR" "$BACKUP_DIR"
#chown -R "$OWNER:$GROUP" "$BACKUP_DIR"
#echo "✅ Backup abgeschlossen."

# === ALT zählen ===
echo "🔍 Zähle Vorkommen vor der Ersetzung in $CONFIG_DIR..."
OLD_COUNT=$(sudo grep -r "$OLD_ID" $CONFIG_DIR | wc -l)
echo "→ $OLD_COUNT Vorkommen gefunden für '$OLD_ID'" 
echo "→ $(sudo grep -r "$NEW_ID" $CONFIG_DIR | wc -l) Vorkommen gefunden für '$NEW_ID'."
echo ""

if [ $OLD_COUNT -ne 0 ]; then
	# === Ersetzen in allen Dateien ===
	echo "♻️  Ersetze '$OLD_ID' → '$NEW_ID' ..."
	ESCAPED_OLD=$(echo "$OLD_ID" | sudo sed 's/\./\\./g')
	sudo find "$CONFIG_DIR" -type f -exec sed -i "s/${ESCAPED_OLD}/${NEW_ID}/g" {} +
	echo "✅ Ersetzung abgeschlossen."
	echo ""

	# === NEU zählen ===
	echo "🔍 Zähle Vorkommen nach der Ersetzunh in $CONFIG_DIR..."
	echo "→ $(sudo grep -r "$OLD_ID" $CONFIG_DIR | wc -l) Vorkommen gefunden für '$OLD_ID'"
    echo "→ $(sudo grep -r "$NEW_ID" $CONFIG_DIR | wc -l) Vorkommen gefunden für '$NEW_ID'."
    echo ""
fi

echo "🎉 Refactoring abgeschlossen."

