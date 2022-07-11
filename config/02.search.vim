" ---------- search.vim ----------
" 搜索和替换设置
" 替换语法:%s/Windows\C/Mac/gc
" %：代表全文，20,30：表示搜索20到30行，'<,'>：表示选择区域，不填表示当前行
" s：substitute 代替、替换的缩写
" \c：表示忽略大小写
" \C：表示要区分大小写
" g：global的缩写，表示每一行都要找到所有匹配项，否则只匹配改行的第一个
" c：comform的缩写，表示每次替换都要弹出提示
" n：number的缩写，表示不替换，只显示匹配出现的次数
" \< \>：匹配完整的一个单词，如:%s/\<foo\>/Foo/gc只会匹配foo，而不会匹配get_foo
"
" /：搜索整个buffer的内容
" :[range]g[lobal]/{pattern}/[cmd]：对局部区域进行搜索，[cmd]默认是:p即输出搜索到的结果，如：30,50g/jiang
"
" vim的正则规则分为4种：\v(very magic)、\m(magic)、\M(nomagic)、\V(very nomagic)
" 其中：\m(magic)      对应POSIX的BRE(Basic Regular Expressions)
" 其中：\v(very magic) 对应POSIX的ERE(Extended Regular Expressions)
" 搜索时在正则表达式前加对应选项以使用不同的规则，如：/\v(apple|java)script 
" 字符串匹配的规则：
" String Match
"   │
"   ├──Wildcard character（https://en.wikipedia.org/wiki/Wildcard_character）
"   │    │──程序：Unix文件路径、vim路径、Bash(==右侧pattern)、Bash(case选项)
"   │    └──规则：任意字符任意个*、任意字符?、单个字符[]
"   │
"   └──Regular Expressions（https://en.wikipedia.org/wiki/Regular_expression）
"        │
"        │──PCRE（事实上的标准）
"        │    │──程序：grep -P、pcregrep、Perl、PHP、Java、Javascript、Python、C#
"        │    │──规则：https://www.php.net/manual/zh/reference.pcre.pattern.syntax.php
"        │    └──匹配：匹配项$0-9
"        │
"        └──POSIX（Portable Operating System Interface）
"             │
"             │──BRE（Basic Regular Expressions）
"             │    │──程序：grep [-G]、vim(断言有区别)、MultipleCursorsFind、sed(不支持\n)、awk、Far(vimgrep引擎)（大部分Unix程序默认BRE）
"             │    │──差异：有无\？、至少一个\+、可选\|、模式\(\)、数量\{\}
"             │    └──替换：匹配项\0-9
"             │
"             └──ERE（Extended Regular Expressions）
"                  │──程序：grep -E、man(/?)、vim(\v断言有区别)、Ag、Far(Ag引擎)、Bash(=~右侧pattern)（大部分Unix程序可以通过-E来使用ERE）
"                  └──替换：匹配项\0-9

set ignorecase " 搜索时忽略大小写，大写字符也可以匹配小写，会被\c和\C选项覆盖
set smartcase  " 智能大小写，正则中一旦出现大写会开启区分大小写模式，需开启ignorecase，会被\c和\C选项覆盖
" vim中大小写总结：
" vim(/?)            ：1. smartcase，2. 附加\c和\C强制大小写的区分与否
" MultipleCursorsFind：1. smartcase，2. 附加\c和\C强制大小写的区分与否
" Ag                 ：1. smartcase，2. 附加\C强制大小写的区分与否，   3. 搜索时忽略.git/，vendor/，node_modules/等目录，除非cd进入
" Far                ：1. smartcase，2. 附加\C强制大小写的区分与否     3. 搜索时忽略.git/，vendor/，node_modules/等目录，除非cd进入

" 对选中的字符，按n/N快速搜索，搜索后自动高亮
" 参考：[Vim registers: The basics and beyond](https://www.brianstorti.com/vim-registers/)
" 这里使用了一个自定义的register：a
vnoremap n "ay/<C-r>a<CR>:set hlsearch<CR>
vnoremap N "ay/<C-r>a<CR>NN:set hlsearch<CR>

" 快速搜索单词时，自动开启高亮
nnoremap <silent> * :set hlsearch<CR>*
nnoremap <silent> # :set hlsearch<CR>#

" 在normal模式下按S切换显示搜索高亮
" 避免有的时候高亮打扰代码的编写
" 参考：[Highlight all search pattern matches](https://vim.fandom.com/wiki/Highlight_all_search_pattern_matches)
nnoremap S :set hlsearch!<CR>

" 每次在命令行搜索栏回车时，都再次开启搜索高亮
" 避免手动关闭高亮后，搜索不明显
cnoremap <CR> <C-r>=Jiang_HeighlightForSearch()<CR><CR>
function Jiang_HeighlightForSearch()
    if getcmdtype() =~ '[/?]'
        execute "set hlsearch"
    endif
    return ""
endf

