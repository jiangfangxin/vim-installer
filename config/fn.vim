" ---------- fn.vim ----------
" 按键映射
" F2：切换显示行号number
nmap <F2> :set invnumber<CR>
imap <F2> <ESC>:set invnumber<CR>a
vmap <F2> <ESC>:set invnumber<CR>gv
" F3：切换开启列高亮显示，用于对齐
nmap <F3> :set invcursorcolumn<CR>
imap <F3> <ESC>:set invcursorcolumn<CR>a
vmap <F3> <ESC>:set invcursorcolumn<CR>gv
" F4：关闭当前文件
nmap <F4> :q<CR>
imap <F4> <ESC>:q<CR>a
vmap <F4> <ESC>:q<CR>gv
" F9：切换paste粘贴模式
set pastetoggle=<F9>
" F10：保存当前文件，:w：无论缓冲区是否更改都会写入，:update：只有当缓冲区更改了才会写入
nmap <F10> :update<CR>
imap <F10> <ESC>:update<CR>a
vmap <F10> <ESC>:update<CR>gv

