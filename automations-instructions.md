# Automatisierungs-Regeln und Struktur

## Grundprinzip
- Jede Automatisierung wird als **eigene YAML-Datei** im Ordner `/automations/` abgelegt
- Dateiname folgt der Namenskonvention: `<raum>_<funktion>_<attribute>.yaml`
- Alias und Description in der Automatisierung sollen den Zweck klar und knapp beschreiben
- Am Anfang jeder Datei steht ein ausführlicher Kommentar zur Funktion und Logik

## Vorteile
- Übersichtlichkeit: Jede Automatisierung ist einzeln auffindbar und editierbar
- Fehlerquellen werden minimiert (keine Vermischung von Logik)
- Reload und Debugging sind einfacher

## Beispiele
- `wohnzimmer_tv_steckdose_aus_nach_zeitlimit.yaml` (TV-Kindersicherung)
- `wohnzimmer_terrarium_warmup.yaml` (Terrarium Frühjahrs-Zyklus)
- `garten_gardena_zeitplan_bewaesserung.yaml` (Garten-Bewässerung)
- `arbeitszimmer_thermostat_zeitplan_sync.yaml` (Thermostat-Zeitplan)

## Sonderfälle
- Generische Automatisierungen (z.B. messages_notification) bleiben ohne Raum-Präfix
- Automatisierungen, die mehrere Räume betreffen, können mit mehreren Raum-Präfixen arbeiten (z.B. `wohnzimmer_garten_...`)

## Automatisierungs-Integration
- In der `configuration.yaml` wird der Automatisierungs-Ordner eingebunden:
  ```yaml
  automation: !include_dir_merge_list automations/
  ```
- Automatisierungen werden automatisch geladen und können im UI bearbeitet werden

---

**Siehe auch:**
- [instructions.md](instructions.md)
- [README.md](README.md)
