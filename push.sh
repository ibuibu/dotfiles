#!/bin/bash

if [ $# -eq 0 ]; then
  echo "Set commit message via argument."
  exit 1
fi

cp ../.zshrc ./

git add .
git commit -m "$@"
git push
