" ---------- edit.vim ----------
" 按键映射：快速移动光标
" Shift + Left：左移一个word        Shift + Right：右移一个word
" Shift + Up  ：上移一行            Shift + Down ：下移一行
nmap <S-Up> <Up>
imap <S-Up> <Up>
vmap <S-Up> <Up>
nmap <S-Down> <Down>
imap <S-Down> <Down>
vmap <S-Down> <Down>
" Shift + Right 用e来前进一个单词
nmap <S-Right> e
imap <S-Right> <C-o>e
vmap <S-Right> e

" insert模式下：光标行前行尾定位
imap <C-a> <Home>
imap <C-e> <End>

" Ctrl + d: 向右删除一个word
imap <C-d> <C-o>dw

" Ctrl + k：删除到行尾
imap <C-k> <C-r>=DeleteToEnd()<CR>
function DeleteToEnd()
    if strlen(getline('.')) == 0
        return "\<esc>\<s-j>i"
    elseif strlen(getline('.')) == (col('.') - 1)
        return "\<esc>\<s-j>xi"
    else
        return "\<C-o>d$"
    endif
endf

" 按键映射：剪切复制粘贴都操作register 0，避免被d删除弄脏
nnoremap cc "0cc<ESC>
vnoremap c "0c<ESC>
nnoremap C "0C<ESC>
vnoremap C "0C<ESC>
nnoremap p "0p
vnoremap p "0p
nnoremap P "0P
vnoremap P "0P

" 按键映射：英文符号()[]{}<>等自动补全
inoremap ( ()<ESC>i
inoremap [ []<ESC>i
inoremap { {}<ESC>i
inoremap ) <C-r>=ClosePair(')')<CR>
inoremap ] <C-r>=ClosePair(']')<CR>
inoremap } <C-r>=ClosePair('}')<CR>
" 只有在html和vim文件中才开启<>匹配，其他文件中为比较符号
autocmd Syntax html,vim inoremap < <lt>><ESC>i| inoremap > <C-r>=ClosePair('>')<CR>
function ClosePair(char)
    if getline('.')[col('.') - 1] == a:char     " 当已有)的时候再输入)就只是右移
        return "\<Right>"
    else
        return a:char       " a: 指的是argument，指明变量char是在arguments的域里面
    endif
endf

" 按键映射：编写function时，当光标在{}中间（如{|}）时回车就会把光标定位回参数那里
inoremap <CR> <C-r>=SmartEnter()<CR>
function SmartEnter()
    if getline('.')[col('.') - 2] == '{' && getline('.')[col('.') - 1] == '}'
        return "\<CR>\<ESC>bhh"
    else
        return "\<CR>"
    endif
endf

" 按键映射：英文符号``''""等自动补全
inoremap ` <C-r>=QuoteDelim("`")<CR>
inoremap ' <C-r>=QuoteDelim("'")<CR>
inoremap " <C-r>=QuoteDelim('"')<CR>
function QuoteDelim(char)
    let line = getline('.')
    let col  = col('.')
    if line[col - 2] == a:char && line[col - 1] == a:char       " 当前位置和前一位都有符号，再次输入右移一位
        return "\<Right>"
    elseif line[col - 2] != a:char && line[col - 1] != a:char   " 前面和当前位置都没有符号，连续输入两个符
        return a:char . a:char . "\<ESC>i"
    else                                                        " 之后单个符号的时候，就补一个符号
        return a:char
    endif
endf

