#!/bin/bash

# Startzeit merken (Epoch-Sekunden)
start_time=$(date +%s)

# Zielverzeichnis
ziel="/volume1/Daten/@ safe/_homeassistant"

# Logdatei im Zielverzeichnis
logfile="$ziel/ha_backup.log"

# Hier deine Backup-Befehle
stats=$(rsync -a --delete --stats --itemize-changes /var/packages/homeassistant/var/config/ "$ziel/config/" 2>&1)

# Endzeit messen
end_time=$(date +%s)

# Laufzeit berechnen
runtime=$(( end_time - start_time ))

# Laufzeit schön formatieren (min:sek)
mins=$(( runtime / 60 ))
secs=$(( runtime % 60 ))

# Geänderte Dateien zählen (jede nicht-Verzeichnis-Zeile außer "sending"/"sent"/Statistik)
changed_files=$(echo "$stats" | grep -v '/$' | grep -v '^sending' | grep -v '^sent ' | grep -v '^total ' | grep -v '^bytes ' | grep -v '^$' | wc -l)

transferred_bytes=$(echo "$stats" | grep "Total transferred file size" | awk '{$1=$2=$3=$4=""; print $0}' | sed 's/bytes//; s/,//g; s/^ *//; s/ *$//')

# Falls kein Wert ermittelt wurde, auf 0 setzen
changed_files=${changed_files:-0}
transferred_bytes=${transferred_bytes:-0}

human_readable_size() {
  size=$1
  if [ "$size" -lt 1024 ]; then
    echo "${size} B"
  elif [ "$size" -lt $((1024**2)) ]; then
    # KB mit 1 Nachkommastelle
    awk -v s="$size" 'BEGIN {printf "%.1f KB\n", s/1024}'
  elif [ "$size" -lt $((1024**3)) ]; then
    # MB mit 3 Nachkommastellen
    awk -v s="$size" 'BEGIN {printf "%.3f MB\n", s/(1024*1024)}'
  else
    # GB mit 3 Nachkommastellen
    awk -v s="$size" 'BEGIN {printf "%.3f GB\n", s/(1024*1024*1024)}'
  fi
}
transferred_size=$(human_readable_size "$transferred_bytes")

# Alles in einer Zeile ins Log schreiben
echo "$(date '+%Y-%m-%d %H:%M:%S') – Backup durchgeführt. Geänderte Dateien: $changed_files | Übertragene Größe: $transferred_size | Dauer: ${mins}m ${secs}s" >> "$logfile"
