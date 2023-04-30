#!/bin/sh

docker run --rm -ti \
  -v "$(pwd):/workspace/src:ro" \
  -w '/workspace' \
  igotugps-buildenv-2023 bash -i
