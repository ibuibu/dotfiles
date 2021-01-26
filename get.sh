#!/bin/bash

cp ~/.zshrc ./
cp ~/Library/Application\ Support/Code/User/settings.json ./.config/Code/User/
cp ~/Library/Application\ Support/Code/User/keybindings.json ./.config/Code/User/
cp ~/Library/Application\ Support/Code/User/tasks.json ./.config/Code/User/
cp -r ~/Library/Application\ Support/Code/User/snippets ./.config/Code/User/
cp ~/.gitignore_global ./
cp -r ~/.command ./

code --list-extensions > ./.config/Code/extensions
