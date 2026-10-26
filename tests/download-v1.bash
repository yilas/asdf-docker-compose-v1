#!/usr/bin/env bash
set -euo pipefail
plugin_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
# shellcheck source=../lib/utils.bash
source "$plugin_dir/lib/utils.bash"

get_platform() { printf '%s' linux; }
get_arch() { printf '%s' x86_64; }
curl() { printf '%s\n' "$*" > "$captured_args"; }

captured_args="$(mktemp)"
trap 'rm -f "$captured_args"' EXIT
download_release "1.29.2" "/tmp/compose-test-download"
expected="https://github.com/docker/compose/releases/download/1.29.2/docker-compose-Linux-x86_64"
grep -Fq -- "$expected" "$captured_args" || {
  echo "Unexpected download URL: $(cat "$captured_args")" >&2
  exit 1
}
echo "Docker Compose V1 download URL: OK"
