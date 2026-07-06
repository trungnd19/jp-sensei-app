# PRODUCT_REQUIREMENTS.md

# JP Sensei AI

## Product Summary

JP Sensei AI is an AI-powered Safari Share Extension that helps Japanese learners understand Japanese text without interrupting their reading flow.

The product focuses on learning, not translation.

The core experience is:

Read → Highlight → Share → Learn → Continue Reading

---

# Product Goal

The user should never need to:

* copy text
* switch to ChatGPT
* paste text
* ask manually

Understanding a Japanese sentence should take only a few seconds.

---

# Primary Users

Japanese learners.

Especially users reading:

* Japanese news
* NHK
* Blogs
* Books
* Documentation
* Websites

---

# MVP Scope

Included:

✅ Safari Share Extension

✅ AI explanation

✅ OpenAI API

✅ Host App

❌ History

❌ Export

❌ Saved Vocabulary

❌ Quizlet

❌ Notion

❌ Follow-up Chat

---

# Product Philosophy

The product is NOT ChatGPT.

The product is NOT a translator.

The product is a Japanese teacher.

Every AI response should prioritize learning.

---

# User Journey

User is reading Japanese.

↓

Finds a difficult sentence.

↓

Highlights the sentence.

↓

Taps Share.

↓

Selects JP Sensei AI.

↓

Native Share Sheet opens.

↓

Loading indicator appears.

↓

AI explanation is displayed.

↓

User reads explanation.

↓

Tap Done.

↓

Return immediately to Safari.

No Host App is opened.

---

# Host App

The Host App is a configuration application.

Users are NOT expected to open it every day.

Responsibilities:

* API Key
* Prompt
* AI Model
* Output Settings
* About

---

# Screen 1

## Share Extension Loading

Purpose:

Provide immediate feedback.

UI:

App icon

Spinner

"Analyzing Japanese..."

No other interaction.

---

# Screen 2

## AI Result

Sections should always appear in this order.

---

### Original

Original Japanese sentence.

Collapsed: No

---

### Furigana

Display reading if appropriate.

Collapsed: No

---

### Vocabulary

Display one card per vocabulary.

Each card contains:

Word

Reading

Meaning

Nuance

JLPT (optional)

---

### Grammar

Display one grammar block.

Each block contains:

Grammar

Explanation

Why used

Common mistake

Similar grammar

---

### Translation

Natural Vietnamese translation.

---

### Nuance

Explain writing style.

Examples:

News

Formal

Casual

Business

Conversation

---

### Examples

Generate 2~3 examples.

Each example contains:

Japanese

Vietnamese

---

# Buttons

Bottom only.

Primary

Done

Future:

Copy

Save

Export

---

# Empty State

If no text is received.

Show:

"No selected text."

Instruction:

"Please highlight Japanese text before opening JP Sensei AI."

---

# Error State

Network failure.

Show:

Unable to contact AI.

Button:

Retry

---

# Timeout

Show:

Still thinking...

Retry

---

# AI Behavior

The AI should behave like an experienced Japanese teacher.

Not a translator.

Not a dictionary.

It should explain:

Why.

Not only:

What.

---

# Prompt

The application ships with a default prompt.

Users can edit it completely.

The application never modifies the user's custom prompt.

---

# API Key

Required.

Stored securely.

Never hardcoded.

Never logged.

Never uploaded except to OpenAI API.

---

# Performance Requirements

Extension launches within one second.

Loading UI appears immediately.

Large animations should be avoided.

Scrolling should remain smooth.

---

# Accessibility

Support Dynamic Type where practical.

Support Dark Mode.

Support Light Mode.

Support VoiceOver labels for major controls.

Touch targets should follow iOS Human Interface Guidelines.

---

# Design Principles

Native iOS.

Minimal.

Readable.

Fast.

No decorative UI.

Learning comes before visual effects.

---

# Future Features

The following should NOT be implemented in MVP, but the design should leave room for them.

Learning

* History
* Favorites
* Saved Sessions

AI

* Ask Follow-up Question
* Explain More
* Compare Grammar
* Conversation Practice

Export

* Markdown
* CSV
* JSON
* Clipboard
* Notion
* Quizlet (future if supported)
* Other learning platforms

Settings

* Multiple Prompt Presets
* Multiple AI Providers
* Prompt Templates

---

# Success Criteria

The user successfully understands Japanese while staying inside Safari.

The user never feels the need to switch to ChatGPT during reading.

The Share Extension becomes the primary way to study Japanese from web content.
