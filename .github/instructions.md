
# Übergreifende Instructions & Prinzipien

Dieses Dokument enthält die allgemeinen, globalen Regeln und Konventionen für die gesamte Home Assistant Konfiguration. Es bildet die Grundlage für alle spezifischen Anweisungen und verweist auf die jeweiligen Detail-Instructions.

## Wie funktionieren die Instructions?

- **Allgemeine Regeln** gelten immer, außer es gibt eine spezifischere Anweisung in einer der unten genannten Spezial-Instructions.
- **Spezielle Instructions** (z.B. für Automatisierungen, UI, Terrarium, Messages) haben Vorrang, wenn sie für einen Bereich existieren.
- **Erweiterbarkeit:** Für neue Themenbereiche können jederzeit weitere `<bereich>-instructions.md`-Dateien im `.github/`-Ordner ergänzt werden.

## Struktur der Instructions

- `.github/instructions.md`: Diese Datei – allgemeine, übergreifende Regeln und Prinzipien (z.B. Namenskonventionen, Speicherorte, allgemeine YAML-Struktur, Einbindung von Automatisierungen und UI, etc.)
- `.github/<bereich>-instructions.md`: Spezielle Anweisungen für einzelne Bereiche (z.B. Automatisierung, UI, Terrarium, Messages, ...)

### Übersicht der aktuellen Instructions

- [automations-instructions.md](automations-instructions.md): Regeln und Struktur für Automatisierungen
- [ui-instructions.md](ui-instructions.md): Lovelace/UI-Konventionen
- [terrarium-instructions.md](terrarium-instructions.md): Terrarium-Logik und Steuerung
- [messages-instructions.md](messages-instructions.md): Nachrichtensystem und Benachrichtigungen
- [progress-bar-instructions.md](progress-bar-instructions.md): Progress Bar Templates und Modi

## Namenskonventionen

Für alle Home Assistant Entities, Helper, Sensoren, Automatisierungen, Skripte, etc. gilt:

**Format:**
```
<raum>_<sprechender EntityName>_<attribute>
```

- **<raum>**: Eindeutiger Raumname (z.B. wohnzimmer, garten, arbeitszimmer)
- **<sprechender EntityName>**: Klarer, beschreibender Name (z.B. tv, terrarium, schranklicht)
- **<attribute>**: Funktion, Zähler, Status, etc. (z.B. minute_count_netflix, timer_active)

**Beispiele:**
- `wohnzimmer_tv_minute_count_netflix`
- `garten_gardena_ventil_1`
- `arbeitszimmer_thermostat_schedule_common_1_time`
- `wohnzimmer_terrarium_timer_active`
- `wohnzimmer_group_schrank` (Light Group)

## Entity-Definition & Speicherorte
- Helper werden unter `/helpers/<type>/<raum>.yaml` definiert
- Automatisierungen unter `/automations/<raum>_<funktion>_<attribute>.yaml`
- Sensoren, Skripte, etc. folgen ebenfalls der Konvention

## UI und Automatisierungen
- UI-Referenzen und Automatisierungen müssen exakt die Entity-Namen verwenden
- Light Groups und andere Gruppen sollten ebenfalls den Raum im Namen enthalten

## Generische Entities
- Generische Automatisierungen (z.B. messages_notification) dürfen keinen Raum-Präfix haben, wenn sie für das ganze Haus gelten

## Vorteile
- Klare Zuordnung, einfache Wartung, keine Namenskonflikte
- Automatisierungen und UI sind sofort verständlich

---

**Siehe auch:**
- [automations-instructions.md](automations-instructions.md)
- [ui-instructions.md](ui-instructions.md)
- [terrarium-instructions.md](terrarium-instructions.md)
- [messages-instructions.md](messages-instructions.md)
- [progress-bar-instructions.md](progress-bar-instructions.md)

## Template-System & Wiederverwendbarkeit

### Prinzipien für Decluttering Templates

Für wiederverwendbare UI-Komponenten gilt:

**Template-Speicherort:**
```
ui/shared/templates/<template_name>.yaml
```

**Parameter-Konventionen:**
- Required Parameter mit aussagekräftigen Namen
- Optionale Parameter mit sinnvollen Defaults  
- Documentation Header mit Verwendungsbeispielen
- Parameter-Validierung über Template-Logik

**Template-Kategorien:**
- **UI-Components**: progress_bar, thermostat_card, message_alert
- **Layout-Wrapper**: stack_wrapper, entities_flat, flat_compact
- **Domain-spezifisch**: timer_row, schedule_slot, button_card_templates

### Template-Entwicklung

**Struktur einer Template:**
```yaml
# =============================================================================
# TEMPLATE NAME
# =============================================================================
# Beschreibung und Zweck
#
# Parameter:
#   - entity: domain.name (Required) - Beschreibung
#   - title: Text (Required) - Anzeigename
#   - mode: Modus (Optional) - normal/inverse/battery
#
# Features:
# - Feature 1: Beschreibung
# - Feature 2: Beschreibung
# =============================================================================

template_name:
  card:
    # Template-Implementierung
```

**Template-Qualitätskriterien:**
- UI-Instructions konform (entities_flat.yaml, card_header.yaml, flat_compact.yaml)
- Responsive und zugänglich
- Konsistente Farblogik und Icons
- Deutsche Lokalisierung wo angebracht
- Umfassende Fehlerbehandlung

## Test-Infrastruktur & Entwicklung

### Test-Dashboard-Organisation

**Hierarchische Test-Struktur:**
- **Haupt-Test-Dashboard**: Übersicht aller Test-Bereiche (`/lovelace/0/tests`)
- **Bereichs-Tests**: Separate Views pro Komponente (`/lovelace/0/progress-tests`)
- **Navigation**: Zurück-Navigation zwischen Test-Bereichen

**Test-Dashboard-Implementierung:**
```yaml
# Test-Übersichtsseite
- type: custom:mushroom-template-card
  primary: Progress Bar Tests
  secondary: Alle Modi, Farben, Edge-Cases
  icon: mdi:chart-line-variant
  tap_action:
    action: navigate
    navigation_path: /lovelace/0/progress-tests
```

**Test-Kategorien:**
- **Feature-Tests**: Alle Modi und Parameter
- **Edge-Cases**: Grenzwerte und Fehlerfälle  
- **Visual-Tests**: Farbkonsistenz und Layout
- **Integration-Tests**: Zusammenspiel verschiedener Komponenten

### Test-Best-Practices

- **Separate Navigation**: Tests nicht in produktiver UI
- **Umfassende Abdeckung**: Alle Parameter-Kombinationen testen
- **Fake-Entities**: input_number für kontrollierte Testwerte
- **Dokumentierte Test-Cases**: Klare Beschreibung erwarteter Resultate
- **Test-Maintenance**: Tests bei Template-Änderungen aktualisieren

## Erweiterte UI-Patterns

### Thermostat-Integration

**Vollständige Thermostat-Karte:**
```yaml
- type: custom:decluttering-card
  template: thermostat_card
  variables:
    - entity: climate.raum_thermostat
    - title: Raum Heizung
    - battery: sensor.raum_thermostat_battery
    - frost_temp: number.raum_thermostat_frost_protection_temperature
    - open_window: switch.raum_thermostat_open_window
    - child_lock: switch.raum_thermostat_child_lock
```

**Features:**
- Deutsche HVAC-Modi ('Heizen', 'Aus')
- Smart Status-Line (Solltemperatur, Batterie, Kindersicherung)
- Fold-entity-row mit vollständiger Funktionalität
- UI-Instructions konform

### Progress Bar System

**Modi-basierte Progress Bars:**
- **Normal**: Grün=gut (>75%), Orange=mittel (25-75%), Rot=kritisch (<25%)
- **Inverse**: Rot=hoch (>75%), Orange=mittel (25-75%), Grün=niedrig (<25%) - für TV-Zeit
- **Battery**: Spezielle Batterie-Farblogik mit Auto-Icon

**Parameter:**
```yaml
- type: custom:decluttering-card
  template: progress_bar
  variables:
    - entity: sensor.example
    - max: 100                    # oder sensor.max_value
    - title: Anzeigename
    - mode: normal               # normal/inverse/battery
    - color: red                 # Override für feste Farbe
    - icon: mdi:battery          # Custom Icon
    - secondary_sensor: sensor.detail # Zusatzinfo
```

## Style-System Integration

### Konsistente Style-Verwendung

**Alle Templates müssen UI-Instructions befolgen:**
- `entities_flat.yaml`: Für fold-entity-row Container
- `card_header.yaml`: Für Kopfzeilen mit Rahmen  
- `flat_compact.yaml`: Für Content-Cards ohne Rahmen
- `stack_wrapper.yaml`: Für transparente Layout-Wrapper

**Style-Hierarchie:** 
```
Header (card_header.yaml) → sichtbarer Rahmen
└── Content (flat_compact.yaml) → rahmenlos, kompakt
```

Diese Konventionen gewährleisten:**
- Konsistente Optik über alle Bereiche
- Wartbare und erweiterbare Templates
- Umfassende Test-Abdeckung
- Deutsche Lokalisierung
- Performance-optimierte Implementierung
