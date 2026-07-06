# AI_RULES.md

# JP Sensei AI - AI Development Rules

## Purpose

This document defines the engineering rules that every AI coding agent must follow when contributing to this project.

These rules take precedence over implementation preferences.

If there is any conflict between generated code and these rules, these rules win.

---

# Product First

Always optimize for the product experience.

Never optimize for architecture at the expense of UX.

The primary objective is:

Read Japanese with as little friction as possible.

---

# Respect Existing Architecture

Do not redesign the project.

Do not introduce a different architecture.

Do not migrate to another design pattern.

Follow the existing project structure.

---

# Keep It Simple

Prefer the simplest implementation that satisfies the requirement.

Avoid clever solutions.

Avoid unnecessary abstractions.

Avoid premature optimization.

---

# MVP First

Only implement features that belong to the current milestone.

Never implement roadmap features early.

Never "prepare" code for features that do not exist yet.

The codebase should grow naturally.

---

# Native First

Always prefer Apple's native frameworks.

Preferred:

* SwiftUI
* Foundation
* URLSession
* Codable
* Async/Await

Avoid third-party libraries unless absolutely necessary.

---

# Dependencies

Before adding any dependency:

Ask:

Can this be implemented using Apple's APIs?

If yes,

do not add the dependency.

Every dependency must have a clear justification.

---

# View Rules

Views should only render UI.

Views should not:

* perform networking
* contain business logic
* build prompts
* decode JSON

Views should remain lightweight.

---

# Service Rules

Networking belongs inside Services.

Prompt building belongs inside Prompt components.

Parsing belongs inside Models.

Keep responsibilities separated.

---

# Prompt Rules

Never hardcode prompts inside Views.

Prompt logic must be isolated.

Users must be able to edit prompts from the Host App.

---

# API Rules

Never hardcode API keys.

Never log API keys.

Never expose API keys in debug output.

Always read API keys from secure storage.

---

# Error Handling

Never ignore errors.

Never silently fail.

Every failure should produce a user-friendly message.

The application should never crash because of an expected API failure.

---

# JSON Rules

Always prefer strongly typed models.

Avoid dictionaries when Codable models are appropriate.

Prefer compile-time safety.

---

# UI Rules

The Share Extension is the product.

Never launch the Host App during normal usage.

The explanation UI must remain entirely inside the Share Extension sheet.

The reading experience must never be interrupted.

---

# Host App Rules

The Host App exists only for configuration.

Do not move primary features into the Host App.

Keep it lightweight.

---

# Performance Rules

Show loading immediately.

Avoid blocking the main thread.

Use async/await.

Avoid unnecessary re-rendering.

Avoid unnecessary object creation.

---

# Code Style

Prefer readable code.

Prefer explicit naming.

Avoid overly generic helper classes.

Prefer composition over inheritance.

Keep files reasonably small.

Functions should have one responsibility.

---

# Comments

Write comments only when they explain intent.

Do not comment obvious code.

Bad:

// Increment counter

Good:

// Safari sometimes sends multiple providers;
// prefer plain text when available.

---

# Logging

Avoid excessive logging.

Never log:

* API keys
* Prompt contents (unless explicitly enabled for debugging)
* User data

---

# Testing

Every completed milestone should compile successfully.

Every completed milestone should be manually testable.

Do not leave half-finished implementations.

---

# Git Commits

Each commit should represent one logical change.

Avoid mixing unrelated features.

Good examples:

* Add OpenAIService
* Implement Share Extension loading view
* Persist API key in Keychain

Bad example:

* Misc updates

---

# Decision Making

When multiple implementations are possible:

Choose the one that is:

1. Simpler
2. More readable
3. More native
4. Easier to maintain

Do not optimize for hypothetical future requirements.

---

# Future Features

Do not implement:

* History
* Favorites
* Export
* Quizlet integration
* Notion integration
* Follow-up chat
* Multi-provider AI

until they are scheduled in the implementation plan.

Leave clean extension points instead.

---

# Security

Treat all user content as private.

Never send user data anywhere except the configured AI provider.

Never collect analytics in the MVP.

Never introduce telemetry without explicit approval.

---

# AI Behavior

If a requirement is ambiguous:

Do not invent functionality.

Follow this priority:

1. PRODUCT_REQUIREMENTS.md
2. ARCHITECTURE.md
3. IMPLEMENTATION_PLAN.md
4. Existing codebase

If still unclear,

leave a TODO comment and explain the assumption.

---

# Definition of Success

The project succeeds when the codebase is:

Simple.

Native.

Maintainable.

Easy to extend.

And most importantly—

helps users understand Japanese without leaving Safari.
