Logic architecture

                 ┌─────────────────────┐
                 │      Safari         │
                 └──────────┬──────────┘
                            │
                      Highlight Text
                            │
                            ▼
                 ┌─────────────────────┐
                 │  Share Extension    │
                 │   (Main Product)    │
                 └──────────┬──────────┘
                            │
                     ResultViewModel
                            │
            ┌───────────────┴───────────────┐
            ▼                               ▼
     PromptBuilder                  OpenAIService
            │                               │
            └───────────────┬───────────────┘
                            ▼
                      OpenAI Responses API
                            │
                            ▼
                     Structured JSON
                            │
                            ▼
                      SwiftUI Result UI

Host App

Host App

Settings
    │
    ├── API Key
    ├── Prompt
    ├── AI Model
    └── About

        │
        ▼

Shared Storage (Keychain/App Group)

        ▲
        │

Share Extension đọc cấu hình