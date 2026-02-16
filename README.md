# Home Assistant Konfiguration

Diese Konfiguration folgt klaren Namens- und Strukturregeln für Entities, Helper, Automatisierungen und UI.


## Dokumentation

- [.github/instructions.md](.github/instructions.md): Allgemeine übergreifende Instructions (z.B. Namenskonventionen, Speicherorte, ...)
- [.github/automations-instructions.md](.github/automations-instructions.md): Spezielle Regeln und Struktur für Automatisierungen

## Automatisierungen
- Jede Automatisierung ist als eigene Datei im Ordner `/automations/` abgelegt
- Automatisierungen werden über `!include_dir_merge_list automations/` eingebunden

## Helper
- Helper sind unter `/helpers/<type>/<raum>.yaml` definiert

## UI
- UI-Referenzen und Automatisierungen verwenden exakt die Entity-Namen

## Vorteile
- Klare Zuordnung, einfache Wartung, keine Namenskonflikte
- Automatisierungen und UI sind sofort verständlich

---

Weitere Details und Beispiele siehe [instructions.md](instructions.md) und [automations-instructions.md](automations-instructions.md).
