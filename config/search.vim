" ---------- search.vim ----------
" 搜索和替换设置
" 替换语法:%s/Windows\C/Mac/gc
" %：代表全文，20,30：表示搜索20到30行，'<,'>：表示选择区域，不填表示当前行
" s：search的缩写
" \C：表示要区分大小写
" g：global的缩写，表示每一行都要找到所有匹配项，否则只匹配改行的第一个
" c：comform的缩写，表示每次替换都要弹出提示
set hlsearch        " 开启搜索高亮
set incsearch       " 开启实时搜索
set ignorecase      " 搜索时忽略大小写

" 对选中的字符，按f快速搜索，搜索后自动高亮
" 参考：[Vim registers: The basics and beyond](https://www.brianstorti.com/vim-registers/)
" 这里使用了一个自定义的register：a
vnoremap f "ay/<C-r>a<CR>:set hlsearch<CR>

" 在normal和virtual模式按F切换显示搜索高亮
" 避免有的时候高亮打扰代码的编写
" 参考：[Highlight all search pattern matches](https://vim.fandom.com/wiki/Highlight_all_search_pattern_matches)
nnoremap F :set hlsearch!<CR>
vnoremap F <ESC>:set hlsearch!<CR>gv

" 每次在命令行搜索栏回车时，都再次开启搜索高亮
" 避免手动关闭高亮后，搜索不明显
cnoremap <CR> <C-r>=HeighlightForSearch()<CR><CR>
function HeighlightForSearch()
    if getcmdtype() =~ '[/?]'
        execute "set hlsearch"
    endif
    return ""
endf

