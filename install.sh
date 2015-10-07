#!/bin/sh

ln -fns ~/.vim/vimrc ~/.vimrc
ln -fns ~/.vim/gvimrc ~/.gvimrc

# To add Objective-C support to the Tagbar plugin
brew install ctags --HEAD
