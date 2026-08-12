# Messages Instructions

This document describes how messages are defined once and then reused for UI and phone notifications.

## Concept
- Message definitions live in templates/messages.yaml.
- UI and notifications read the same message attributes.
- In this repository, message consumers are NOT dynamic. When you add a new message, you must update the message definition and the static consumer lists.

## Files and Responsibilities
- templates/messages.yaml
  - Defines each message sensor with state + attributes.
  - Required attributes: message_title, message, message_type.
- ui/shared/messages.yaml
  - Renders the message list in Lovelace.
  - Every new message sensor must be added here explicitly as a conditional card.
- ui/shared/templates/message_alert.yaml
  - Template used by the UI message cards.
- automations/messages_notification.yaml
  - Sends all active messages to phones.
  - Every new message sensor must be added here explicitly to the trigger entity list.

## Add a New Message (Checklist)
1) Add a sensor entry in templates/messages.yaml
   - Choose a unique name and unique_id.
   - Define state to indicate when the message is active.
   - Set attributes:
     - message_title: short title
     - message: full text
     - message_type: info | warning | error
2) Ensure the message is included in the UI list
  - Add the sensor entity to ui/shared/messages.yaml.
  - Follow the existing conditional-card pattern.
3) Ensure the message is included in notifications
  - Add the sensor entity to automations/messages_notification.yaml.
  - Extend the trigger entity_id list.

## Important Behavior
- The message pipeline has 3 required maintenance points:
  1. templates/messages.yaml
  2. ui/shared/messages.yaml
  3. automations/messages_notification.yaml
- If you only add the template sensor, it will NOT automatically appear in the UI or in push notifications.
- Dynamic discovery was attempted previously and did not work reliably in this setup. Prefer explicit static lists.

## Battery Messages
- Battery-based messages must be robust against unknown and unavailable values.
- Do NOT use patterns like states('sensor.xyz_battery') | int < 20 directly.
- Reason: unknown or unavailable may be coerced to 0 and trigger false alerts.
- Use a guarded template instead.

## Conventions
- Keep text concise and action-oriented.
- Use ASCII when possible.
- Keep message_type consistent: info, warning, error.
- Prefer message text that still renders sensibly if the current sensor value is missing.

## Example (Template Sensor)
```yaml
- sensor:
    - name: "Device Battery Low"
      unique_id: device_battery_low
      state: >
        {% set battery = states('sensor.device_battery') %}
        {{ battery not in ['unknown', 'unavailable', 'none', 'None', ''] and battery | float(101) < 20 }}
      icon: mdi:battery
      attributes:
        message_title: "Battery low"
        message: >
          {% set battery = states('sensor.device_battery') %}
          Device battery is below 20%.
          Current value: {{ battery if battery not in ['unknown', 'unavailable', 'none', 'None', ''] else '?' }} %.
          Please replace soon.
        message_type: "warning"
```

## UI Pattern Example
```yaml
- type: conditional
  conditions:
    - entity: sensor.device_battery_low
      state: 'True'
  card:
    type: custom:decluttering-card
    template: message_alert
    variables:
      - entity: sensor.device_battery_low
```

## Notification Pattern Example
```yaml
triggers:
  - entity_id:
      - sensor.device_battery_low
    to: 'True'
    trigger: state
```
