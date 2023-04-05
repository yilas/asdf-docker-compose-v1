# Contributing

Testing Locally:

```shell
asdf plugin test <plugin-name> <plugin-url> [--asdf-tool-version <version>] [--asdf-plugin-gitref <git-ref>] [test-command*]

#
asdf plugin test docker-compose-v1 https://github.com/yilas/asdf-docker-compose-v1.git "docker-compose version"
```

Tests are automatically run in GitHub Actions on push and PR.
