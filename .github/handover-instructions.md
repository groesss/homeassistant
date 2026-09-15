# Handover Instructions

## Zielbild
- Aquarium-Steckdosen (Kueche + Wohnzimmer) schalten robuster trotz sporadischer Reaktionsprobleme.
- Waeschetrockner-Ansteuerung funktioniert trotz Bosch-ID-Wechsel wieder.
- Messages/Notifications bleiben funktional.
- Watchdog meldet fehlende Trockner-Powerstate-Entity.
- Zigbee Smart Plugs (Jinvoo SM-732-E) ersetzen Tuya WiFi-Steckdosen.

## Umgesetzte Aenderungen

### Zigbee: Jinvoo SM-732-E Smart Plugs gepairt
- 4x Zigbee Smart Plugs (Jinvoo SM-732-E, TS011F-kompatibel) erfolgreich mit Z2M gepairt.
- **Wichtig**: Pairing funktioniert nur mit geringem Abstand zum Sonoff Dongle (≤2m).
- **Reset-Sequenz**: 10-15s Halten (Factory Reset) → 5s Halten (Pairing Mode).
- **Z2M-Kanal**: 11. **Vorsicht WiFi-Interferenz** mit WiFi-Kanal 1.

### Zigbee: Automations umgezogen (WiFi → Zigbee)
- **Aquarium Küche**: `switch.kueche_smartplug_aquarium` → `switch.0xa4c13879004064c6`
- **Aquarium Wohnzimmer**: `switch.wohnzimmer_smartplug_aquarium` → `switch.0xa4c1385b6ff8c823`
- **Terrarium 1 (Bright Sun)**: `switch.wohnzimmer_smartplug_terrarium_1` → `switch.0xa4c138ad7386cc64`
- **Terrarium 2 (Halogenlampe)**: `switch.wohnzimmer_smartplug_terrarium_2` → `switch.wohnzimmer_terrarium_steckdose_2`

### Zigbee: Entity-ID-Zuordnung
| Gerät | Zigbee Entity ID | Z2M Friendly Name |
|---|---|---|
| Aquarium Küche | `switch.0xa4c13879004064c6` | kueche_aquarium_steckdose |
| Aquarium Wohnzimmer | `switch.0xa4c1385b6ff8c823` | wohnzimmer_aquarium_steckdose |
| Terrarium 1 | `switch.0xa4c138ad7386cc64` | wohnzimmer_terrarium_steckdose_1 |
| Terrarium 2 | `switch.wohnzimmer_terrarium_steckdose_2` | wohnzimmer_terrarium_steckdose_2 |

### Aquarium: Retry-Logik (3 Versuche + Warnlog bei Fehlschlag)
- automations/kueche_aquarium_licht_einschalten.yaml
- automations/kueche_aquarium_licht_ausschalten.yaml
- automations/wohnzimmer_aquarium_licht_einschalten.yaml
- automations/wohnzimmer_aquarium_licht_ausschalten.yaml

### Aquarium: Notfall-Skript
- scripts.yaml
- Script-Name: `aquarium_lighting_fallback`

### Trockner: Dynamische Bosch-ID-Aufloesung + Legacy-Fallbacks
- templates/trockner.yaml
- Powerstate wird aus vorhandenen Bosch-Dryer-Entities dynamisch abgeleitet.

### Trockner: Watchdog-Automation
- automations/waschkeller_trockner_entity_watchdog.yaml
- Prueft beim HA-Start und alle 30 Minuten, ob eine gueltige Powerstate-Entity vorhanden ist.
- Schreibt Warnung ins System-Log, falls keine passende Entity verfuegbar ist.

### Notifications: Refactor ohne Verhaltensaenderung
- automations/messages_notification.yaml
- Titel/Message in Variablen zentralisiert, Duplikate reduziert.

## Messages und Notifications
- Trockner-Meldung bleibt ueber templates/messages.yaml aktiv.
- Push-Weiterleitung bleibt ueber automations/messages_notification.yaml aktiv.
- Kein weiterer Umbau notwendig, da die Statusquelle im Trockner-Template stabilisiert wurde.

## Verifikation
- Editor-Pruefung ohne Fehler fuer:
  - Aquarium-Automationen (4 Dateien)
  - templates/trockner.yaml
  - automations/waschkeller_trockner_entity_watchdog.yaml
  - scripts.yaml
  - templates/messages.yaml
  - automations/messages_notification.yaml

## Operative Schritte in Home Assistant
1. Templates neu laden.
2. Automationen neu laden.
3. Funktionstest:
   - Aquarium an/aus je Raum pruefen.
   - Terrarium an/aus je Lampe pruefen.
   - Trockner Powerstate pruefen.
   - System-Log auf Watchdog-Warnungen pruefen.

## Hinweise fuer den naechsten Chat
- Fokus bei Folgearbeiten:
  - Optional zusaetzliche Healthchecks fuer Bosch-Entities
  - Optional sichtbare UI-Hinweise bei Watchdog-Warnungen

## Naechste Schritte: Zigbee-Migration
- **Abgeschlossen**: 4 von 6 Geräten zu Zigbee migriert (Aquarien + Terrarien)
- **Verbleibend**: Keller-Steckdose und TV bleiben auf WiFi
- **Z2M Friendly Names**: Hex-Adressen in Z2M Frontend zu freundlichen Namen geaendert
- **Alte WiFi-Entities**: Noch verfuegbar (z.B. `switch.kueche_smartplug_aquarium`), koennen physikalisch entfernt werden
- **Tuya WiFi-Integration**: Kann nach vollstaendiger Migration entfernt werden
