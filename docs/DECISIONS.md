# DECISIONS.md

# JP Sensei AI - Architectural Decisions

This document records important architectural and product decisions.

The purpose is to preserve design intent over time.

Future contributors and AI agents should understand *why* certain decisions were made before proposing alternatives.

---

# Decision 1

## Share Extension is the Product

### Decision

The Share Extension is the primary user experience.

The Host App is only a supporting application.

### Reason

Users spend almost all of their time reading in Safari.

Switching applications breaks concentration.

The learning flow should remain:

Read

↓

Highlight

↓

Learn

↓

Continue Reading

The Host App exists only for configuration.

---

# Decision 2

## Never Launch the Host App

### Decision

The Share Extension must never automatically launch the Host App.

### Reason

Opening another application interrupts the reading experience.

The explanation should appear entirely inside the Share Extension sheet.

Safari remains visible underneath.

---

# Decision 3

## Learning Before Translation

### Decision

The product is designed as a Japanese teacher.

Not a translator.

### Reason

The goal is language acquisition.

Translation alone is insufficient.

Every explanation should prioritize understanding.

---

# Decision 4

## BYOK (Bring Your Own API Key)

### Decision

Users provide their own OpenAI API Key.

### Reason

Advantages:

* no backend
* lower infrastructure cost
* better privacy
* simpler architecture
* predictable usage costs

ChatGPT login is intentionally not supported.

---

# Decision 5

## No Backend in MVP

### Decision

The MVP communicates directly with OpenAI.

### Reason

A backend would introduce:

* authentication
* infrastructure
* deployment
* maintenance
* additional failure points

These are unnecessary for validating the product.

---

# Decision 6

## Structured JSON Response

### Decision

AI responses must be structured JSON.

Not Markdown.

### Reason

Structured data is:

* predictable
* easier to render
* easier to validate
* easier to export
* easier to extend

The UI should render models, not parse prose.

---

# Decision 7

## Fully Customizable Prompt

### Decision

Users may completely replace the default system prompt.

### Reason

Different learners have different goals.

Examples:

* JLPT
* News
* Conversation
* Grammar
* Translation

The application should not restrict advanced users.

---

# Decision 8

## Native iOS Experience

### Decision

Use Apple's native UI patterns.

### Reason

The application should feel like a built-in part of iOS.

Avoid recreating custom interfaces when native components provide a better experience.

---

# Decision 9

## SwiftUI First

### Decision

The project uses SwiftUI.

### Reason

SwiftUI is the recommended framework for modern iOS development.

It integrates naturally with Share Extensions and keeps the codebase concise.

---

# Decision 10

## Minimal Dependencies

### Decision

Prefer Apple's frameworks whenever possible.

### Reason

Fewer dependencies mean:

* faster builds
* fewer updates
* fewer security concerns
* lower maintenance

---

# Decision 11

## Simple Architecture

### Decision

Keep the architecture intentionally small.

### Reason

This project is a personal productivity tool.

Complex architecture would reduce development speed without improving user value.

---

# Decision 12

## Feature Growth After Validation

### Decision

Do not implement advanced features before validating the MVP.

### Reason

The product should first prove that the core workflow is genuinely useful in daily study.

Only after regular real-world usage should additional features be considered.

---

# Decision 13

## Export Is a Separate Layer

### Decision

Export functionality should remain independent from AI generation.

### Reason

The AI should only generate structured learning data.

Separate exporters will transform that data into external formats.

Potential exporters include:

* Notion
* Markdown
* CSV
* JSON
* Clipboard
* Quizlet (if officially supported in the future)

This separation keeps the AI layer clean and makes new export targets easy to add.

---

# Decision 14

## Privacy First

### Decision

The application stores only the minimum amount of information necessary.

### Reason

Users may analyze sensitive or copyrighted content.

The application should respect user privacy by default.

No analytics.

No telemetry.

No unnecessary cloud storage.

---

# Decision 15

## AI Should Not Make Product Decisions

### Decision

AI coding agents must not invent features or alter the user experience.

### Reason

Architectural and UX decisions belong to the project owner.

AI should implement decisions, not redefine them.

---

# Decision 16

## Success Is Measured by Flow, Not Features

### Decision

The project's success is measured by how naturally it fits into the user's reading workflow.

### Reason

A simple tool that removes friction provides more value than a feature-rich application that interrupts reading.

The ideal experience is:

Read Japanese

↓

Highlight

↓

Share

↓

JP Sensei AI

↓

Understand

↓

Done

↓

Continue Reading

If this flow feels effortless, the product has achieved its primary goal.
