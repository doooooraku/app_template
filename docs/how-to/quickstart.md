# Quick Start Guide

## Prerequisites

- Node.js >= 20 (recommend using nvm)
- pnpm (`npm install -g pnpm`)
- Android Studio (for Android development)
- Xcode (for iOS development, macOS only)
- EAS CLI (`npm install -g eas-cli`)

## Initial Setup

```bash
# 1. Clone and enter the project
git clone <your-repo-url>
cd <your-project>

# 2. Install dependencies
pnpm install

# 3. Copy environment file
cp .env.example .env
# Edit .env with your API keys

# 4. Verify everything works
pnpm verify
```

## Development Workflow

### Android (Physical Device)

```bash
# One-command startup (checks ADB, sets up port forwarding, starts Metro)
pnpm dev:android

# Or manually:
adb devices                          # Verify device is connected
adb reverse tcp:8081 tcp:8081       # Port forwarding
pnpm dev                            # Start Metro
```

### Android (Emulator)

```bash
pnpm dev
# Press 'a' in Metro to open on Android emulator
```

### iOS (Simulator, macOS only)

```bash
pnpm dev
# Press 'i' in Metro to open on iOS simulator
```

## Building

### Development Build (for dev-client)

```bash
# Local build
eas build -p android --profile development --local

# Cloud build
eas build -p android --profile development
```

### Preview Build (for testing)

```bash
eas build -p android --profile preview
```

### Production Build

```bash
eas build -p android --profile production
```

## Debugging

```bash
# Start a debug session (captures logs, screenshots, recordings)
pnpm debug:start

# ... operate the app ...

# Stop and collect artifacts
pnpm debug:stop

# Real-time crash monitoring
pnpm monitor
```

## Testing

```bash
# Unit tests
pnpm test

# E2E tests (requires built APK + emulator/device)
pnpm test:e2e
```
