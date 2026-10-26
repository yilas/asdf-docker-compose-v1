<div align="center">

# asdf-docker-compose-v1 [![Build](https://github.com/yilas/asdf-docker-compose-v1/actions/workflows/build.yml/badge.svg)](https://github.com/kompiro/asdf-docker-compose-v1/actions/workflows/build.yml) [![Lint](https://github.com/yilas/asdf-docker-compose-v1/actions/workflows/lint.yml/badge.svg)](https://github.com/yilas/asdf-docker-compose-v1/actions/workflows/lint.yml)


[asdf-docker-compose-v1](https://github.com/yilas/asdf-docker-compose-v1) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Why?](#why)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

- `bash`, `curl`, `tar`: generic POSIX utilities.
- `SOME_ENV_VAR`: set this environment variable in your shell config to load the correct version of tool x.

## Supported platforms

This plugin installs the **standalone Docker Compose V1** executable (not the Docker Compose V2 CLI plugin). The following published artifacts were verified against upstream releases `1.25.5`, `1.28.6`, and `1.29.2`:

| Host OS | Architecture | Status | Official asset example (1.29.2) |
| --- | --- | --- | --- |
| Linux | x86_64 / amd64 | Supported | `docker-compose-Linux-x86_64` |
| macOS (Darwin) | x86_64 (Intel) | Supported | `docker-compose-Darwin-x86_64` |
| Linux | aarch64 / arm64 | No official artifact verified | Not available in releases checked |
| macOS | arm64 (Apple Silicon) | No native V1 artifact verified | Not available in releases checked |
| Other OS/architectures | Any | Not supported | — |

These checks describe upstream **binary availability**, not end-to-end execution on every host. Ubuntu x86_64 is covered by the plugin CI; macOS Intel support is based on published upstream artifacts unless independently tested. Do not assume that the absence of an artifact in the checked releases proves absence from every historical release. The installer provides an explicit error for unsupported architectures; it does not silently substitute a V2 binary or emulate another architecture.

# Install

Plugin:

```shell
asdf plugin add docker-compose-v1
# or
asdf plugin add docker-compose-v1 https://github.com/yilas/asdf-docker-compose-v1.git
```

docker-compose-v1:

```shell
# Show all installable versions
asdf list-all docker-compose-v1

# Install specific version
asdf install docker-compose-v1 latest

# Set a version globally (on your ~/.tool-versions file)
asdf global docker-compose-v1 latest

# Now docker-compose-v1 commands are available
docker-compose version
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/yilas/asdf-docker-compose-v1/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Yann ILAS](https://github.com/yilas/)
