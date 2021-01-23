#!/bin/bash

if [ $# -eq 0 ]; then
  echo "Set commit message via argument."
  exit 1
fi

cp ../.zshrc ./
cp ~/Library/Application\ Support/Code/User/settings.json ./.config/Code/User/
cp ~/Library/Application\ Support/Code/User/keybindings.json ./.config/Code/User/
cp ~/Library/Application\ Support/Code/User/tasks.json ./.config/Code/User/
cp -r ~/Library/Application\ Support/Code/User/snippets ./.config/Code/User/
cp ../.gitignore_global ./
cp -r ../.command ./

git add .
git commit -m "$@"
git push
