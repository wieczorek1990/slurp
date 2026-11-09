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

# Check required dependencies
for cmd in parallel git pbcopy
do
  if ! command -v "$cmd" >/dev/null 2>&1
  then
    echo "Error: '$cmd' is required but not installed."
    exit 1
  fi
done

extensions="$1"
path="$2"
out=$(mktemp)

# Cleanup temp file on exit
trap 'rm -f "$out"' EXIT

echo "Starting copying to clipboard."

cd "${path}" || { echo "Error: Cannot access path '${path}'."; exit 1; }

# Validate git repository
if ! git rev-parse --git-dir >/dev/null 2>&1
then
  echo "Error: '${path}' is not a git repository."
  exit 1
fi

for extension in $extensions
do
  echo "Processing extension: $extension"

  git ls-files -z "*.${extension}" |
  parallel -0 --keep-order \
  'echo "#### Begin: {}"; cat "{}"; echo "#### End: {}"' \
  >> "$out"
done
cat "$out" | pbcopy

echo "Copied to clipboard!"
