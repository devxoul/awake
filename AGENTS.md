# awake

A single zsh script (`awake`) that keeps a MacBook running with the lid closed. It ships an Agent Skill (`skills/awake/SKILL.md`). The Homebrew formula lives in [devxoul/homebrew-tap](https://github.com/devxoul/homebrew-tap) (`Formula/awake.rb`), installed with `brew install devxoul/tap/awake`.

## Pre-commit checks

```sh
zsh -n awake
```

Don't run `awake on` or `awake off` to test changes without asking: both change the system-wide `disablesleep` setting through sudo.

## Release

Run the **Release** workflow (workflow_dispatch) with a version like `0.2.0` (no `v` prefix). It bumps `version` in `SKILL.md`, tags, creates a GitHub release with generated notes, then commits the new tag's tarball url and sha256 to `Formula/awake.rb` in devxoul/homebrew-tap. Pushing to the tap uses the `HOMEBREW_TAP_TOKEN` secret (a fine-grained token with Contents read/write on devxoul/homebrew-tap). Never edit the formula's `url` or `sha256` by hand.

Edit the formula in the tap repo directly only when something other than the version changes: caveats, dependencies, install steps or the test.

### Version decision

- Patch: bug fixes and doc changes.
- Minor: new commands or behavior.
- Major: changed or removed commands or output format.
