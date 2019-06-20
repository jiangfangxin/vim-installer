# vim-installer

## 摘要

在Mac或者Ubuntu中自动安装Vim和Vim的主题以及Vim插件

## 如何使用

在新的系统中安装和配置Vim，首先使用Git克隆项目到任意目录，或者直接下载项目的zip包到任意目录。

```bash
git clone https://github.com/jiangfangxin/vim-installer.git
```

然后通过命令行进入项目根目录，运行install.sh文件

```bash
cd your_clone_directory/vim-installer
./install.sh
```

vim-installer会自动检测并安装Git，如果Mac系统没有安装Git，会自动安装HomeBrew，并用HomeBrew来帮助用户安装Git。

如果系统中已经安装了Vim，vim-installer会把之前Vim的.vimrc、主题以及插件用tar打包备份，然后再安装新的配置。如果要删除
自动备份的配置使用

```bash
./install.sh -c
```

如果只是想更新一下.vimrc而无需动主题和更新插件，那么直接使用-u命令，这个命令只会把config目录中的.vim配置文件合并到系统
的.vimrc中

```bash
./install.sh -u
```

如果你想编写自己的配置，那么可以在config目录中添加自己的.vim文件，然后在install.sh中加入你写的.vim文件就可以了

