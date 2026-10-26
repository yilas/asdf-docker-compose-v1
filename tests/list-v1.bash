#!/usr/bin/env bash
set -euo pipefail
plugin_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
# shellcheck source=../lib/utils.bash
source "$plugin_dir/lib/utils.bash"

list_github_tags() {
  printf '%s\n' 1.28.6 2.0.0 1.29.2 2.40.0 1.29.2-rc1 1.29.1 1.29.2+meta
}
actual="$(list_all_versions)"
expected="$(printf '%s\n' 1.28.6 1.29.2 1.29.1)"
[[ "$actual" == "$expected" ]] || {
  printf 'Expected:\n%s\nActual:\n%s\n' "$expected" "$actual" >&2
  exit 1
}

list_github_tags() { return 42; }
if list_all_versions >/dev/null; then
  echo "Tag retrieval failures must not be swallowed" >&2
  exit 1
fi
echo "Docker Compose V1 tag filtering: OK"
