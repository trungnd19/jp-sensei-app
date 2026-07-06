# JP Sensei AI Architecture (MVP v1)

## Vision

JP Sensei AI is an AI-powered Safari Share Extension for Japanese learners.

The goal is to remove the friction between reading and learning.

Instead of:

Safari → Copy → Open ChatGPT → Paste → Ask → Back to Safari

The experience should become:

Safari → Highlight → Share → JP Sensei AI → Learn → Done

The user never leaves the reading flow.

---

# Core Product Philosophy

The Share Extension **is the product**.

The Host App is only used for configuration.

The extension should be where users spend 95% of their time.

The Host App should only be opened occasionally.

---

# Primary Goal

When reading Japanese content:

* newspapers
* blogs
* books
* websites

the user should be able to understand any sentence within a few seconds.

---

# Core UX Principle

The extension must NEVER launch the Host App during normal usage.

The explanation UI must be rendered entirely inside the native iOS Share Extension sheet.

Safari remains underneath.

Desired UX:

Safari

↓

Highlight text

↓

Share

↓

JP Sensei AI

↓

Native Share Extension Sheet

↓

AI explanation

↓

Done

↓

Dismiss Sheet

↓

Continue reading in Safari

The reading context should never be interrupted.

---

# Non Goals

The MVP should NOT:

* launch the Host App
* require copy/paste
* require login
* require backend
* interrupt reading
* navigate away from Safari

---

# MVP User Flow

1.

Highlight Japanese text.

↓

2.

Tap Share.

↓

3.

Select JP Sensei AI.

↓

4.

Share Extension receives selected text.

↓

5.

Call OpenAI Responses API.

↓

6.

Receive structured JSON.

↓

7.

Render explanation.

↓

8.

Tap Done.

↓

9.

Continue reading.

---

# Host App Responsibilities

The Host App is NOT the primary experience.

It only provides configuration.

Responsibilities:

* OpenAI API Key
* AI Model selection
* Prompt customization
* Output preferences
* About
* Future settings

---

# API Key Strategy

Use BYOK (Bring Your Own Key).

Flow:

Host App

↓

Paste OpenAI API Key

↓

Store securely using iOS Keychain

↓

Share Extension uses the stored key

No backend.

No user accounts.

No ChatGPT login.

---

# Prompt Strategy

The application should support fully customizable prompts.

A default system prompt will be provided.

Users may edit the prompt entirely.

Example use cases:

* JLPT Study
* News Reading
* Conversation
* Grammar Focus
* Translation
* Custom Prompt

The extension always sends:

System Prompt
+
Selected Text

to OpenAI.

---

# AI Response Format

OpenAI must return structured JSON.

Never Markdown.

Never free-form text.

Example schema:

```json
{
  "original": "",
  "furigana": "",
  "translation": "",
  "vocabulary": [],
  "grammar": [],
  "nuance": "",
  "examples": []
}
```

SwiftUI only renders the JSON.

---

# Explanation Sections

MVP should display:

## Original

Original Japanese sentence.

---

## Furigana

Reading if appropriate.

---

## Vocabulary

For each important word:

* word
* reading
* Vietnamese meaning
* nuance
* JLPT level (optional)

---

## Grammar

Explain:

* grammar pattern
* sentence structure
* why this grammar is used
* similar grammar
* common learner mistakes

Teach.

Do not simply translate.

---

## Translation

Natural Vietnamese translation.

---

## Nuance

Explain:

* formal
* casual
* newspaper style
* spoken
* written
* emotional nuance

---

## Examples

Generate 2–3 natural example sentences.

---

# UI Principles

The UI should feel native to iOS.

Simple.

Minimal.

Fast.

Readable.

No unnecessary animations.

The extension should feel like a native Share Sheet, not a separate application.

Suggested layout:

---

Original

---

Vocabulary

---

Grammar

---

Translation

---

Nuance

---

Examples

---

Done

---

# Performance Goals

Extension launch:

< 1 second

AI response:

3–8 seconds

Avoid heavy dependencies.

---

# Technical Architecture

Safari

↓

Share Extension

↓

Presentation Layer

↓

AI Service

↓

OpenAI Responses API

↓

Structured JSON

↓

SwiftUI Views

No backend.

---

# Project Structure

JP Sensei AI

├── ShareExtension
│
├── Views
├── Components
├── Models
├── Services
├── Prompt
├── Utilities
│
├── Shared
│
├── Models
├── Networking
├── Helpers
│
└── HostApp

---

# Networking

One service:

OpenAIService

Responsibilities:

* Build request
* Attach API key
* Send prompt
* Decode JSON
* Return typed model

Business logic should not live inside Views.

---

# Error Handling

No selected text

↓

Ask user to highlight text.

---

No internet

↓

Retry

---

API timeout

↓

Retry

---

Invalid JSON

↓

Friendly error message

---

# Coding Principles

SwiftUI

MVVM

Async/Await

Codable

Dependency Injection when necessary

Views should remain lightweight.

Networking should be isolated.

Prompt should be configurable.

---

# Future Roadmap (Not MVP)

The following features are intentionally excluded from MVP but the architecture should make them easy to add later.

## Learning

* History
* Favorites
* Saved Vocabulary
* Saved Grammar

## AI

* Follow-up questions
* Explain deeper
* Compare grammar
* Conversation mode

## Export

Design the architecture so that export targets can be added without changing AI logic.

Potential exporters:

* Notion
* Markdown
* CSV
* JSON
* Clipboard
* Quizlet (if a supported integration becomes available in the future)

AI should only produce structured data.

Exporters should be responsible for transforming that data into external formats or services.

---

# Success Criteria

The MVP is successful if a user can:

Read Japanese in Safari

↓

Highlight one sentence

↓

Share

↓

JP Sensei AI

↓

Understand the sentence within a few seconds

↓

Dismiss the Share Extension

↓

Continue reading immediately

without ever leaving Safari.
