#!/usr/bin/env bash
set -euo pipefail
plugin_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
# shellcheck source=../lib/utils.bash
source "$plugin_dir/lib/utils.bash"

list_github_tags() {
  printf '%s\n' 1.28.6 1.29.1 1.29.2 2.0.0 2.40.0 '1.29.2-rc1' 'v1.29.2' 'not-a-version'
}
expected="$(printf '%s\n' 1.28.6 1.29.1 1.29.2)"
actual="$(list_all_versions)"
if [[ "$actual" != "$expected" ]]; then
  printf 'Expected:\n%s\nActual:\n%s\n' "$expected" "$actual" >&2
  exit 1
fi
echo "Docker Compose V1 version filter tests passed."
