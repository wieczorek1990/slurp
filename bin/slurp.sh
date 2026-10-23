#!/bin/sh

name="slurp"
if [ $# -ne 1 ]
then
  echo "Invalid extension."
  echo "Usage:"
  printf "\t" && echo "${name} EXTENSION"
  exit 1
fi

echo "Starting copying to clipboard."

extension="$1"

git ls-files "*.${extension}" | \
  parallel --keep-order 'echo "#### Begin: {}"; cat {}; echo "#### End: {}"' | \
  pbcopy

echo "Copied to clipboard!"
