" ---------- basic.vim ----------
" vim中使用&来查看一个配置的值，如：&number
" 查看当前绑定快捷键的命令：verbose map {key}
" 引导键设置为空格键
let mapleader = "\<Space>"

" 行号设置 
" 参考：[Vim’s absolute, relative and hybrid line numbers](https://jeffkreeftmeijer.com/vim-number/)
set number relativenumber   " 显示行号，相对光标的行号

" 切换显示行号
" number后面的!表示toggle的意思
nnoremap <leader>fn :set number! relativenumber!<CR>
vnoremap <leader>fn <ESC>:set number! relativenumber!<CR>gv

" 聚焦的窗口显示相对行号，非聚焦的窗口显示绝对行号
" normal模式显示相对行号，insert模式显示绝对行号
" 这段代码在一些第三方窗口里面会出现不兼容的情况，暂时禁用一下
" augroup jiang_numbertoggle
"   autocmd!
"   autocmd BufEnter,FocusGained,InsertLeave * set number | set relativenumber
"   autocmd BufLeave,FocusLost,InsertEnter   * set number | set norelativenumber
" augroup END

" 缩进设置
" set expandtab     " 用space来替换tab
set tabstop=4       " tab显示为4格的宽度
set shiftwidth=4    " 缩进宽度设置为4个space
set smartindent     " 新增一行时自动缩进

" 支持鼠标，a：表示所有模式，i：insert模式，v：visual模式
set mouse=a
" 鼠标右键为弹出菜单, 该模式下Shift+左键是扩展选择区域
set mousemodel=popup

" F7：切换paste粘贴模式，insert模式下从外部复制代码就不会改变代码原格式
set pastetoggle=<F7>

" 在insert模式下连续按jj/jk/jl可以立即回到normal模式
" `^：回到上一次insert的位置
inoremap jj <ESC>`^
inoremap jk <ESC>`^
inoremap jl <ESC>`^

" 切换开启行高亮显示
nnoremap <leader>hl :set cursorline!<CR>
vnoremap <leader>hl <ESC>:set cursorline!<CR>gv

" 切换开启列高亮显示，用于对齐
nnoremap <leader>hc :set cursorcolumn!<CR>
vnoremap <leader>hc <ESC>:set cursorcolumn!<CR>gv

" 选择给定行数，因为默认的V选择在带有v:count时有问题。
" 前面的j是为了抵消掉用户按下的数字，然后再用k回到原处，需要比较是否走到文件末尾，如果是就差值返回。
nnoremap <expr> V (line('.') == line('$') ? "<ESC>V" : "j".((v:count1 <= line('$')-line('.') ? v:count1 : line('$')-line('.')) ."kV". (v:count1 > 1 ? (v:count-1)."j" : "")))
