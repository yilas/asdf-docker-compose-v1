#!/usr/bin/env bash
set -euo pipefail
plugin_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
# shellcheck source=../lib/utils.bash
source "$plugin_dir/lib/utils.bash"

get_platform() { printf '%s' "$TEST_PLATFORM"; }
get_arch() { printf '%s' 'x86_64'; }
curl() {
  local arg
  for arg in "$@"; do
    case "$arg" in
      https://*) printf '%s' "$arg" >"$CAPTURE_FILE" ;;
    esac
  done
}
CAPTURE_FILE="$(mktemp)"
trap 'rm -f "$CAPTURE_FILE"' EXIT
for TEST_PLATFORM in linux darwin; do
  download_release "1.29.2" "/tmp/docker-compose-test-placeholder"
  case "$TEST_PLATFORM" in linux) os=Linux ;; darwin) os=Darwin ;; esac
  expected="https://github.com/docker/compose/releases/download/1.29.2/docker-compose-${os}-x86_64"
  actual="$(cat "$CAPTURE_FILE")"
  if [[ "$actual" != "$expected" ]]; then
    printf 'Expected: %s\nActual: %s\n' "$expected" "$actual" >&2
    exit 1
  fi
done
echo "Docker Compose V1 release URL tests passed."
