# IMPLEMENTATION_PLAN.md

# JP Sensei AI - Implementation Plan

## Development Philosophy

Build the smallest working product first.

Every milestone must produce a working application.

Never implement multiple major features in a single milestone.

Each milestone should be independently testable.

---

# Milestone 0 — Project Setup

## Goal

Create a clean project foundation.

## Tasks

* Create Xcode project
* Create Host App target
* Create Share Extension target
* Configure App Group
* Configure Keychain Sharing
* Configure project structure
* Setup SwiftLint (optional)
* Setup folder organization

## Deliverable

Project builds successfully.

Share Extension is visible in iOS Share Sheet.

No AI functionality yet.

---

# Milestone 1 — Receive Shared Text

## Goal

Receive selected text from Safari.

## Tasks

* Receive shared content
* Detect plain text
* Handle unsupported content
* Pass text into SwiftUI View

## Success Criteria

User highlights text.

↓

Share.

↓

JP Sensei AI.

↓

Selected text appears inside the Share Extension.

No networking yet.

---

# Milestone 2 — Build Extension UI

## Goal

Create the complete Share Extension interface.

## Tasks

Create:

* Loading View
* Result View
* Error View
* Empty State

Create reusable components:

* Section Card
* Vocabulary Card
* Grammar Card

## Success Criteria

Use mock JSON.

UI matches product requirements.

No OpenAI yet.

---

# Milestone 3 — Host App Settings

## Goal

Create a minimal configuration app.

## Screens

Settings

Contains:

* API Key
* AI Model
* Prompt
* About

## Tasks

Store:

* API Key
* Prompt
* Preferred Model

Persist using secure storage where appropriate.

## Success Criteria

Settings persist after app restart.

Share Extension can access stored configuration.

---

# Milestone 4 — OpenAI Integration

## Goal

Connect to OpenAI Responses API.

## Tasks

Create:

OpenAIService

Responsibilities:

* Build request
* Attach prompt
* Attach API Key
* Send request
* Decode JSON
* Return model

## Success Criteria

Real API response received.

Result displayed in Share Extension.

---

# Milestone 5 — Prompt System

## Goal

Support customizable prompts.

## Tasks

* Load default prompt
* Allow user editing
* Save custom prompt
* Send custom prompt to OpenAI

## Success Criteria

Editing the prompt changes AI behavior without code changes.

---

# Milestone 6 — Error Handling

## Goal

Handle failure gracefully.

## Cases

* No text
* No API Key
* No internet
* Timeout
* Invalid response
* API error

## Success Criteria

Every error produces a friendly UI.

No crashes.

---

# Milestone 7 — Performance

## Goal

Improve perceived speed.

## Tasks

* Show loading immediately
* Async networking
* Reduce unnecessary rendering
* Cache static resources if needed

## Success Criteria

Extension opens quickly.

Scrolling remains smooth.

---

# Milestone 8 — Polish

## Goal

Make the application feel native.

## Tasks

* Improve spacing
* Improve typography
* Improve Dark Mode
* Improve animations (minimal)
* Improve accessibility
* Improve VoiceOver labels

## Success Criteria

Application feels like a native Apple app.

---

# MVP Complete

At this point the application should support:

✅ Highlight text

✅ Share

✅ JP Sensei AI

✅ AI explanation

✅ Custom prompt

✅ Custom API Key

✅ Return to Safari

No additional features should be implemented before validating the MVP through real daily usage.

---

# Post-MVP Roadmap

The following features should only begin after the MVP has been used extensively.

## Phase 2

Learning

* History
* Favorites
* Saved Sessions

## Phase 3

Export System

Design an extensible export architecture.

Potential export targets:

* Markdown
* CSV
* JSON
* Clipboard
* Notion
* Quizlet (future if supported)

AI should continue producing structured JSON.

Exporters transform structured data into external formats.

## Phase 4

AI Improvements

* Follow-up questions
* Explain deeper
* Compare grammar
* Conversation mode
* Multiple AI providers

## Phase 5

Advanced Settings

* Prompt presets
* Multiple models
* Temperature
* Max tokens
* Structured output options

---

# Engineering Rules

Every milestone must:

* Compile successfully
* Be testable
* Avoid placeholder architecture that is never used
* Keep Views lightweight
* Isolate networking logic
* Preserve separation of concerns

Avoid premature optimization.

Avoid implementing future roadmap items inside the MVP.

Keep the codebase simple, maintainable, and easy to extend.

---

# Definition of Done

The project is considered complete when:

A user can read Japanese in Safari,

highlight any sentence,

open JP Sensei AI,

receive an AI explanation,

close the Share Extension,

and immediately continue reading—

without ever opening the Host App during normal usage.
