" ---------- linux.vim ---------- 
" 针对Linux系统下Vim的单独设置
" 按键映射：剪切复制粘贴都操作register 0，避免被d删除弄脏
nnoremap cc "0cc<ESC>
vnoremap c "0c<ESC>
nnoremap C "0C<ESC>
vnoremap C "0C<ESC>
nnoremap p "0p
vnoremap p "0p
nnoremap P "0P
vnoremap P "0P

