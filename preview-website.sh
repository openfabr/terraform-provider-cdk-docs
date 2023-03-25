#!/usr/bin/env fish
# the entry point is `mkdocs serve` @see https://www.mkdocs.org/user-guide/cli/#mkdocs-serve
# `/docs` is the default path for the documentation
# `--dirtyreload` is used to only rebuild pages that have changed in development mode.
docker run --rm -it -p 8000:8000 -v $PWD:/docs squidfunk/mkdocs-material serve --dev-addr="0.0.0.0:8000" --no-livereload --dirtyreload