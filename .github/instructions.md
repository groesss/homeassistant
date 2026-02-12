# Instructions

This document defines general project rules that apply across the repo unless a more specific instruction file exists.

## Instruction Files Overview

This project uses specialized instruction files for different areas:

- **[ui-instructions.md](ui-instructions.md)** - Complete UI/Lovelace documentation
  - Dashboard structure and conventions
  - Style building blocks and layout patterns
  - Templates (decluttering and button-card)
  - fold-entity-row requirements
  - Refactor guidelines

- **[messages-instructions.md](messages-instructions.md)** - Message system documentation
  - Message card configuration
  - Conditional display rules
  - Template usage

- **[terrarium-instructions.md](terrarium-instructions.md)** - Terrarium automation details
  - Warmup/Cooldown logic
  - Timer controls
  - Lighting schedules

- **[instructions.md](instructions.md)** (this file) - General project rules
  - Tooling conventions (Windows, Git, PowerShell)
  - General file conventions
  - Cross-cutting concerns

## Scope
- General rules apply by default.
- UI-specific rules live in [ui-instructions.md](ui-instructions.md).
- Messages rules live in [messages-instructions.md](messages-instructions.md).
- If multiple instruction files apply, follow the most specific one.

## Tooling (Windows)
- Git: use an explicit path if Git is not on PATH, e.g. "C:\Program Files\Git\bin\git.exe".
- PowerShell: quote paths with spaces and prefer direct invocation for scripts (e.g. `& "C:\path\script.ps1"`).

## General Conventions
- Keep files ASCII when possible.
- Keep changes scoped; avoid unrelated edits.
