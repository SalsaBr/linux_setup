#!/bin/bash
# Simple setup.sh for configuring Ubuntu 12.04 LTS EC2 instance
# for headless setup. 

# Install nvm: node-version manager
# https://github.com/creationix/nvm
sudo apt-get install -y git-core
curl https://raw.github.com/creationix/nvm/master/install.sh | sh

# Load nvm and install latest production node
source $HOME/.nvm/nvm.sh
nvm install v0.10.12
nvm use v0.10.12

# Install jshint to allow checking of JS code within emacs
# http://jshint.com/
npm install -g jshint

# Install rlwrap to provide libreadline features with node
# See: http://nodejs.org/api/repl.html#repl_repl
sudo apt-get install -y rlwrap

sudo apt-get install vim

sudo apt-get install curl

sudo apt-get install tmux

# git pull and install dotfiles as well
cd $HOME
if [ -d ./dotfiles/ ]; then
    mv dotfiles dotfiles.old
fi

git clone https://github.com/startup-class/dotfiles.git
ln -sb dotfiles/.screenrc .
ln -sb dotfiles/.bash_profile .
ln -sb dotfiles/.bashrc .
ln -sb dotfiles/.bashrc_custom .

mkdir -p ~/.vim/syntax
mkdir -p ~/.vim/indent

cp ./syntax/* ~/.vim/syntax
cp ./indent/* ~/.vim/indent
cp .vimrc ~/.vim/

mkdir -p ~/.vim/autoload ~/.vim/bundle; \
curl -Sso ~/.vim/autoload/pathogen.vim \
    https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim


cd ~/.vim/bundle

curl -Sso ~/.vim/bundle/npm.vim.zip \
    http://www.vim.org/scripts/download_script.php?src_id=20497
unzip -f npm.vim.zip
rm -f npm.vim.zip

curl -Sso taglist.zip http://vim.sourceforge.net/scripts/download_script.php?src_id=19574
unzip -f taglist.zip
rm -f taglist.zip

svn checkout http://conque.googlecode.com/svn/trunk/plugin ./

git clone git://github.com/tpope/vim-fugitive.git
git clone git://github.com/tpope/vim-rails.git
git clone git://github.com/tpope/vim-bundler.git
git clone git://github.com/tpope/vim-dispatch.git
git clone git://github.com/tpope/vim-surround.git
git clone git://github.com/tpope/vim-tbone.git
git clone git://github.com/ervandew/screen.git
git clone git://github.com/Shutnik/jshint2.vim.git
git clone git://github.com/hdima/python-syntax.git

git clone git://github.com/Rip-Rip/clang_complete.git clang
mv clang/plugin/*.* ./
rm -rf clang

git clone git://github.com/ervandew/supertab.git supertab
mv supertab/plugin/*.* ./
rm -rf supertab

git clone git://github.com/vim-scripts/IndentAnything.git indentAnything
mv indentAnything/plugin/*.* ./
mv indentAnything/indent/*.* ~/.vim/indent/
rm -rf indentAnything

git clone git://github.com/vim-scripts/c.vim.git cvim
mv -f cvim/* ~/.vim/
rm -rf cvim

