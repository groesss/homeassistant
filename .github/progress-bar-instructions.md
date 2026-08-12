# 📊 Home Assistant Progress Bar (Decluttering Template)

Ein wiederverwendbares Progress-Bar-Template für Home Assistant auf Basis von:

- `custom:mushroom-template-card`
- `custom:decluttering-card`
- `card-mod`

Unterstützt mehrere Anzeigemodi, automatische Farben, Batterie-Invertierung
und Alarmanzeige für kritische Sensorwerte.

---

## ✨ Features

✅ Wiederverwendbares Decluttering-Template  
✅ Drei Anzeigemodi: `normal`, `battery`, `critical`  
✅ Automatische Farblogik  
✅ Optional feste Farbe (`color`)  
✅ Invertierte Batterieanzeige  
✅ Blinkeffekt bei kritischen Werten  
✅ Animation bei Wertänderung  
✅ Vollständig konfigurierbar  

---

## 📦 Voraussetzungen

Installierte Custom Cards:

- [Mushroom Cards](https://github.com/piitaya/lovelace-mushroom)
- [Decluttering Card](https://github.com/custom-cards/decluttering-card)
- [Card Mod](https://github.com/thomasloven/lovelace-card-mod)

---

## 🚀 Installation

1. Stelle sicher, dass alle Abhängigkeiten installiert sind.
2. Öffne deine `ui-lovelace.yaml` oder dein Dashboard.
3. Füge das Template unter `decluttering_templates:` ein.
4. Verwende das Template in deinen Karten.

---

## 🧩 Template einfügen

Beispiel:

```yaml
decluttering_templates:
  progress_bar:
    # → Hier dein komplettes Template einfügen

Konfiguration
Pflicht-Variablen
Name	Typ	Beschreibung
title	String	Titel der Karte
entity	Entity	Sensor mit numerischem Wert
max	Number	Maximalwert (meist 100)
icon	String	MDI-Icon
Optionale Variablen
Name	Typ	Beschreibung
mode	String	normal, battery, critical
color	String	Erzwingt feste Farbe (z. B. red, #2196f3)

Wenn mode nicht gesetzt ist, wird automatisch normal verwendet.
Wenn color gesetzt ist, überschreibt es alle Farbregeln.

🎛️ Anzeigemodi
▶️ Normal (Standard)


Für klassische Fortschritte:
- Programme
- Ladezustände
- Füllstände

Verhalten:
Balken wächst mit Wert
Farbe: grau → rot → orange → grün
mode: normal   # optional

🔋 Battery

Für Akkus und Batterien.

Verhalten:
Balken ist invertiert (leer = voll)
Farbe zeigt Dringlichkeit
Akku	Farbe
≥ 70 %	Grün
≥ 40 %	Gelb
≥ 20 %	Orange
< 20 %	Rot
mode: battery

🚨 Critical

Für kritische Sensoren:

- CPU
- Temperatur
- CO₂
- Systemlast

Verhalten:

Balken wächst normal
Aggressive Farblogik
Blinkeffekt bei > 90 %

mode: critical

📐 Berechnung
Fortschrittsbreite
normal / critical:
  percent = (value / max) * 100

battery:
  percent = 100 - (value / max) * 100

🎨 Farbregeln
Normal
Wert	Farbe
< 1 %	Grau
< 25 %	Rot
< 75 %	Orange
≥ 75 %	Grün
Battery
Wert	Farbe
< 20 %	Rot
< 40 %	Orange
< 70 %	Gelb
≥ 70 %	Grün
Critical
Wert	Farbe
< 60 %	Grün
< 80 %	Orange
≥ 80 %	Rot



🧪 Beispiele
▶️ Fortschritt (Normal)
- type: custom:decluttering-card
  template: progress_bar
  variables:
    - title: "Geschirrspüler"
    - entity: sensor.dishwasher_progress
    - max: 100
    - icon: mdi:dishwasher

🔋 Batterie
- type: custom:decluttering-card
  template: progress_bar
  variables:
    - title: "Tablet"
    - entity: sensor.tablet_battery
    - max: 100
    - icon: mdi:tablet
    - mode: battery

🚨 Kritisch
- type: custom:decluttering-card
  template: progress_bar
  variables:
    - title: "CPU Load"
    - entity: sensor.server_cpu
    - max: 100
    - icon: mdi:cpu-64-bit
    - mode: critical

🎨 Feste Farbe
- type: custom:decluttering-card
  template: progress_bar
  variables:
    - title: "Download"
    - entity: sensor.download_progress
    - max: 100
    - icon: mdi:download
    - color: "#2196f3"

⚠️ Hinweise

Sensoren müssen numerische Werte liefern.

Ungültige oder leere Werte werden automatisch abgefangen.

Das Template ist vollständig modular aufgebaut.

Erweiterungen (weitere Modes, Animationen) sind einfach möglich.

🛠️ Erweiterungen (Ideen)

Geplante / mögliche Erweiterungen:

Auto-Mode-Erkennung

Tooltip mit Verlauf

Mini-Graph

Status-Text

Fehlerzustand