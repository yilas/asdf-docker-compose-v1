<div align="center">

# asdf-docker-compose-v1 [![Build](https://github.com/yilas/asdf-docker-compose-v1/actions/workflows/build.yml/badge.svg)](https://github.com/kompiro/asdf-docker-compose-v1/actions/workflows/build.yml) [![Lint](https://github.com/kompiro/asdf-docker-compose-v1/actions/workflows/lint.yml/badge.svg)](https://github.com/kompiro/asdf-docker-compose-v1/actions/workflows/lint.yml)


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

See [LICENSE](LICENSE) © [Hiroki Kondo](https://github.com/yilas/)
