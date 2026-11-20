# awake

A single zsh script (`awake`) that keeps a MacBook running with the lid closed. The repo is also its own Homebrew tap (`Formula/awake.rb`) and ships an Agent Skill (`skills/awake/SKILL.md`).

## Pre-commit checks

```sh
zsh -n awake
brew style Formula/awake.rb
```

Don't run `awake on` or `awake off` to test changes without asking: both change the system-wide `disablesleep` setting through sudo.

## Release

Run the **Release** workflow (workflow_dispatch) with a version like `0.2.0` (no `v` prefix). It bumps `version` in `SKILL.md`, tags, creates a GitHub release with generated notes, then points `Formula/awake.rb` at the new tag's tarball and its sha256. Never edit the formula's `url` or `sha256` by hand.

### Version decision

- Patch: bug fixes and doc changes.
- Minor: new commands or behavior.
- Major: changed or removed commands or output format.
