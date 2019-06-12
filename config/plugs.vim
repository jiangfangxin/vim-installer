" Vim-plug，去GitHub下载Vim-plug的.vim文件，放置到~/.vim/autoload/下，Vim-plug安装的插件会放到~/.vim/plugged/下
" 插件状态:PlugStatus
" 安装插件:PlugInstall
" 删除插件:PlugClean
call plug#begin('~/.vim/plugged')
Plug 'terryma/vim-multiple-cursors'     " 像Sublime那样的多光标插件
Plug 'pangloss/vim-javascript'          " Javascript语法支持插件
call plug#end()

" 插件按键映射：插件terryma/vim-multiple-cursors设置Ctrl + i用于全选匹配 
let g:multi_cursor_select_all_word_key = '<C-i>'

" TODO
" √ 1. 让代码复制到vim，以及复制出vim变得简单
" 2. 写一个shell用于一键配置我的自定wim，打包成一个tar.gz的包
" √ 3. 配置好其他的一些常用插件，插件包括；
" √  3.1. 括号等标点符号自动匹配
" √  3.2. 改变cursor形状，insert的时候
" √  3.3. 设置好vim的多光标和多选择模式
" √  3.4. 快速根据文件名搜索当前目录下的文件
" 4. 写一篇vim的配置和使用博客

" BLOG
" 1. vim自带缩进命令
"   1.1. = is an operator (by default, it formats/indents text).
"   1.2. You can format the entire buffer with gg=G.
" 2. vim代码块选着命令
" 	2.1. vi{ visually selects the inner code block around the cursor.
" 	2.2. viw 选择一个词
"	2.3. vip 选择一段代码
"	2.4. vi( 选择一对()中的内容
"	2.4. vi" 选择一对“”中的内容
"	2.5. 同理...
