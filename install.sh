#!/bin/bash

# Name
#       install.sh - Install and config vim automaticly on Ubuntu and Mac.
# 
# SYNOPSIS
#       install.sh [-h|--help] [-u]
# 
# DESCRIPTION
#       install.sh is a bash shell which can help people install and config vim automaticly on Ubuntu and Mac.
#       This installer will use git to fetch vim themes and plugins from github. If git not installed before,
#       it will try to install git by apt (for Ubuntu) or brew (for Mac). If brew not found on Mac, this installer
#       will try to install it after get your permission.
#
#       The default theme is ErichDonGubler/vim-sublime-monokai. The default plugin manager is junegunn/vim-plug.
#
# COMMAND LINE OPTIONS
#       -h, --help
#               Prints the usage for the interpreter executable and exits.
#
#       -u      Only update the ~/.vimrc
#
# AUTHOR
#       jiangfangxin
#
# REPOSITORY
#       https://github.com/jiangfangxin/vim-installer

# Variables
startDir=$PWD
cd `dirname $0`
workDir=$PWD
cd $startDir

vimrcDir=$HOME
vimColorDir=$HOME/.vim/colors
vimPluginManagerDir=$HOME/.vim/autoload

# Theme
themeRepostry=https://github.com/ErichDonGubler/vim-sublime-monokai.git
themeFilePath=colors/sublimemonokai.vim

# Plugin Manager
pluginManagerRepostry=https://github.com/junegunn/vim-plug.git
pluginManagerPath=plug.vim

# Functions
installHomeBrew() {
    if [ ! -x "`which brew`" ]; then
        read -p "Package manager HomeBrew not exits, do you want to install it? [y/n] " choice
        if [ "$choice" == "y" ]; then
            # There always has ruby on mac.
            /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
            echo "HomeBrew installed."
        else
            echo "Install abort due to without HomeBrew, you can install it permaticly later."
            exit
        fi
    fi
}

installGit() {
    if [ ! -x "`which git`" ]; then
        read -p "Git is not exist, try to install it? [y/n] " choice
        if [ "$choice" == "y" ]; then
            if [[ "$OSTYPE" == "darwin"* ]]; then   # [[]] is more powerfull test command which support pattern.
                installHomeBrew
                brew install git
                echo "Git installed."
            elif [ -x "`which apt`" ]; then
                sudo apt install git
            else
                echo "Install git through package manager failed, you can install it manually later."
                exit
            fi
        else
            echo "Install abort due to without git."
            exit
        fi
    fi
}

installVim() {
    if [ ! -x "`which vim`" ]; then
        read -p "Vim is not exist, try to install it? [y/n] " choice
        if [ "$choice" == "y" ]; then
            if [[ "$OSTYPE" == "darwin"* ]]; then
                installHomeBrew
                brew install vim
                echo "Vim installed."
            elif [ -x "`which apt`" ]; then
                sudo apt install vim
                echo "Vim installed."
            else
                echo "Install vim through package manager failed, you can install if manually later."
                exit
            fi
        else
            echo 'Install abort due to without vim.'
            exit
        fi
    fi
}

cleanOldBackup() {
    # $1 like: /home/name/vimrc~
    # or like: /home/name/.vim/colors~
    # $2 like: .tar.gz
    if [ `ls $1*$2 2>/dev/null | wc -l` -gt 3 ]; then
        # Delete backup more than 30 days.
        lastMonth=`date -d "-30 days" +%Y%m%d%H%M%S`
        for f in $1*$2; do
            # Delete path only leave time to compare.
            time=${f/$1/}
            if [ -n $2 ]; then
                time=${time/$2/}
            fi
            if [ $time -lt $lastMonth ]; then
                rm $f
                echo "Old backup file $f be deleted."
            fi
        done
    fi    
}

installVimrc() {
    # Merge vim config to one vimrc file
    cat $workDir/config/basic.vim > $workDir/vimrc
    echo "config/basic.vim > vimrc"
    cat $workDir/config/theme.vim >> $workDir/vimrc
    echo "config/theme.vim >> vimrc"
    cat $workDir/config/search.vim >> $workDir/vimrc
    echo "config/search.vim >> vimrc"
    cat $workDir/config/file.vim >> $workDir/vimrc
    echo "config/file.vim >> vimrc"
    cat $workDir/config/netrw.vim >> $workDir/vimrc
    echo "config/netrw.vim >> vimrc"
    cat $workDir/config/fn.vim >> $workDir/vimrc
    echo "config/fn.vim >> vimrc"
    cat $workDir/config/edit.vim >> $workDir/vimrc
    echo "config/edit.vim >> vimrc"
    cat $workDir/config/plugin.vim >> $workDir/vimrc
    echo "config/plugin.vim >> vimrc"
    case "$OSTYPE" in
        "darwin"*) cat $workDir/config/macos.vim >> $workDir/vimrc
                   echo "config/macos.vim >> vimrc" ;; # macOS
        "linux"*)  cat $workDir/config/linux.vim >> $workDir/vimrc
                   echo "config/linux.vim >> vimrc" ;; # linux
    esac

    # Check vimrc
    if [ -f $vimrcDir/.vimrc ]; then
        if cmp $workDir/vimrc $vimrcDir/.vimrc; then
            # Same
            echo "vimrc has no change, no need to update."
        else
            # Use newer vimrc and backup old one.
            mv $vimrcDir/.vimrc $vimrcDir/vimrc~`date +%Y%m%d%H%M%S`
            echo "Old vimrc backuped."
            cp $workDir/vimrc $vimrcDir/.vimrc
            echo "vimrc updated."
        fi
    else
        # $HOME/.vimrc not exist.
        cp $workDir/vimrc $vimrcDir/.vimrc
        echo "vimrc updated."
    fi

    # Delete old backup
    cleanOldBackup $vimrcDir/vimrc~
}

installTheme() {
    # Check vim colors
    if [ -d $vimColorDir ]; then
        if [ -n "`ls $vimColorDir`" ]; then
            # Has other colers
            cd `dirname $vimColorDir`
            tar -czf $vimColorDir~`date +%Y%m%d%H%M%S`.tar.gz `basename $vimColorDir`
            cd $startDir
            echo "Old theme backuped."
            rm -r $vimColorDir/*
        fi
    else
        mkdir -p $vimColorDir
    fi

    if [ -d $workDir/theme ]; then
        rm -rf $workDir/theme
    fi

    git clone $themeRepostry $workDir/theme
    cp $workDir/theme/$themeFilePath $vimColorDir/
    echo "Theme updated."
    
    cleanOldBackup $vimColorDir~ .tar.gz
}

installPluginManager() {
    if [ -d $vimPluginManagerDir ]; then
        if [ -n "`ls $vimPluginManagerDir`" ]; then
            # Backup old plugin manager
            cd `dirname $vimPluginManagerDir`
            tar -czf $vimPluginManagerDir~`date +%Y%m%d%H%M%S`.tar.gz `basename $vimPluginManagerDir`
            cd $startDir
            echo "Old plugin manager backuped."
            rm -r $vimPluginManagerDir/*
        fi
    else
        mkdir -p $vimPluginManagerDir
    fi

    if [ -d $workDir/pluginManager ]; then
        rm -rf $workDir/pluginManager
    fi

    git clone $pluginManagerRepostry $workDir/pluginManager
    cp $workDir/pluginManager/$pluginManagerPath $vimPluginManagerDir/
    echo "Plugin manager updated."

    cleanOldBackup $vimPluginManagerDir~ .tar.gz
}

installPlugins() {
    echo "Start install plugins..."
    vim -c PlugClean -c PlugInstall -c qall
    echo "Plugin installed."
}

echoHelp() {
    cat << EOF
usage: install.sh [-h|--help] [-u]
options:
-h, --help : Show usage an options.
-u         : Only combine and update vimrc.
EOF
}

# Main
main() {
    if [ $# == 0 ]; then
        echo "Start vim-installer."
        echo "Checking install environment..."
        installGit
        installVim
        installVimrc
        installTheme
        installPluginManager
        installPlugins
        echo "Vim installed, all configured."
    else
        for i in $@; do
            if [[ $i == "-h" || $i == "--help" ]]; then
                echoHelp
            elif [ $i == "-u" ]; then
                echo "Start update vimrc."
                installVimrc
            else
                echo "No command option $i."
            fi
        done
    fi
}

# Run
main $@
