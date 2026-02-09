# UI Instructions

This document defines the shared structure, conventions, and refactor rules for the Lovelace YAML dashboards.

## Goals
- Keep each room as a small, readable shell file.
- Move repeatable blocks into shared includes.
- Standardize card styles and layout patterns.
- Use the smallest possible style scope; avoid `:host` unless required.
- Keep headers framed, content cards flat.

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
- ui/shared/decluttering_templates.yaml

## Include Rules
- Always use absolute include paths for cross-folder includes:
  - /config/ui/...
- Room shell should only contain:
  - view metadata
  - shared messages
  - section includes
  - no section content inline

## Style Building Blocks

Use these shared styles in /config/ui/shared/styles/:

- flat_compact.yaml
  - Removes border, shadow, background, padding, and margin.
  - Use for compact content rows or nested cards.

- card_header.yaml
  - Restores a normal card frame for header rows.
  - Use on header cards only.

- stack_wrapper.yaml
  - Transparent wrapper for flexible section layouts.
  - Use as the outer stack-in-card in sections.

- markdown_plain.yaml
  - Simple markdown card without card chrome.

- message_alert.yaml
  - Alert styling for message cards used in ui/shared/messages.yaml.

## Header vs Content Rule
- Headers should have a visible card frame.
- Content rows beneath headers should be flat (no frame).

## Include Comment Rule
- Keep includes on a single line and add a short end-of-line comment.
  Example: `card_mod: !include /config/ui/shared/styles/card_header.yaml # Header Style`

### Example: Fold Header

```yaml
- type: custom:fold-entity-row
  head:
    type: custom:mushroom-template-card
    primary: Lampen
    icon: mdi:lightbulb-group
    card_mod: !include /config/ui/shared/styles/card_header.yaml
  entities:
    - type: custom:mushroom-template-card
      primary: Bright Sun Desert
      card_mod: !include /config/ui/shared/styles/flat_compact.yaml
```

## Preferred Layout Template

For flexible grouped devices with a header and details:

```yaml
- type: vertical-stack
  cards:
    - type: custom:stack-in-card
      mode: vertical
      card_mod: !include /config/ui/shared/styles/stack_wrapper.yaml
      cards:
        - type: custom:fold-entity-row
          head:
            type: custom:mushroom-template-card
            primary: Title
            icon: mdi:information
            card_mod: !include /config/ui/shared/styles/card_header.yaml
          entities:
            - type: custom:mushroom-template-card
              primary: Detail
              card_mod: !include /config/ui/shared/styles/flat_compact.yaml
```

Notes:
- The wrapper stack-in-card stays transparent and borderless.
- Only the header card has a frame.
- All detail cards use flat_compact unless you want default padding.

## When to Use Inline style: |

Inline styles are allowed only for:
- State-based visual logic (e.g., disable a group when a timer is off).
- One-off alert styling that is not reusable.

If a style is reused more than once, move it to a shared style file.

## Messages Block
- Messages live in: /config/ui/shared/messages.yaml
- Message cards use the decluttering template `message_alert` from
  /config/ui/shared/decluttering_templates.yaml
- Every room includes messages as the first section:

```yaml
sections:
  - type: grid
    cards:
      - !include /config/ui/shared/messages.yaml
```

## Refactor Checklist
When refactoring a room:
1) Identify repeated styles or patterns.
2) Extract into ui/shared/ (style or snippet).
3) Replace inline blocks with includes.
4) Validate YAML and reload Lovelace.

## Notes
- Keep all files ASCII when possible.
- When adding new custom cards, also update `configuration.yaml` resources (yaml mode).
- Use only one overview file: ui/overview.yaml.
