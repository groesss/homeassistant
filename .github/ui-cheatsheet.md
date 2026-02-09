# UI Cheat Sheet

## Most Used Styles
- flat_compact.yaml -> flat content rows (no frame, no padding)
- flat_base.yaml -> flat content with default padding
- card_header.yaml -> framed header cards
- transparent_card.yaml -> transparent cards (same corner style)
- flat_host_reset.yaml -> only if ha-card is not enough

## Header + Content Pattern

```yaml
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

## Section Skeleton

```yaml
- type: grid
  cards:
    - type: heading
      heading: Section Title
      heading_style: title
      icon: mdi:tag
    - type: vertical-stack
      cards:
        - type: custom:stack-in-card
          mode: vertical
          card_mod:
            style: |
              ha-card {
                background: transparent !important;
                box-shadow: none !important;
                border: none !important;
                padding: 6px 0 !important;
              }
          cards:
            - type: custom:fold-entity-row
              head:
                type: custom:mushroom-template-card
                primary: Group
                icon: mdi:group
                card_mod: !include /config/ui/shared/styles/card_header.yaml
              entities:
                - type: custom:mushroom-template-card
                  primary: Item
                  card_mod: !include /config/ui/shared/styles/flat_compact.yaml
```

## Inline style: | Only If
- State-based enable/disable logic
- One-off visual alert

## Quick Checklist
1) Header? -> card_header.yaml
2) Content? -> flat_compact.yaml or flat_base.yaml
3) Avoid :host unless needed
4) Reuse includes instead of inline styles
