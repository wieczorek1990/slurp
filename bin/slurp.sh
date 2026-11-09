#!/bin/sh
# Swallower of code.

name="slurp"
if [ $# -ne 2 ]
then
  echo "Invalid arguments."
  echo "Usage:"
  printf "\t" && echo "${name} EXTENSIONS PATH"
  exit 1
fi

extensions="$1"
path="$2"
out="/tmp/LUMO"

echo "Starting copying to clipboard."

rm -f "$out"
touch "$out"

cd "${path}" || exit 1
for extension in $extensions
do
  echo "Processing extension: $extension"

  git ls-files "*.${extension}" |
  parallel --keep-order \
  'echo "#### Begin: {}"; cat {}; echo "#### End: {}"' \
  >> "$out"
done
cat "$out" | pbcopy

echo "Copied to clipboard!"
