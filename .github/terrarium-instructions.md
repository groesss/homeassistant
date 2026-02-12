# Terrarium Instructions

This document describes the terrarium lighting logic and how to adjust the warmup/cooldown behavior.

## Core Concept
- Lamp 1 defines the official lighting duration.
- Lamp 2 starts 30 minutes after Lamp 1 and stops 30 minutes after Lamp 1.
- The shared lighting overlap is 30 minutes shorter than Lamp 1's duration.

Example: a "12h" duration refers to Lamp 1. The shared overlap is 11.5h.

## Warmup / Cooldown Behavior
- Warmup increases total duration by 1 hour per day.
  - Lamp 1: start 30 min earlier, stop 30 min later.
  - Lamp 2: start 30 min earlier, stop 30 min later.
- Cooldown decreases total duration by 1 hour per day.
  - Lamp 1: start 30 min later, stop 30 min earlier.
  - Lamp 2: start 30 min later, stop 30 min earlier.

## Max Duration (Input)
- The input number defines the maximum allowed duration for Lamp 1.
- Entity: input_number.wohnzimmer_terrarium_max_time
- Source file: helpers/input_number/wohnzimmer_terrarium.yaml

## Automation Logic (Warmup)
- The warmup automation compares Lamp 1 duration to the max input.
- When the duration is greater or equal, warmup stops.

Pseudo-logic:
- Read lamp1 on/off times.
- Calculate duration in hours.
- If duration >= input_number.wohnzimmer_terrarium_max_time: stop warmup.
- Else: apply +1h change.

## Related Files
- automations.yaml (Warmup/Cooldown automation)
- helpers/input_number/wohnzimmer_terrarium.yaml (max duration input)
- ui/wohnzimmer/terrarium.yaml (controls)
