#!/bin/sh

git ls-files '*.py' | \
  parallel --keep-order 'echo "#### Begin: {}"; cat {}; echo "#### End: {}"' | \
  pbcopy

echo "Copied to clipboard!"
