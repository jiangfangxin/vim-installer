" ---------- basic.vim ----------
" 基本设置 
set number          " 显示行号
set nocompatible    " 关闭兼容模式

" 语法高亮
syntax on

" 缩进设置
set expandtab       " 用space来替换tab
set tabstop=4       " tab显示为4格的宽度
set shiftwidth=4    " 缩进宽度设置为4个space
set smartindent     " 新增一行时自动缩进

" 支持鼠标，a：表示所有模式，i：insert模式，v：visual模式
set mouse=a

" 插入模式的时候光标光标变为|，其他模式光标保持block
let &t_SI = "\e[6 q"    " \e：表示esc，[6：表示|
let &t_EI = "\e[2 q"    " \e：表示esc，[2：表示block

