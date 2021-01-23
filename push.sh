#!/bin/bash

if [ $# -eq 0 ]; then
  echo "Set commit message via argument."
  exit 1
fi

cp ../.zshrc ./
cp ../.gitignore_global ./
cp -r ../.command ./

git add .
git commit -m "$@"
git push
