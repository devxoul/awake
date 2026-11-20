# awake

Keep your MacBook running with the lid closed, and let the screen go dark.

`awake` is a small zsh script for running long jobs (builds, downloads, AI agents, servers) on a MacBook with the lid shut and no external display, power adapter or keyboard attached.

- **Lid open**: the display never idles.
- **Lid closed**: the display and keyboard backlight turn off, but the Mac keeps running.
- **Lid reopened**: the keyboard backlight returns to its previous level.
- **Lid closed and offline**: Wi-Fi is power-cycled so macOS rescans and rejoins a known network. If that fails, each preferred network is tried in turn. Checks back off from 30 seconds to 5 minutes while no known network is in range.

## Installation

### Homebrew

```bash
brew install devxoul/tap/awake
```

### Manually

```bash
sudo mkdir -p /usr/local/bin
sudo curl -fsSL https://raw.githubusercontent.com/devxoul/awake/main/awake -o /usr/local/bin/awake
sudo chmod +x /usr/local/bin/awake
```

## Usage

```bash
awake on       # disable sleep and start the lid watcher (asks for sudo)
awake off      # stop the watcher and restore sleep (asks for sudo)
awake status   # show the current state (default)
```

```console
$ awake status
watcher  on (pid 12345)
lid      open
sleep    disabled
kbd      0.412000
```

## How it works

- `sudo pmset -a disablesleep 1` keeps the machine running when the lid closes. This is the only global setting `awake` changes, and `awake off` restores it.
- A background watcher polls the lid state (`ioreg`) every 2 seconds. While the lid is open, it holds a `caffeinate -d` assertion. When the lid closes, it releases the assertion and runs `pmset displaysleepnow`.
- The keyboard backlight is controlled through CoreBrightness, a private macOS framework with no public CLI. On first use, `awake` compiles a ~20-line Objective-C helper with `clang` into `$TMPDIR`. Without `clang` (install it with `xcode-select --install`), everything else still works and the backlight is left alone.
- Connectivity is checked against `http://captive.apple.com/hotspot-detect.html`.

## Caveats

- **Sleep stays disabled until you run `awake off`.** If the watcher is killed or the Mac restarts, `disablesleep` is still set. Run `awake off`, or `sudo pmset -a disablesleep 0`, to restore normal sleep.
- **Heat and battery.** A closed MacBook that keeps working gets warm and drains its battery. Don't leave it in a bag.
- **Wi-Fi gets toggled.** While the lid is closed and the Mac is offline, `awake` turns Wi-Fi off and on and tries your saved networks.
- **Private API.** The keyboard backlight helper uses an undocumented API that may break in any macOS update.
- Requires macOS on a MacBook and zsh (the macOS default shell).

## Agent Skills

`awake` ships an [Agent Skill](https://agentskills.io/) so AI agents can keep your Mac awake during long tasks.

```bash
npx skills add devxoul/awake
```

## License

[MIT](LICENSE)
