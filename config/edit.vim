" ---------- edit.vim ----------
" 允许删除键删除vim的indent，行首和行末字符
set backspace=indent,eol,start

" 全选快捷键，在normal和visual模式下按Ctrl + a即可
nnoremap <C-a> ggvG$
vnoremap <C-a> <ESC>ggvG$

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
inoremap <S-Right> <C-o>e
vnoremap <S-Right> e

" insert模式下：光标行首行尾定位
inoremap <C-a> <Home>
inoremap <C-e> <End>

" Ctrl + d: 向右删除一个word
inoremap <C-d> <C-o>dw

" Ctrl + k：删除到行尾
inoremap <C-k> <C-r>=DeleteToEnd()<CR>
function DeleteToEnd()
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

