#!/bin/bash

cp ~/.zshrc ./
cp -r ~/.config/nvim ./.config/
cp ~/Library/Application\ Support/Code/User/settings.json ./.config/Code/User/
cp ~/Library/Application\ Support/Code/User/keybindings.json ./.config/Code/User/
cp ~/Library/Application\ Support/Code/User/tasks.json ./.config/Code/User/
cp -r ~/Library/Application\ Support/Code/User/snippets ./.config/Code/User/
cp ~/.gitignore_global ./
cp -r ~/.command ./

brew bundle dump --force
npm ls -g --depth=0 > ./npm_global.txt
yarn global list --depth=0 > ./yarn_global.txt

code --list-extensions > ./.config/Code/extensions
