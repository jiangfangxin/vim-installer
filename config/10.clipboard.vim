" ---------- clipboard.vim ----------
" 一些基础知识：
" <silent> ------- 静默执行（:help <silent>）
"     执行的命令不会再编辑器的命令行显示。
" :normal ------- normal模式（:help :normal）
"     在normal模式中执行后面的内容，如果加!，也就是:normal!，则后面的操作会禁用用户自定义的map。
" excute -------- 执行命令（:help excute）
"     可以在function内部调用vim的命令行，而不用显示地通过输入:来执行命令。
" g@ ------------ 操作符之一（:help g@）
"     g@操作符后面可以跟{motion}移动符（如：h、l、j、k、e、w、b、gg、G、f{char}、F{char}等），
"     输入完{motion}移动符之后自动调用operatorfunc中绑定的function。
"     同为操作符的还有：c、d、y、~、g~、gu、gU、~、=、gq、g?、>、<、zf等。
" operatorfunc -- 操作符绑定函数（:help operatorfunc）
"     可以给操作符绑定一个function，然后在g@后面的{motion}按完之后自动调用。
" '[ `[ --------- 定位区域头字符
" '] `] --------- 定位区域头字符


" 按键映射：register * 对应的是操作系统的剪贴板，但并非所有Vim编译版都支持，通过echo has("clipboard")查看，为0则不支持
" 剪切复制粘贴都操作register *
Jiang_YankWithMotion实现了yh、yl、ye、yw、yb、y3j等等。
nnoremap <silent> y :set operatorfunc=Jiang_YankWithMotion<CR>g@
function Jiang_YankWithMotion(type)
    if a:type == 'char'
        execute 'normal! `[v`]"*y'
    elseif a:type == 'line'
        execute 'normal! `[V`]"*y'
    endif
endf
nnoremap yy "*yy
nnoremap Y "*Y
vnoremap y "*y
vnoremap Y "*Y

" Jiang_CutWithMotion实现了ch、cl、ce、cw、cb、c3j等等。
nnoremap <silent> c :set operatorfunc=Jiang_CutWithMotion<CR>g@
function Jiang_CutWithMotion(type)
    if a:type == 'char'
        execute 'normal! `[v`]"*c' . "\<ESC>"
    elseif a:type == 'line'
        execute 'normal! `[V`]"*c' . "\<ESC>dd"
    endif
endf
" 剪切之后希望保持在normal模式，同时如果是行剪切的话剪切完了要删掉空白行。
nnoremap cc "*cc<ESC>dd
nnoremap C "*C<ESC>
vnoremap c "*c<ESC>
vnoremap C "*C<ESC>dd

" 粘贴取自系统剪贴板
" nnoremap p "*p
" nnoremap P "*P
" vnoremap p "*p
" vnoremap P "*P

" 复制整个文件内容
nnoremap <leader>yf :<C-u>1,$y *<CR>
vnoremap <leader>yf <ESC>:<C-u>1,$y *<CR>
