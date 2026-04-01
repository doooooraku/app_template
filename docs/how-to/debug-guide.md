# Debug Guide

## Debug Session Management

The debug toolkit (`scripts/debug/`) provides structured debugging with automatic artifact collection.

### Starting a Session

```bash
pnpm debug:start           # With screen recording
pnpm debug:start --no-record  # Without recording (faster)
```

This will:

1. Verify device connection
2. Clear logcat buffer
3. Take a "before" screenshot
4. Start logcat collection in background
5. Start screen recording (optional)

### Stopping a Session

```bash
pnpm debug:stop
```

This collects all artifacts into `.debug-sessions/session_YYYYMMDD_HHMMSS/`:

| Artifact        | Description                           |
| --------------- | ------------------------------------- |
| `before.png`    | Screenshot before operations          |
| `after.png`     | Screenshot after operations           |
| `logcat.log`    | Full log during session               |
| `recording.mp4` | Screen recording                      |
| `meminfo.txt`   | Memory usage snapshot                 |
| `summary.md`    | Session summary with extracted errors |

### Checking Status

```bash
pnpm debug:status
```

## Real-time Monitoring

```bash
pnpm monitor
```

The monitor script tracks:

- App process PID
- Crashes and ANRs
- Error-level log messages
- Auto-saves crash logs

## Common Debug Scenarios

### App Crash

1. Start a debug session: `pnpm debug:start`
2. Reproduce the crash
3. Stop the session: `pnpm debug:stop`
4. Check `.debug-sessions/session_*/summary.md` for extracted errors
5. Check `logcat.log` for full stack traces

### Memory Issues

1. Run the app for the suspected duration
2. Stop the session to capture `meminfo.txt`
3. Compare memory usage over time

### WSL2 Specific

If using WSL2 with a physical device:

- The scripts automatically handle `ADB_SERVER_SOCKET` issues
- Use `env -u ADB_SERVER_SOCKET adb devices` to verify connection
- Port forwarding is set up automatically by `dev-start.sh`
