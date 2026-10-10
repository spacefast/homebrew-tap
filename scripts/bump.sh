#!/usr/bin/env bash
# Point Formula/spacefast.rb at a spacefast/cli release.
# Usage: scripts/bump.sh [version]   (defaults to the latest release)
set -euo pipefail

repo="${SPACEFAST_CLI_RELEASE_REPO:-spacefast/cli}"
formula="$(cd "$(dirname "$0")/.." && pwd)/Formula/spacefast.rb"

version="${1:-$(gh release view -R "$repo" --json tagName -q .tagName)}"
version="${version#v}"

checksums="$(gh release download "v$version" -R "$repo" -p checksums.txt -O -)"

sha_for() {
  local sha
  sha="$(awk -v n="spacefast-$1.tar.gz" '$2 == n { print $1 }' <<<"$checksums")"
  [[ "$sha" =~ ^[0-9a-f]{64}$ ]] || { echo "missing checksum for $1 in v$version" >&2; exit 1; }
  echo "$sha"
}

# Resolve every checksum before touching the formula; an exit inside $(...) in an
# argument list would not stop the script. Releases before v0.5.0 used a different
# archive layout and are rejected here.
shas=()
for target in darwin-arm64 darwin-x64 linux-arm64 linux-x64; do
  shas+=("$(sha_for "$target")")
done

ruby - "$formula" "$version" "${shas[@]}" <<'RUBY'
path, version, *shas = ARGV
targets = %w[darwin-arm64 darwin-x64 linux-arm64 linux-x64]
src = File.read(path)
src.gsub!(%r{/releases/download/v[^/]+/}, "/releases/download/v#{version}/")
targets.zip(shas).each do |target, sha|
  src.sub!(/(spacefast-#{target}\.tar\.gz"\n\s+sha256 )"[0-9a-f]{64}"/) { %(#{$1}"#{sha}") } or
    abort "could not find #{target} in #{path}"
end
File.write(path, src)
RUBY

echo "Formula/spacefast.rb -> v$version"
