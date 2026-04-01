# Sentry Setup Guide

## Overview

[Sentry](https://sentry.io/) provides real-time crash reporting and error monitoring.
Free tier: 5,000 errors/month (sufficient for early-stage apps).

## Prerequisites

- Sentry account + project created at https://sentry.io
- Sentry DSN (found in Project Settings > Client Keys)

## Installation

```bash
pnpm add @sentry/react-native
```

## Configuration

### 1. Add DSN to `.env`

```env
SENTRY_DSN=https://examplePublicKey@o0.ingest.sentry.io/0
```

### 2. Add to `app.config.ts`

In the `plugins` array:

```ts
[
  '@sentry/react-native/expo',
  {
    organization: process.env.SENTRY_ORG ?? '',
    project: process.env.SENTRY_PROJECT ?? '',
  },
],
```

In the `extra` section:

```ts
sentryDsn: process.env.SENTRY_DSN ?? '',
```

### 3. Initialize in app entry

In `app/_layout.tsx`:

```ts
import * as Sentry from '@sentry/react-native';
import Constants from 'expo-constants';

Sentry.init({
  dsn: Constants.expoConfig?.extra?.sentryDsn ?? '',
  enabled: !__DEV__,
});
```

### 4. EAS Build source maps

Add to `eas.json` build profiles:

```json
"production": {
  "env": {
    "SENTRY_AUTH_TOKEN": "your-auth-token"
  }
}
```

## Verification

1. Build a preview APK
2. Trigger an error (e.g., `throw new Error('Sentry test')`)
3. Check Sentry dashboard for the error event
4. Verify source maps are correctly symbolicated

## Notes

- Sentry is disabled in `__DEV__` mode to avoid noise during development
- For production, store `SENTRY_AUTH_TOKEN` as an EAS Secret, not in `.env`
- Consider adding an Error Boundary component for graceful crash UI
