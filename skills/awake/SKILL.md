---
name: awake
description: Keep a MacBook running with the lid closed using the awake CLI. Use when a long task (build, download, training, agent run, server) must keep running after the user closes the lid or walks away, or when the user asks to keep the Mac awake, prevent sleep, or check or restore sleep settings.
version: 0.1.0
allowed-tools: Bash(awake:*)
metadata:
  openclaw:
    requires:
      bins:
        - awake
    install:
      - kind: brew
        formula: devxoul/tap/awake
        bins: [awake]
---

# awake

`awake` keeps a MacBook running with the lid closed while the display and keyboard backlight turn off. macOS only.

## Commands

```bash
awake status   # read-only: watcher, lid, sleep and keyboard backlight state
awake on       # sudo: disable system sleep and start the background lid watcher
awake off      # sudo: stop the watcher and re-enable system sleep
```

`awake status` output:

```
watcher  on (pid 12345)    # or: watcher  off
lid      open              # or: closed
sleep    disabled          # or: enabled
kbd      0.412000          # or: n/a
```

## Rules

1. **Check first.** Run `awake status` before `on` or `off`. If the watcher is already on, don't run `awake on` again.
2. **`on` and `off` need sudo.** They run `sudo pmset -a disablesleep`. If sudo needs a password and you have no way to enter it, don't try to work around it. Ask the user to run `awake on` (or `awake off`) in their own terminal.
3. **Always pair `on` with `off`.** Sleep stays disabled system-wide until `awake off` runs, even after the watcher dies or the Mac restarts. When the task that needed `awake` is finished, run `awake off`, or tell the user to run it, unless they asked to keep the Mac awake.
4. **The watcher must outlive your shell.** `awake on` starts the watcher with `nohup` in the background. If your harness kills the whole process group when a command ends, the watcher dies with it. Run `awake status` after `awake on` to confirm `watcher  on`. If it is off, ask the user to run `awake on` themselves.
5. **Mention the side effects** when you turn it on: a closed MacBook keeps working and uses battery, and while the lid is closed and the Mac is offline, `awake` toggles Wi-Fi and tries saved networks.

## Recovery

If `awake status` shows `watcher  off` but `sleep    disabled`, a previous session didn't clean up. Run `awake off` to restore sleep, or ask the user to.
