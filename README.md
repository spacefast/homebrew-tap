# Spacefast Homebrew tap

Homebrew formula for the [Spacefast CLI](https://spacefast.com) (`spacefast` / `sf`).

## Install

```bash
brew install spacefast/tap/spacefast
```

or

```bash
brew tap spacefast/tap
brew install spacefast
```

Both `spacefast` and `sf` end up on your `PATH`. Upgrade with `brew upgrade spacefast`.

Supported: macOS (Apple Silicon, Intel) and Linux (arm64, x64).

## How it works

The formula installs the prebuilt release archives published at
[spacefast/cli releases](https://github.com/spacefast/cli/releases). Nothing is built
from source. The executable and its `lib/` payload live in `libexec`, with `bin/spacefast`
and `bin/sf` symlinked to it.

## Releasing a new version

After a `spacefast/cli` release is published:

```bash
scripts/bump.sh            # latest release
scripts/bump.sh 0.6.0      # or a specific version
```

The script reads the release's `checksums.txt` and rewrites the four release URLs and
checksums in `Formula/spacefast.rb`. Commit and push; CI installs and tests the formula
on macOS (arm64 + Intel) and Linux.
