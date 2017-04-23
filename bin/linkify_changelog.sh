#!/bin/bash

if [ ! -f CHANGELOG.md ]; then
  echo "CHANGELOG.md not in current directory."
  exit 1
fi

sed -i -E 's/(\(|\s)([0-9a-f]{5,40})(,|\))/\1\[\2\]\(https:\/\/github.com\/laCour\/slack-night-mode\/commit\/\2\)\3/g' CHANGELOG.md
sed -i -E 's/(\(|\s)#([0-9]+)(,|\))/\1\[#\2\]\(https:\/\/github.com\/laCour\/slack-night-mode\/issues\/\2\)\3/g' CHANGELOG.md
