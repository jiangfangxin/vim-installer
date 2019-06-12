#!/bin/bash

# Introduce
# This installer help people to install and config vim automaticly on Ubuntu and Mac. 

# Define variables
runningFile=`readlink -f $0`
workDir=`dirname $runningFile`
vimrc=$HOME/.vimrc
vimColorDir=$HOME/.vim/colors
vimPlugDir=$HOME/.vim/autoload
linkVimplugGithub=https://github.com/junegunn/vim-plug.git
linkVimSublimeMonokaiGithub=https://github.com/ErichDonGubler/vim-sublime-monokai.git

# Define functions
# Try to install HomeBrew for Mac
checkAndInstallBrew() {
    if [ ! -x "`which brew`" ]; then
        read -p "Package manager HomeBrew not exits, do you want to install it? [y/n] " choice
        if [ "$choice" == "y" ]; then
            # There always has ruby on mac.
            /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        else
            echo "Install abort due to without HomeBrew, you can install it permaticly later."
            exit
        fi
    fi
}

# Try to install git automaticly
installGit() {
    if [[ "$OSTYPE" == "darwin"* ]]; then   # [[]] is more powerfull test command which support pattern.
        checkAndInstallBrew
        brew install git
    elif [ -x "`which apt`" ]; then
        sudo apt install git
    else
        echo "Automaticly install git failed, you can install it permaticly later."
        exit
    fi
}

# Try to install vim automaticly
installVim() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        checkAndInstallBrew
        brew install vim
    elif [ -x "`which apt`" ]; then
        sudo apt install vim
    else
        echo "Install vim through package manager failed, you can install if permaticly later."
        exit
    fi
}

# Try to install vim color vim-sublime-monokai
installVimColor() {
    if [ -d $workDir/vim-sublime-monokai ]; then
        rm -r $workDir/vim-sublime-monokai
    fi

    git clone $linkVimSublimeMonokaiGithub $workDir/vim-sublime-monokai

    if [ ! -w $vimColorDir ]; then
        mkdir -p $vimColorDir
    fi

    cp $workDir/vim-sublime-monokai/colors/sublimemonokai.vim $vimColorDir/
}

# Try to install vim-plug
installVimplug() {
    if [ -d $workDir/vim-plug ]; then
        rm -r $workDir/vim-plug
    fi
    
    git clone $linkVimplugGithub $workDir/vim-plug  

    if ! [ -w $vimPlugDir ]; then
        mkdir -p $vimPlugDir
    fi

    cp $workDir/vim-plug/plug.vim $vimPlugDir/
}

# Main program
echo "Welcome to vim installer!"
echo "Checking install environment..."

# Check git
if [ ! -x "`which git`" ]; then
    read -p "Git is not exist, try to install it? [y/n] " choice
    if [ "$choice" == "y" ]; then
        installGit
    else
        echo "Install abort due to without git."
        exit
    fi
fi

# Check vim
if [ ! -x "`which vim`" ]
then
    read -p "Vim is not exist, try to install it? [y/n] " choice
    if [ "$choice" == "y" ]; then
        installVim
    else
        echo 'Install abort.'
        exit
    fi
fi

# Merge vim config to one vimrc file
cat $workDir/config/basic.vim > $workDir/vimrc
cat $workDir/config/theme.vim >> $workDir/vimrc
cat $workDir/config/search.vim >> $workDir/vimrc
cat $workDir/config/file.vim >> $workDir/vimrc
cat $workDir/config/netrw.vim >> $workDir/vimrc
cat $workDir/config/fn.vim >> $workDir/vimrc
cat $workDir/config/edit.vim >> $workDir/vimrc
cat $workDir/config/plugs.vim >> $workDir/vimrc
case "$OSTYPE" in
    "darwin"*) cat $workDir/config/macos.vim >> $workDir/vimrc ;; # macOS
    "linux"*)  cat $workDir/config/linux.vim >> $workDir/vimrc ;; # linux
esac

# Check vimrc
if [ -w $vimrc ]; then
    if cmp $workDir/vimrc $vimrc; then
        # Same
        echo 'vimrc already up to date.'
    else
        # Use newer vimrc and backup old one.
        mv $vimrc `dirname $vimrc`/vimrc~`date +%Y%m%d%H%M%S`
        cp $workDir/vimrc $vimrc
    fi
else
    # $HOME/.vimrc not exist.
    cp $workDir/vimrc $vimrc
fi

# Check vim colors
if [[ -d $vimColorDir && -n "`ls $vimColorDir`" ]]; then
    # Has other colers
    tar -czf `dirname $vimColorDir`/colors~`date +%Y%m%d%H%M%S`.tar.gz $vimColorDir
    rm -r $vimColorDir/*
fi
installVimColor

# Check vim-plug
if [ ! -f $vimPlugDir/plug.vim ]; then
    # Install vim-plug
    installVimplug
fi

vim -c PlugClean -c PlugInstall -c qall

