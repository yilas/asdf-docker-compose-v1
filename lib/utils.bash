#!/usr/bin/env bash

set -euo pipefail

GH_REPO="https://github.com/docker/compose"
TOOL_NAME="docker-compose"
TOOL_TEST="docker-compose version"

fail() {
  echo -e "asdf-$TOOL_NAME: $*"
  exit 1
}

curl_opts=(-fsSL)

# NOTE: You might want to remove this if docker-compose-v1 is not hosted on GitHub releases.
if [ -n "${GITHUB_API_TOKEN:-}" ]; then
  curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

sort_versions() {
  sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
    LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_github_tags() {
  git ls-remote --tags --refs "$GH_REPO" |
    grep -o 'refs/tags/.*' | cut -d/ -f3- |
    sed 's/^v//' # NOTE: You might want to adapt this sed to remove non-version strings from tags
}

list_all_versions() {
  # This plugin intentionally supports only Docker Compose 1.x stable releases.
  list_github_tags | awk '/^1\.[0-9]+\.[0-9]+$/'
}

get_platform() {
  local silent=${1:-}
  local platform=""

  platform="$(uname)"

  case "$platform" in
  Linux | Darwin)
    [ -z "$silent" ] && msg "Platform '${platform}' supported!"
    platform=$(echo ${platform} | tr '[:upper:]' '[:lower:]')
    ;;
  *)
    fail "Platform '${platform}' not supported!"
    ;;
  esac

  echo -n "$platform"
}

msg() {
  echo -e "\033[32m$1\033[39m" >&2
}

err() {
  echo -e "\033[31m$1\033[39m" >&2
}

get_arch() {
  local arch=""

  case "$(uname -m)" in
  x86_64 | amd64) arch="x86_64" ;;
  aarch64 | arm64)
    fail "Architecture $(uname -m) has no official Docker Compose V1 binary for Linux/macOS in verified releases (1.25.5, 1.28.6, 1.29.2). Use a supported x86_64 system or manage an alternate build separately."
    ;;
  *)
    fail "Architecture '$(uname -m)' not supported for Docker Compose V1 (supported: x86_64)."
    ;;
  esac

  echo -n $arch
}

download_release() {
  local version filename url release_platform platform arch
  version="$1"
  filename="$2"
  platform=$(get_platform)
  arch=$(get_arch)

  # Docker Compose V1 release assets use bare version tags and capitalized OS.
  case "$platform" in
  linux) release_platform="Linux" ;;
  darwin) release_platform="Darwin" ;;
  *) fail "Platform '$platform' not supported!" ;;
  esac
  url="$GH_REPO/releases/download/${version}/docker-compose-${release_platform}-${arch}"

  echo "* Downloading $TOOL_NAME release $version..."
  curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"
}

install_version() {
  local install_type="$1"
  local version="$2"
  local install_path="$3"

  if [ "$install_type" != "version" ]; then
    fail "asdf-$TOOL_NAME supports release installs only"
  fi

  (
    mkdir -p "$install_path"
    cp -r "$ASDF_DOWNLOAD_PATH"/* "$install_path"

    local tool_cmd
    tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"
    test -x "$install_path/bin/$tool_cmd" || fail "Expected $install_path/bin/$tool_cmd to be executable."

    msg "$TOOL_NAME $version installation was successful!"
  ) || (
    rm -rf "$install_path"
    fail "An error ocurred while installing $TOOL_NAME $version."
  )
}
