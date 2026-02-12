# Messages Instructions

This document describes how messages are defined once and then reused for UI and phone notifications.

## Concept
- Message definitions live in templates/messages.yaml.
- UI and notifications are generic and read the same message attributes.
- When you add a new message, you update the message definition and the consumer lists.

## Files and Responsibilities
- templates/messages.yaml
  - Defines each message sensor with state + attributes.
  - Required attributes: message_title, message, message_type.
- ui/shared/messages.yaml
  - Renders the message list in the UI via decluttering template.
- ui/shared/decluttering_templates.yaml
  - Template that reads message attributes and formats the card.
- automations.yaml
-  - automation.alle_messages_notification sends all active messages to phones.

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
3) Ensure the message is included in notifications
  - Add the sensor entity to automation.alle_messages_notification in automations.yaml.

## Conventions
- Keep text concise and action-oriented.
- Use ASCII when possible.
- Keep message_type consistent: info, warning, error.

## Example (Template Sensor)
```yaml
- sensor:
    - name: "Device Battery Low"
      unique_id: device_battery_low
      state: "{{ states('sensor.device_battery') | int < 20 }}"
      icon: mdi:battery
      attributes:
        message_title: "Battery low"
        message: "Device battery is below 20%. Please replace soon."
        message_type: "warning"
```
