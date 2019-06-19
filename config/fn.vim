" ---------- fn.vim ----------
" 功能键映射
" F1：打开Vim手册（默认）
" F2：切换显示行号
" number后面的!表示toggle的意思
" 参考：[Vim’s absolute, relative and hybrid line numbers](https://jeffkreeftmeijer.com/vim-number/)
nnoremap <F2> :set number! relativenumber!<CR>
inoremap <F2> <ESC>:set number!<CR>a
vnoremap <F2> <ESC>:set number! relativenumber!<CR>gv
" F3：切换开启列高亮显示，用于对齐
nnoremap <F3> :set cursorcolumn!<CR>
inoremap <F3> <ESC>:set cursorcolumn!<CR>a
vnoremap <F3> <ESC>:set cursorcolumn!<CR>gv
" F4：关闭当前文件
nnoremap <F4> :q<CR>
inoremap <F4> <ESC>:q<CR>
vnoremap <F4> <ESC>:q<CR>
" F7：切换paste粘贴模式，insert模式下从外部复制代码就不会改变代码原格式
set pastetoggle=<F7>
" F8：对Mac系统的单独设置，在macos.vim中被定义为复制到系统剪贴板
" F9/F10：保存当前文件，避免盲按出错，设置挨着的这两个按键一样的功能
" :w：无论缓冲区是否更改都会写入，:update：只有当缓冲区更改了才会写入
nnoremap <F9> :update<CR>
inoremap <F9> <ESC>:update<CR>a
vnoremap <F9> <ESC>:update<CR>gv
nnoremap <F10> :update<CR>
inoremap <F10> <ESC>:update<CR>a
vnoremap <F10> <ESC>:update<CR>gv

