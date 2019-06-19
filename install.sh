#!/bin/bash

# Name
#       install.sh - Install and config vim automaticly on Ubuntu and Mac.
# 
# SYNOPSIS
#       install.sh [-c] [-h|--help] [-u]
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
#       -c
#               Clean all backup.
#
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
quit() {
    cd $startDir
    exit
}

installHomeBrew() {
    if [ ! -x "`which brew`" ]; then
        read -p "Package manager HomeBrew not exits, do you want to install it? [y/n] " choice
        if [ "$choice" == "y" ]; then
            # There always has ruby on mac.
            /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
            echo "HomeBrew installed."
        else
            echo "Install abort due to without HomeBrew, you can install it permaticly later."
            quit
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
                quit
            fi
        else
            echo "Install abort due to without git."
            quit
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
                quit
            fi
        else
            echo 'Install abort due to without vim.'
            quit
        fi
    fi
}

cleanOldBackup() {
    all=0       # If delete all backup.
    prefix=""   # Backup file prefix, like: /home/name/vimrc~, or like: /home/name/.vim/colors~
    suffix=""   # Backup file suffix, like: .tar.gz
    for i in $@; do
        if [[ $i == "-"* ]]; then
            if [ $i == "-a" ]; then
                all=1
            else
                echo "Unkonwn option: $i."
            fi
        else
            if [ -z $prefix ]; then
                prefix=$i
            elif [ -z $suffix ]; then
                suffix=$i
            else
                echo "Unkonwn param: $i."
            fi
        fi
    done

    if [ $all == 1 ]; then
        for f in $prefix*$suffix; do
            rm $f
            echo "Backup file $f be deleted."
        done
    elif [ `ls $prefix*$suffix 2>/dev/null | wc -l` -gt 3 ]; then   # Only delete backup when count more than 3.
        # Delete backup more than 30 days.
        # The date syntax has some diffrent between Ubuntu and Mac.
        if [[ "$OSTYPE" == "darwin"* ]]; then
            lastMonth=`date -v -30d +%Y%m%d%H%M%S`
        else
            lastMonth=`date -d "-30 days" +%Y%m%d%H%M%S`
        fi

        for f in $prefix*$suffix; do
            # Delete path only leave time to compare.
            time=${f/$prefix/}
            time=${time/$suffix/}
            if [ $time -lt $lastMonth ]; then
                rm $f
                echo "Old backup file $f be deleted."
            fi
        done
    fi    
}

installVimrc() {
    # Merge vim config to one vimrc file
    cat config/basic.vim > vimrc
        echo "config/basic.vim > vimrc"
    cat config/theme.vim >> vimrc
        echo "config/theme.vim >> vimrc"
    cat config/search.vim >> vimrc
        echo "config/search.vim >> vimrc"
    cat config/file.vim >> vimrc
        echo "config/file.vim >> vimrc"
    cat config/netrw.vim >> vimrc
        echo "config/netrw.vim >> vimrc"
    cat config/fn.vim >> vimrc
        echo "config/fn.vim >> vimrc"
    cat config/edit.vim >> vimrc
        echo "config/edit.vim >> vimrc"
    cat config/plugin.vim >> vimrc
        echo "config/plugin.vim >> vimrc"
    cat config/mac-keyboard.vim >> vimrc
        echo "config/mac-keyboard.vim >> vimrc"
    case "$OSTYPE" in
        "darwin"*) cat config/macos.vim >> vimrc
                       echo "config/macos.vim >> vimrc" ;; # macOS
        "linux"*)  cat config/linux.vim >> vimrc
                       echo "config/linux.vim >> vimrc" ;; # linux
    esac

    # Check vimrc
    if [ -f $vimrcDir/.vimrc ]; then
        if cmp vimrc $vimrcDir/.vimrc; then
            # Same
            echo "vimrc has no change, no need to update."
        else
            # Use newer vimrc and backup old one.
            mv $vimrcDir/.vimrc $vimrcDir/vimrc~`date +%Y%m%d%H%M%S`
            echo "Old vimrc backuped."
            cp vimrc $vimrcDir/.vimrc
            echo "vimrc updated."
        fi
    else
        # $HOME/.vimrc not exist.
        cp vimrc $vimrcDir/.vimrc
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
            cd $workDir
            echo "Old theme backuped."
            rm -r $vimColorDir/*
        fi
    else
        mkdir -p $vimColorDir
    fi

    if [ -d theme ]; then
        rm -rf theme
    fi

    git clone $themeRepostry theme
    cp theme/$themeFilePath $vimColorDir/
    echo "Theme updated."
    
    cleanOldBackup $vimColorDir~ .tar.gz
}

installPluginManager() {
    if [ -d $vimPluginManagerDir ]; then
        if [ -n "`ls $vimPluginManagerDir`" ]; then
            # Backup old plugin manager
            cd `dirname $vimPluginManagerDir`
            tar -czf $vimPluginManagerDir~`date +%Y%m%d%H%M%S`.tar.gz `basename $vimPluginManagerDir`
            cd $workDir
            echo "Old plugin manager backuped."
            rm -r $vimPluginManagerDir/*
        fi
    else
        mkdir -p $vimPluginManagerDir
    fi

    if [ -d pluginManager ]; then
        rm -rf pluginManager
    fi

    git clone $pluginManagerRepostry pluginManager
    cp pluginManager/$pluginManagerPath $vimPluginManagerDir/
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
usage: install.sh [-c] [-h|--help] [-u]
options:
-c         : Clean all backup.
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
            elif [ $i == "-c" ]; then
                echo "Start clean all backup."
                cleanOldBackup -a $vimrcDir/vimrc~
                cleanOldBackup -a $vimColorDir~ .tar.gz
                cleanOldBackup -a $vimPluginManagerDir~ .tar.gz
                echo "All backup cleaned."
            else
                echo "Unknown option: $i."
            fi
        done
    fi
    quit
}

# Run
main $@
