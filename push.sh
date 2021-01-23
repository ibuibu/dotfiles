#!/bin/bash

if [ $# -eq 0 ]; then
  echo "Set commit message via argument."
fi

cp ../.zshrc ./

git add .
git commit -m $1
git push

