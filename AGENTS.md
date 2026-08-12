# Home Assistant Konfiguration (T:\ / \\homeassistant.local\config)

Home Assistant Konfiguration auf einem Raspberry Pi. YAML-basierte Steuerung für
Terrarium, TV, Aquarium, Wäschetrockner (Bosch), Bewässerung (Gardena), PV
(RCT-Power), Küchengeräte und Nachrichtensystem.

## Wichtig: Instructions lesen

Die verbindlichen Konventionen und Bereichsregeln liegen unter `.github/` und
**haben Vorrang**. Vor jeder Änderung die passende Datei lesen:

- `.github/instructions.md` – globale Regeln (Namenskonventionen `<raum>_<name>_<attribut>`,
  Speicherorte, Template-System, Testinfrastruktur)
- `.github/automations-instructions.md` – Regeln für Automatisierungen
- `.github/ui-instructions.md` + `.github/ui-cheatsheet.md` – Lovelace/UI-Konventionen
- `.github/terrarium-instructions.md` – Terrarium-Logik
- `.github/messages-instructions.md` – Nachrichtensystem
- `.github/progress-bar-instructions.md` – Progress Bar Templates
- `.github/handover-instructions.md` – Stand der letzten Session und offene Punkte

## Struktur im Überblick

- `configuration.yaml` – Hauptkonfiguration, bindet alle Bereiche per `!include`
- `automations/<raum>_<funktion>.yaml` – eine Automatisierung pro Datei
- `templates/*.yaml` – Template-Sensoren/-Schalter (Statuslogik je Gerät)
- `helpers/<type>/<raum>.yaml` – Helper (input_boolean, input_number, …)
- `ui/` + `ui-solar.yaml` – Lovelace-YAML-Dashboards; wiederverwendbare Karten
  unter `ui/shared/templates/`
- `custom_components/` – hacs, spook, pyscript, localtuya, home_connect_alt,
  gardena_smart_system, rct_power, watchman

## Arbeitsregeln

- **Niemals** Secrets/API-Keys/Tokens einfügen oder committen.
- Helper, Automations und UI-Entities exakt mit den eingeführten Entity-Namen referenzieren.
- Bei Statuslogik-Änderungen (z.B. Trockner/Backofen/Geschirrspüler) alle
  Geräte-Templates synchron halten (siehe `templates/trockner.yaml`).
- YAML-Syntax ist strikt; geänderte Dateien nach Einbindung in HA verifizieren
  (Templates/Automations neu laden, System-Log prüfen).
- Dieses Repo ist Git-versioniert: Änderungen nachvollziehbar halten, nur auf
  ausdrücklichen Wunsch committen.
