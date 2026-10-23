#!/bin/sh

name="slurp"
if [ $# -ne 2 ]
then
  echo "Invalid arguments."
  echo "Usage:"
  printf "\t" && echo "${name} EXTENSION PATH"
  exit 1
fi

echo "Starting copying to clipboard."

extension="$1"
path="$2"

cd "${path}" || exit 1
git ls-files "*.${extension}" | \
  parallel --keep-order 'echo "#### Begin: {}"; cat {}; echo "#### End: {}"' | \
  pbcopy

echo "Copied to clipboard!"
