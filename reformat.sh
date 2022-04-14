#!/bin/sh -ue

# reformat shell scripts
find . -name \*.sh \
  -exec shfmt -i 2 -w {} \+

# reformat python scripts
find . -name \*.py \
  -exec black {} \+ \
  -exec isort {} \+
