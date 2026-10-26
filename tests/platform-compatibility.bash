#!/usr/bin/env bash
set -euo pipefail

plugin_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
# shellcheck source=../lib/utils.bash
source "$plugin_dir/lib/utils.bash"

TEST_OS=Linux
TEST_ARCH=x86_64
uname() {
  if [[ "${1:-}" == "-m" ]]; then
    printf '%s\n' "$TEST_ARCH"
  else
    printf '%s\n' "$TEST_OS"
  fi
}

assert_eq() {
  if [[ "$1" != "$2" ]]; then
    printf 'Expected: %s, actual: %s\n' "$2" "$1" >&2
    exit 1
  fi
}

TEST_OS=Linux
assert_eq "$(get_platform quiet)" linux
TEST_OS=Darwin
assert_eq "$(get_platform quiet)" darwin

TEST_ARCH=x86_64
assert_eq "$(get_arch)" x86_64
TEST_ARCH=amd64
assert_eq "$(get_arch)" x86_64
TEST_ARCH=aarch64
assert_eq "$(get_arch)" aarch64

TEST_ARCH=arm64
if (get_arch >/dev/null 2>&1); then
  echo 'arm64 should be rejected with an explicit error' >&2
  exit 1
fi

TEST_ARCH=riscv64
if (get_arch >/dev/null 2>&1); then
  echo 'Unsupported CPU architecture should fail' >&2
  exit 1
fi

TEST_OS=FreeBSD
TEST_ARCH=x86_64
if (get_platform quiet >/dev/null 2>&1); then
  echo 'Unsupported operating system should fail' >&2
  exit 1
fi

echo 'Platform compatibility tests passed.'
