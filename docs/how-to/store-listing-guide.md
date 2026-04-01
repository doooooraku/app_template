# Store Listing Guide

## Overview

Both Apple App Store and Google Play require localized store listings. This guide covers the process for creating and maintaining them.

## Store Listing Components

### Google Play

| Field             | Max Length          | Notes                               |
| ----------------- | ------------------- | ----------------------------------- |
| Title             | 30 chars            | App name + key benefit              |
| Short description | 80 chars            | One-line elevator pitch             |
| Full description  | 4000 chars          | Features, benefits, differentiators |
| Screenshots       | 2-8 per device type | Phone (required), Tablet (optional) |
| Feature graphic   | 1024x500            | Promotional banner                  |

### Apple App Store

| Field            | Max Length          | Notes                         |
| ---------------- | ------------------- | ----------------------------- |
| App name         | 30 chars            | Same as Google Play title     |
| Subtitle         | 30 chars            | Similar to short description  |
| Description      | 4000 chars          | No HTML/markdown allowed      |
| Promotional text | 170 chars           | Can be changed without review |
| Screenshots      | Up to 10 per device | 6.7", 6.5", 5.5" required     |

## Workflow

### 1. Write English Copy First

Start with the English (en-US) listing:

- Write compelling, benefit-focused copy
- Focus on what the user gets, not technical features
- Use action verbs and clear language

### 2. Generate Translations

Use Claude Code to translate to all 19 locales:

- Provide the English copy as source
- Request translations that feel natural (not literal)
- Review key markets (ja, de, fr, es) carefully

### 3. Generate Screenshots

Follow the [Screenshot Generation Guide](./screenshot-generation.md).

### 4. Upload to Stores

Store listing files are organized in `docs/store-listing/`:

```
docs/store-listing/
  android/
    en-US/
      title.txt
      short-description.txt
      full-description.txt
    ja-JP/
      ...
  ios/
    en-US/
      ...
```

## Localization Tips

- Each market has different expectations for tone and style
- Japanese: formal, feature-focused
- German: precise, technical
- Spanish: warm, benefit-focused
- Don't translate app name unless there's a strong local brand reason
- Test that translated text fits within character limits
