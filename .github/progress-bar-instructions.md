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
