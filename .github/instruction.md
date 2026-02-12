# UI Blueprint Instructions

This document defines the shared structure, conventions, and refactor rules for the Lovelace YAML dashboards.

## Goals
- Keep each room as a small, readable shell file.
- Move repeatable blocks into shared includes.
- Standardize card styles (transparent, no shadow) and layout patterns.
- Avoid deep nesting where possible.

## Folder Structure
- Root dashboard: ui-lovelace.yaml
- Shared includes: ui/shared/
- Room shells: ui/<room>/<room>.yaml
- Room sections: ui/<room>/<section>.yaml

Example (Wohnzimmer):
- ui/wohnzimmer/wohnzimmer.yaml
- ui/wohnzimmer/beleuchtung.yaml
- ui/wohnzimmer/tv.yaml
- ui/wohnzimmer/terrarium.yaml
- ui/wohnzimmer/thermostat.yaml

Shared:
- ui/shared/messages.yaml
- ui/shared/styles/transparent_card.yaml

## Include Rules
- Always use absolute include paths for cross-folder includes:
  - /config/ui/...
- Room shell should only contain:
  - view metadata
  - shared messages
  - section includes

## Section Pattern (Blueprint)
Each section should follow this structure:

- type: grid
  cards:
    - type: heading
      heading: <Section Title>
      heading_style: title
      icon: <mdi:...>
    - type: vertical-stack
      cards:
        - type: custom:fold-entity-row
          head: <mushroom template card>
          entities: <section content>

## Style Conventions
- Use shared transparent style for inner cards where possible:
  - box-shadow: none
  - border: none
  - background: transparent
- Keep icon_color templates consistent across sections.
- Avoid trailing spaces in headings/titles.

## Messages Block
- Messages live in: /config/ui/shared/messages.yaml
- Every room includes messages as the first section:

sections:
  - type: grid
    cards:
      - !include /config/ui/shared/messages.yaml

## Refactor Checklist
When refactoring a room:
1) Identify repeated styles or patterns.
2) Extract into ui/shared/ (style or snippet).
3) Replace inline blocks with includes.
4) Validate YAML and reload Lovelace.

## Notes
- Keep all files ASCII when possible.
- When adding new custom cards, also update ui-lovelace.yaml resources if resource_mode is yaml.
