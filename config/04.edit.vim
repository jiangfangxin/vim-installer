" ---------- edit.vim ----------
" 允许删除键删除vim的indent，行首和行末字符
set backspace=indent,eol,start
" normal模式下
" H ：把光标移动到视图顶部  L ：把光标移动到视图底部    M ：把光标移动到视图中部
" zt：把当前行移动到顶部    zb：把当前行移动到底部      zz：把当前行移动到中部
" Ctrl + O：回到前一次光标所位置        Ctrl + i：去到下一次光标所在位置
" )       ：去到下一句                  (       ：去到上一句
" }       ：去到下一个段落              }       ：去到上一个段落
" ]]      ：去到下一个函数              [[      ：去到上一个函数
" %       ：去到匹配的引号或括号
" f{char} ：forward，前进到下一个单词   F{char} ：后退到下一个单词
" t{char} ：till，前进到下一个单词之前  T{char} ：后退到下一个单词之后
" ;       ：针对f，F，t，T跳转到下一个  ,       ：针对f，F，t，T跳转到上一个
"
" insert模式下
" Ctrl + t：增加整行tab缩进     Ctrl + f：将整行回归到最佳缩进
"
" visual模式下
" o：在选择区域的起始或结束位置间跳转   O：在选择区域的起始或结束位置间跳转，对于纵向选择，则是是在行的起始或结束位置间跳转
"
" vim的宏：normal模式下轻松实现多行重复操作
" q{0-9a-zA-Z"}        ：开始录制宏并记录到指定寄存器
" q                    ：结束宏录制
" {number}@{0-9a-zA-Z"}：运行行指定次数录制的宏
" 例如：^vf"y;;v;pj：复制前一个""中的内容到后一个""中，记得最后要加一个j到下一行

" vim自带的代码折叠设置syntax.txt
let g:vimsyn_folding = 'af'
let g:markdown_folding = 1
let g:tex_fold_enabled = 1
let g:javaScript_fold = 1
let g:sh_fold_enabled= 7
let g:ruby_fold = 1
let g:perl_fold = 1
let g:perl_fold_blocks = 1
let g:r_syntax_folding = 1
let g:rust_fold = 1
let g:php_folding = 1 " 启用php文件的syntax折叠
set foldlevelstart=99 " 99表示打开文件时默认不折叠
" html和xml标签比较多，最好还是手动折叠
" 所以不用：let g:xml_syntax_folding = 1
autocmd FileType html,xml setlocal foldmethod=manual
" 对于html和xml在nanual模式下折叠快捷键
nnoremap <leader>zt vatzf
vnoremap <leader>zt atzf
" zR：展开所有折叠          zM：关闭所有折叠
" zr：折叠等级减一          zm：折叠等级加一
" zo：展开当前折叠          zc：关闭当前折叠
" za：展开或关闭当前折叠    zf：手动创建折叠

" 保存当前文件
" :w：无论缓冲区是否更改都会写入，:update：只有当缓冲区更改了才会写入
nnoremap <C-s> :update<CR>
inoremap <C-s> <ESC>:update<CR>a
vnoremap <C-s> <ESC>:update<CR>gv
" 全选快捷键，在normal和visual模式下按Ctrl + a即可
nnoremap <C-a> ggvG$
vnoremap <C-a> <ESC>ggvG$
" insert模式下：光标行首行尾定位
inoremap <C-a> <Home>
inoremap <C-e> <End>

" 快速移动光标
" 这两个是Vim自带的：
" Shift + Left：左移一个word        Shift + Right：右移一个word
" Vim自带Shift + Up/Down为翻页，为了避免按错我改为了上下移动一行：
" Shift + Up  ：上移一行            Shift + Down ：下移一行
nnoremap <S-Up> <Up>
inoremap <S-Up> <Up>
vnoremap <S-Up> <Up>
nnoremap <S-Down> <Down>
inoremap <S-Down> <Down>
vnoremap <S-Down> <Down>
" Shift + Right 用e来前进一个单词
" Vim默认Shift + Right是w，但是e会好用些
nnoremap <S-Right> e
inoremap <expr> <S-Right> ((getline('.')[col('.')-1] =~ '[_a-zA-Z0-9]') && (getline('.')[col('.')] =~ '[^a-zA-Z0-9]')) ? "<Right>" : "<ESC>ea"
vnoremap <S-Right> e

" Ctrl + d: 向右删除一个word
inoremap <C-d> <C-o>dw

" Ctrl + k：删除到行尾
inoremap <C-k> <C-r>=Jiang_DeleteToEnd()<CR>
function Jiang_DeleteToEnd()
    let line = getline('.')
    let len = strlen(line)
    if len == 0     " 本行没有字符
        return "\<ESC>Ji"
    elseif (col('.') - 1) < len     " 光标没有再最末尾
        return "\<C-o>d$"
    elseif match(line, '\s$') == -1     " 本行最后一个不是空白字符
        return "\<ESC>Ja\<BS>"
    elseif match(getline(line('.') + 1), '^\s*$') != -1     " 下一行如果全是空白字符
        return "\<ESC>Ja"
    else
        return "\<ESC>Ji"
    endif
endf

" 运行当前行或者指定行的代码
augroup jiang_run_code
  autocmd!
  " 运行指定行的bash代码
  autocmd FileType sh nnoremap <buffer> <expr> <leader>R ":<C-u>1,$w !bash<CR>"
  autocmd FileType sh nnoremap <buffer> <expr> <leader>r ":<C-u>" .line('.'). "," . (v:count1-1 <= line('$')-line('.') ? line('.')+v:count1-1 : "$") . "w !bash<CR>"
  autocmd FileType sh vnoremap <buffer> <leader>r :<C-u>'<,'>w !bash<CR>
  " 运行指定行的php代码
  autocmd FileType php nnoremap <buffer> <expr> <leader>R ":<C-u>" .(getline(1) =~ '\s*<?\(php\)\?\s*' ? "2,$" : "1,$"). "w !php -a<CR>"
  autocmd FileType php nnoremap <buffer> <expr> <leader>r ":<C-u>" .line('.'). "," . (v:count1-1 <= line('$')-line('.') ? line('.')+v:count1-1 : "$") . "w !php -a<CR>"
  autocmd FileType php vnoremap <buffer> <leader>r :<C-u>'<,'>w !php -a<CR>
  " 运行指定行的javascript代码
  autocmd FileType javascript,html,vue,blade nnoremap <buffer> <expr> <leader>R ":<C-u>1,$w !node<CR>"
  autocmd FileType javascript,html,vue,blade nnoremap <buffer> <expr> <leader>r ":<C-u>" .line('.'). "," . (v:count1-1 <= line('$')-line('.') ? line('.')+v:count1-1 : "$") . "w !node<CR>"
  autocmd FileType javascript,html,vue,blade vnoremap <buffer> <leader>r :<C-u>'<,'>w !node<CR>
augroup END

" 搜索项目中的TODO和FIXME
nnoremap <leader>do :Ag TODO\|FIXME<CR>

