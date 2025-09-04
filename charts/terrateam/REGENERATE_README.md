# Regenerating README from values.yaml

From within `charts/terrateam`, run the following Docker command. It will start a `jnorwood/helm-docs` container and parse the contents of the current working directory, outputting a new `README.md`.
```shell
docker run --rm --volume "$(pwd):/helm-docs" -u $(id -u) jnorwood/helm-docs:latest
```
