" ---------- macos.vim ----------
" 针对Mac系统下Vim的单独设置
" 按键映射：剪切复制粘贴都操作register *，register * 对应的是Mac的剪贴板
nnoremap yy "*yy
vnoremap y "*y
nnoremap Y "*Y
nnoremap cc "*cc<ESC>
vnoremap c "*c<ESC>
nnoremap C "*C<ESC>
vnoremap C "*C<ESC>
nnoremap p "*p
vnoremap p "*p
nnoremap P "*P
vnoremap P "*P

" Mac剪贴板有两个命令：pbcopy、pbpaste，当vim --version中没有开启+clipboard的时候，
" 可以利用这两个命令实现对Mac剪贴板的访问，如下：
" 1. normal模式下按F8是复制单行，如果按F8之前提供了数字，对应需要复制的行数
"     nnoremap <F8> :<C-u><C-r>=line('.')<CR>,+<C-r>=v:count-1<CR>w !pbcopy<CR><CR>
" 2. visual模式下按F8是复制选择的内容，这个新建了一个缓冲文件临时存储复制的内容，
" 等把缓冲文件内容复制到Mac剪贴板之后再删除缓冲区.
"     vnoremap <F8> "ay:tabe ~/vimclipboard<CR>"ap:w !pbcopy<CR><CR>:bdelete!<CR>
" 3. Mac下支持直接使用快捷键Cmd + v粘贴内容到Vim中，所以就不绑定额外的快捷键用于粘贴了。
" 并且Mac下Cmd + v直接在normal、insert、visual等三种模式下粘贴，都运作的非常好。

