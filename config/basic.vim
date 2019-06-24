" ---------- basic.vim ----------
" 行号设置 
" 参考：[Vim’s absolute, relative and hybrid line numbers](https://jeffkreeftmeijer.com/vim-number/)
set number relativenumber   " 显示行号，相对光标的行号

" 聚焦的窗口显示相对行号，非聚焦的窗口显示绝对行号
" normal模式显示相对行号，insert模式显示绝对行号
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

set nocompatible    " 关闭兼容模式
set encoding=utf-8  " 设置文件的编码为utf-8

" 语法高亮
syntax on

" 缩进设置
set expandtab       " 用space来替换tab
set tabstop=4       " tab显示为4格的宽度
set shiftwidth=4    " 缩进宽度设置为4个space
set smartindent     " 新增一行时自动缩进

" 支持鼠标，a：表示所有模式，i：insert模式，v：visual模式
set mouse=a

" 插入模式的时候光标光标变为|，其他模式光标保持▉
let &t_SI = "\e[6 q"    " \e：表示esc，[6：表示|
let &t_EI = "\e[2 q"    " \e：表示esc，[2：表示▉

