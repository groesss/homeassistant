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

- entities_flat.yaml
  - Optimized for entities cards containing fold-entity-row.
  - Removes all padding/margin to maximize width within fold-entity-row.
  - Required when using fold-entity-row (must be in entities card).

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
- Header cards should include a concise `secondary` line with a dynamic state or short status text.

## Include Comment Rule
- Keep includes on a single line and add a short end-of-line comment.
  Example: `card_mod: !include /config/ui/shared/styles/card_header.yaml # Header Style`

### Example: Fold Header

```yaml
- type: entities
  card_mod: !include /config/ui/shared/styles/entities_flat.yaml
  entities:
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

**Important:** fold-entity-row must always be inside an entities card.

## Preferred Layout Template

For flexible grouped devices with a header and details:

```yaml
- type: vertical-stack
  cards:
    - type: custom:stack-in-card
      mode: vertical
      card_mod: !include /config/ui/shared/styles/stack_wrapper.yaml
      cards:
        - type: entities
          card_mod: !include /config/ui/shared/styles/entities_flat.yaml
          entities:

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
- The entities card uses entities_flat.yaml for maximum width.
- fold-entity-row MUST be inside an entities card (technical requirement).
- Only the header card has a frame.
- All detail cards use flat_compact unless you want default padding.

## fold-entity-row Constraint

**IMPORTANT:** `custom:fold-entity-row` must ALWAYS be placed inside an `entities` card.

Using fold-entity-row directly inside stack-in-card or vertical-stack will produce console errors:
```
fold-entity-row should only EVER be used INSIDE an ENTITIES CARD
```

Correct structure:
```yaml
- type: entities
  card_mod: !include /config/ui/shared/styles/flat_compact.yaml
  entities:
    - type: custom:fold-entity-row
      head: ...
      entities: ...
```

Wrong (causes errors):
```yaml
- type: custom:stack-in-card
  cards:
    - type: custom:fold-entity-row  # ❌ Not inside entities card!
      head: ...
```

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
- General project rules and tooling live in [.github/instructions.md](.github/instructions.md).
- Terrarium behavior details live in [.github/terrarium-instructions.md](.github/terrarium-instructions.md).
- Messages logic lives in [.github/messages-instructions.md](.github/messages-instructions.md).

---

# Templates

This section documents all reusable templates for Lovelace dashboards.

## Template Types

### Decluttering Templates
Automatically loaded from `ui/shared/templates/` via `!include_dir_merge_named`.
Used for reusable card structures with variables.

### Button Card Templates  
Separate file `button_card_templates.yaml` for button-card components.
Loaded via `button_card_templates: !include ui/shared/templates/button_card_templates.yaml`.

---

## Decluttering Templates

### 1. Schedule Timebox (`schedule_timebox.yaml`)
**Purpose:** Horizontal stack with time and temperature selection for heating control

**Usage:**
```yaml
type: custom:decluttering-card
template: schedule_timebox
variables:
  - time: input_datetime.heizung_slot1_time
  - temp: input_number.heizung_slot1_temp
```

**Variables:**
- `time`: Entity-ID of time entity (input_datetime)
- `temp`: Entity-ID of temperature entity (input_number)

**Features:**
- Numberbox-Card for temperature selection
- Input-Datetime for time selection
- Clock and thermometer icons

---

### 2. Message Alert (`message_alert.yaml`)
**Purpose:** Markdown card for notifications with dynamic emojis

**Usage:**
```yaml
type: custom:decluttering-card
template: message_alert
variables:
  - entity: sensor.system_nachricht
```

**Variables:**
- `entity`: Message entity with attributes:
  - `message_type`: 'info', 'warning' or 'error'
  - `message_title`: Heading
  - `message`: Message content

**Message Types:**
- `info` → 💡 (Information)
- `warning` → ⚠️ (Warning)
- `error` → ❌ (Error)
- `default` → 🔔 (Notification)

---

### 3. Timer Row (`timer_row.yaml`)
**Purpose:** Timer control with on/off times and toggle switch

**Usage:**
```yaml
type: custom:decluttering-card
template: timer_row
variables:
  - time_on: input_datetime.wohnzimmer_terrarium_lampe1_on
  - time_off: input_datetime.wohnzimmer_terrarium_lampe1_off
  - switch_entity: switch.wohnzimmer_smartplug_terrarium_1
```

**Variables:**
- `time_on`: On time (input_datetime)
- `time_off`: Off time (input_datetime)
- `switch_entity`: Switch entity (switch/light/...)

**Features:**
- Sunrise/sunset icons
- Colored status display (yellow=on, grey=off)
- Direct toggle via tap

---

### 4. Schedule Slot (`schedule_slot.yaml`)
**Purpose:** Simple schedule slot with time and temperature

**Usage:**
```yaml
type: custom:decluttering-card
template: schedule_slot
variables:
  - time: input_datetime.heizung_montag_1_time
  - temp: input_number.heizung_montag_1_temp
```

**Variables:**
- `time`: Time entity (input_datetime)
- `temp`: Temperature entity (input_number)

**Difference to schedule_timebox:**
- Uses input-number instead of numberbox-card
- More compact display
- Better suited for nested structures

---

### 5. Thermostat Card (`thermostat_card.yaml`)
**Purpose:** Complete thermostat control with scheduling for all weekdays

**Usage:**
```yaml
type: custom:decluttering-card
template: thermostat_card
variables:
  - climate: climate.wohnzimmer_thermostat
  - title: Wohnzimmer Heizung
  - local_temp: sensor.wohnzimmer_temperatur
  - battery: sensor.wohnzimmer_thermostat_batterie
  - frost_temp: input_number.wohnzimmer_frostschutz
  - open_window: binary_sensor.wohnzimmer_fenster
  - schedule_same: input_boolean.wohnzimmer_gleicher_zeitplan
  # ... more variables (see template file)
```

**Main Areas:**
1. **Thermostat Control**
   - Thermostat card with temperature control
   - Room temperature display
   - Battery status
   - Frost protection temperature

2. **Schedule Control**
   - Switch: shared or individual schedule
   - Shared: 4 time slots for all days
   - Individual: 4 time slots × 7 weekdays

**Required Variables:**
- Base: `climate`, `title`, `local_temp`, `battery`, `frost_temp`, `open_window`, `schedule_same`
- Shared: `schedule_common_X_time/temp` (X = 1-4)
- Individual: `schedule_[weekday]_X_time/temp` for each weekday (X = 1-4)

**Features:**
- Color coding (orange=heating, grey=off)
- Window status display
- Conditional cards for flexible views
- Uses schedule_slot template for schedule slots

---

## Button Card Templates

### Overview Tile (`button_card_templates.yaml`)
**Purpose:** Room tiles for overview page with unified design

**Usage:**
```yaml
type: custom:button-card
template: overview_tile
name: Wohnzimmer
icon: mdi:sofa
show_state: true
state_display: |
  [[[ return 'Custom Status'; ]]]
tap_action:
  action: navigate
  navigation_path: view_wohnzimmer
```

**Features:**
- Consistent size and spacing (90px height, 16px border-radius)
- Hover effects with elevation animation
- Shadow effects for depth
- Optimized grid layout for icon, name and status
- Standard text colored icons
- Smooth transitions (0.3s)

**Styling:**
- **Card**: 90px high, 16px border-radius, shadows, transitions
- **Icon**: 48px, standard text color
- **Name**: 14px, bold, 8px top margin
- **Status**: 12px, secondary-text-color, 4px margin

**Hover Effect:**
- Elevated shadow
- Slight lift (-2px transform)

---

## Template Integration

### Decluttering Templates
Automatically loaded via:
```yaml
decluttering_templates: !include_dir_merge_named ui/shared/templates
```

All `.yaml` files in the folder (except `button_card_templates.yaml` and `README.md`) are registered as decluttering templates.

### Button Card Templates
Separate inclusion in `ui-lovelace.yaml`:
```yaml
button_card_templates: !include ui/shared/templates/button_card_templates.yaml
```

---

## Template Best Practices

1. **Variable Names**: Always use descriptive names
2. **Entity Verification**: Ensure all entities exist before use
3. **Styling**: Don't change style includes (consistency)
4. **Nesting**: Use `flat_compact_nested.yaml` for multiple nesting levels
5. **Overflow**: `overflow:visible` is enabled for correct icon display with negative margins
6. **Documentation**: Each template file contains inline documentation
