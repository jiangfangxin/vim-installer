" ---------- plugin-settings.vim ----------
" 插件mhinz/vim-startify自定义设置
" 关闭自动cd到打开文件的目录
let g:startify_change_to_dir = 0
" 打开文件时自动cd到git等项目的根目录
let g:startify_change_to_vcs_root = 1

" 插件wsdjeg/vim-fetch自定义设置
" gF: 跳转到光标所在路径包括行号和列号

" 插件tpope/vim-fugitive自定义设置
" :G  / :Git   [command]    即：:!git [command]             在vim中调用bash命令git
" :G! / :Git!  [command]    即：:!git [command]             在vim中调用bash命令git，输出结果到一个临时文件中
" :G  / :Git / :Gstatus     即：git status                  显示所有文件状态
nnoremap <silent> <leader>gs :Gstatus<CR>
" :Glog [ file ]            即：git log [ file ]            显示提交记录
" :Gcommit -m 'msg'         即：git commit -m 'msg'         提交修改
" :Gfetch                   即：git fetch                   获取远端的更新
nnoremap <leader>gf :Gfetch<CR>
" :Gpush origin {branch}    即：git push origin {branch}    推送分支到远端
nnoremap <leader>gp :Gpush origin <C-r>=fugitive#head()<CR>
" :Gdiffsplit               即：git diff %                  对比当前文件和HEAD的差异
nnoremap <leader>fd :Gdiffsplit<CR>
" :Gblame                   即：git blame %                 blame当前文件
nnoremap <leader>fb :Gblame<CR>
" :Gwrite                   即：git add %                   添加当前文件到stage
" 暂时用处不大: nnoremap <leader>fs :Gwrite<CR>
" :G reset HEAD %           即：git reset HEAD %            添加当前文件到unstage
" 暂时用处不大: nnoremap <leader>fu :G reset HEAD %<CR><CR>
" :Gread                    即：git checkout %              检出当前文件到HEAD版本
nnoremap <leader>fx :Gread<CR>
" :Grebase {branch}         即：git rebase {branch}         基于分支做rebase
nnoremap <leader>gr :Grebase master
" :Gremove                  即：git rm --cached %           从版本管理中移除当前文件
nnoremap <leader>gd :Gremove<CR>
" 通用快捷键
" <CR>：直接打开文件
" Ctrl + x：在横向窗口中打开文件   Ctrl + v：在纵向窗口中打开文件
" Ctrl + t：在新标签页中打开文件   p       ：在预览窗口中打开文件
" Ctrl + n：跳转到下一个修改块     Ctrl + p：跳转到上一个修改块
" Status窗口中的快捷键
" s ：git add       Stage文件或块修改           u ：git reset           Unstage文件或块修改
" - ：git add       Toggle stage文件或块修改    X ：git checkout        忽略块修改
" = ：git diff      展开文件修改                dd：git diff            显示文件修改前后对比
" cc：git commit    创建一个commit              ca：git commit --amend  创建一个commit来覆盖上一次提交
" Log窗口中的快捷键
" ri：git rebase -i HEAD~{commit}   从当前commit进入交互式的rebase
" rr：git rebase --continue         继续当前的rebase                rs；git rebase --skip   跳过当前的commit然后继续rebase
" re：git rebase --edit             编辑当前的rebase                ra：git rebase --abort  终止当前的rebase
" Blame窗口的快捷键
" -：进入光标所在的commit然后再blame    q：退出

" 插件airblade/vim-gitgutter自定义设置
set updatetime=1000 " 设置gutter更新时间为1秒，默认是4秒
let g:gitgutter_map_keys = 0 " 取消gitgutter插件默认的按键绑定
" 开启或刷新gitgutter
nnoremap <silent> <leader>hh :call Jiang_OnOrRefreshGitGutter()<CR>
function Jiang_OnOrRefreshGitGutter()
    if exists('g:gitgutter_enabled') && g:gitgutter_enabled == 1
        execute 'GitGutterAll'
        echo 'GitGutterAll'
    else
        execute 'GitGutterEnable'
        echo 'GitGutterEnable'
    endif
endf
" 关闭gitgutter
nnoremap <leader>ho :GitGutterDisable<CR>
" 折叠当前文件中所有未修改的代码
nnoremap <leader>hz :GitGutterFold<CR>
" ]h：跳转到下一个修改
nmap ]h <Plug>GitGutterNextHunk
" [h：跳转到上一个修改
nmap [h <Plug>GitGutterPrevHunk
" <leader>hs：暂存光标所在的hunk
nmap <leader>hs <Plug>GitGutterStageHunk
" <leader>hx：撤销光标所在的hunk的修改
nmap <leader>hx <Plug>GitGutterUndoHunk
" <leader>hp：预览光标所在的hunk
nmap <leader>hp <Plug>GitGutterPreviewHunk

" 插件kshenoy/vim-signature自定义设置
" " 开启或刷新signature的侧边栏mark
" nnoremap <silent> <leader>mm :call Jiang_OnOrRefreshMarkSignature()<CR>
" function Jiang_OnOrRefreshMarkSignature()
"     if exists('b:sig_enabled') && b:sig_enabled == 1
"         execute 'SignatureRefresh'
"         echo 'MarkSignatureRefresh'
"     else
"         execute 'SignatureToggleSigns'
"         echo 'MarkSignatureOn'
"     endif
" endf
" " 关闭signature的侧边栏mark
" nnoremap <silent> <leader>mo :call Jiang_OffMarkSignature()<CR>
" function Jiang_OffMarkSignature()
"     if exists('b:sig_enabled') && b:sig_enabled == 1
"         execute 'SignatureToggleSigns'
"         echo 'MarkSignatureOff'
"     endif
" endf
" 删除buffer中marks和global的marks
nnoremap m<BS> :<C-U>delmarks a-zA-Z<CR>
" 删除buffer中marks和global的marks, 强制写入nvim的shada(Share Data)文件中，避免下次打开marks重现
nnoremap M<BS> :<C-U>delmarks a-zA-Z<CR>:wshada!<CR>
" m[a-zA-Z]：Mark/Unmark字母                dm[a-zA-Z]：删除某个字母的mark
" m.       ：Mark/Unmark紧接着的一个字母    `[a-zA-Z] ：跳转到字母所在mark
" ]`       ：跳转到下一个mark               [`        ：跳转到上一个mark
" `]       ：按字母顺序跳转到下一个mark     `[        ：按字母顺序跳转到上一个mark
" `"       ：去到上一次关闭文件的位置       ·.        ：去到最后一次修改的位置
" m-       ：删除本行的mark                 m<Space>  ：删除当前buffer的所有mark

" X 插件kien/ctrlp.vim已禁用：模糊搜索文件名来打开文件
" X 插件kien/ctrlp.vim自定义设置
" Ctrl + p：打开文件摸索搜索        <F5>    ：清除文件缓存更新索引        
" Ctrl + d：切换文件名或路径搜索    Ctrl + r：开启或关闭正则搜索
" Ctrl + j：下一个                  Ctrl + k：下一个
" <Enter> ：在本窗口中打开文件      Ctrl + t：在新标签页中打开
" Ctrl + v：在纵向窗口中打开        Ctrl + s：在水平窗口中打开
" Ctrl + n：下一条搜索              Ctrl + p：上一条搜索
" Ctrl + y：在工作目录创建文件      Ctrl + z：标记/取消标记文件
" let g:ctrlp_working_path_mode = ''  " 空字符串表示在nvim的工作目录里搜索

" 插件junegunn/fzf自定义设置
" Bash命令行：
"   Ctrl + r：实时模糊搜索命令历史    Ctrl + t：实时模糊搜索文件和文件夹
"   文件或文件夹实时模糊搜索
"     cd **<Tab>        vim **<Tab>         nvim ~/program/**<Tab> 
"   主机IP实时模糊搜索
"     ssh **<Tab>       telnet **<Tab>
"   环境变量实时模糊搜索
"     unset **<Tab>     export **<Tab>      unalias **<Tab>
"   进程实时模糊搜索，这时无需**
"     kill <Tab>
" 在Vim中：
"   :FZF  显示实时模糊搜索文件窗口
"   <Enter> ：在本窗口中打开文件
"   <Tab>   ：选择当前行          Shift + <Tab>：取消当前行的选择
"   Ctrl + t：在新标签页中打开    Ctrl + v     ：在纵向窗口中打开
"   Ctrl + x：在水平窗口中打开    Ctrl + g     ：关闭搜索窗口
" 模糊搜索技巧：
"   sbtrkt：对整行字符模糊匹配
"   'wild  ：不拆分单词匹配           ^music：以这个单词开头的匹配
"   .mp3$  ：以这个单词结尾的匹配     !fire ：不包含这个单词的匹配
"   !^music：不以这个单词开头的匹配   !.mp3$：不以这个单词结尾的匹配
"   .py$ | .go$：以.py或者.go结尾的匹配

" 插件junegunn/fzf.vim自定义设置
" 关闭fzf弹出窗的行号
autocmd FileType fzf setlocal nonumber norelativenumber
" :Files [PATH] 实时模糊搜索文件
nnoremap <silent> <C-p> :Files<CR>
inoremap <silent> <C-p> <ESC>:Files<CR>
vnoremap <silent> <C-p> :<C-u>Files<CR>
" :Buffers 实时模糊搜索buffers
nnoremap <silent> <C-b> :Buffers<CR>
" :Ag [PATTERN] 使用Ag搜索项目所有文件，Alt + a 全选，Alt + d 全不选
nnoremap <silent> <C-f> :Ag<CR>
" :BLines [QUERY] 对当前文件进行行搜索，绑定苹果键盘的Alt + f（mac-keyboard）
nnoremap <silent> ƒ :BLines<CR>
" :Tags [QUERY] 搜索项目内的所有标签
nnoremap <silent> <C-g> :Tags<CR>
" :BTags [QUERY] 搜索当前文件内的所有标签，绑定苹果键盘的Alt + g（mac-keyboard）
nnoremap <silent> © :BTags<CR>
" :History 搜索之前打开的文件以及buffer
nnoremap <silent> <C-h> :History<CR>
inoremap <silent> <C-h> <ESC>:History<CR>
vnoremap <silent> <C-h> :<C-u>History<CR>
" :History: 搜索命令历史    :History/ 搜索查找历史
cnoremap <silent><expr> <C-h> (getcmdtype() =~ '[/?]') ? '<C-u><BS>:<C-u>History/<CR>' : '<C-u>History:<CR>'
" :Commits 搜索项目的提交历史
nnoremap <silent> <leader>gl :Commits<CR>
" :BCommits 搜索当前文件的提交历史
nnoremap <silent> <leader>fl :BCommits<CR>
" :Helptags 搜索vim帮助文档
nnoremap <silent> <F1> :Helptags<CR>
inoremap <silent> <F1> <ESC>:Helptags<CR>
vnoremap <silent> <F1> :<C-u>Helptags<CR>
cnoremap <silent> <F1> <C-u><BS>:Helptags<CR>
" :Marks 搜索当前buffer的marks，绑定苹果键盘的Alt + m（mac-keyboard）
nnoremap <silent> µ :Marks<CR>
" :Maps 搜索快捷键绑定
nnoremap <silent> <leader>km :Maps<CR>
" :Filetypes 设置文件类型
nnoremap <silent> <leader>ft :Filetypes<CR>
" :Commands 搜索vim命令

" 插件brooth/far.vim自定义设置
" 下面两项设置，懒加载来提高滚动的流畅性
set lazyredraw
set regexpengine=1
" 设置Far默认的搜索引擎为Ag，默认vimgrep引擎太慢了
" 注意：使用Ag引擎后，有2点变化：
" 1. 使用的正则语法由BRE变为了ERE。
" 2. 文件路径不再是通配符，而是ERE正则，如：
" 由原来的 :F word app/**/*.php 变为 :F word app/.*\.php
" 搜索所有 :F word **/*         变为 :F word .*
let g:far#source = 'ag'
" 删除所有far.vim产生的无用buffer
nnoremap <leader>bd :bdelete FAR*<C-a><CR>
" :F     {pattern} {file-mask} {params}                 多文件搜索
" :Far   {pattern} {replace-with} {file-mask} {params}  预览多文件替换
" :Fardo {params}                                       执行替换
" :Refar {params}                                       刷新一下替换预览
" 下面两个快捷键可以在搜索结果窗口滚动预览窗口而无需移动光标
" Ctrl + j：向下滚动预览窗口    Ctrl + k：向上滚动预览窗口
" i ：包含当前行替换            x ：排除当前行替换
" I ：包含所有替换              X ：排除所有替换
" t ：包含/排除光标所在行的替换 p ：打开预览窗口
" zo：展开文件搜索条目          zc：折叠文件搜索条目    za：展开/折叠文件搜索条目
" zr：展开所有搜索条目          zm：折叠所有文件搜索条目

" 插件tpope/vim-eunuch自定义设置
" 自己定义了一个命令:Copy
command -nargs=1 Copy :call Jiang_Copy_Current_File(expand('%'), '<args>')
function Jiang_Copy_Current_File(source, distination)
    let src = fnameescape(a:source)
    let dis = fnameescape(a:distination)
    let dir = fnameescape(fnamemodify(a:distination, ':h'))
    call mkdir(dir, 'p')
    call system('cp ' . src . ' ' . dis)
    if isdirectory(dis)
        call execute('e ' . dir . '/'. fnamemodify(a:source, ':t'))
    else
        call execute('e ' . dis)
    endif
endf
" 复制当前文件到指定位置
nnoremap <leader>fc :Copy <C-r>%
vnoremap <leader>fc <ESC>:Copy <C-r>%
" 移动当前文件以及buffer到指定位置
nnoremap <leader>fm :Move <C-r>%
vnoremap <leader>fm <ESC>:Move <C-r>%
" 删除当前文件以及文件的buffer
nnoremap <leader>fD :Delete
vnoremap <leader>fD <ESC>:Delete
" 修改当前文件的权限
nnoremap <leader>fp :Chmod \| call trim('<C-r>=substitute(system("ls -l ".expand("%")), "\\v(\\s+\\d+){4}:.*$", "", "")<CR>') \| echo trim(system('ls -l %'))<Home><Right><Right><Right><Right><Right><Space>
vnoremap <leader>fp <ESC>:Chmod \| call trim('<C-r>=substitute(system("ls -l ".expand("%")), "\\v(\\s+\\d+){4}:.*$", "", "")<CR>') \| echo trim(system('ls -l %'))<Home><Right><Right><Right><Right><Right><Space>
" 以当前文件路径为基础创建文件夹
nnoremap <leader>md :Mkdir <C-r>=expand('%:h')<CR>
vnoremap <leader>md <ESC>:Mkdir <C-r>=expand('%:h')<CR>
" 以根目录为基础创建文件夹
nnoremap <leader>mD :Mkdir<Space>
vnoremap <leader>mD <ESC>:Mkdir<Space>

" 插件scrooloose/nerdtree自定义设置
" <CR>：查看目录或在当前窗口打开文件
" o：查看目录或在当前窗口打开文件   O：展开当前节点的所有子节点
" x：关闭当前父节点                 X：关闭当前所有直接点
" t：在新标签页打开文件或目录       T：静默地在新标签页打开文件或目录
" v：在纵向窗口中打开文件或目录     s：在横向窗口中打开文件或目录
" p：展开目录或预览当前文件         P：跳到root节点
" J：跳转到最后一个孩子             K：跳转到第一个孩子
" <C-j>：跳转到下一个兄弟节点       <C-k>：跳转到上一个兄弟节点
" u：把当前root的父目录作为新的root e：把当前节点作为root来浏览
" r：刷新当前目录                   R：刷新root下所有目录
" cd：将当前目录设置为CWD           CD：将CWD设置为root
" I：隐藏或显示隐藏文件             B：打开或关闭书签浏览器
" q：关闭nerdtree文件浏览器         A：最小或最大化nerdtree窗口
" m：显示选项菜单                   ?：toggle help
" 在NERFTree中找到当前文件
nnoremap <leader>fr :NERDTreeFind %<CR>

" 插件majutsushi/tagbar自定义设置
" 需要安装：brew/apt install universal ctags
" F8：关闭或开启Tagbar，用于浏览当前文件对象和函数大纲
nnoremap <silent> <F8> :TagbarToggle<CR>
inoremap <silent> <F8> <ESC>:TagbarToggle<CR>a
vnoremap <silent> <F8> <ESC>:TagbarToggle<CR>gv
" <CR>：跳转到定义的地方            p ：预览定义的地方
" v   ：隐藏非public的变量和方法    s ：排序结构树
" zo  ：展开目录树                  zc：折叠目录树      za：展开/折叠目录树
" zr  ：展开所有目录树              zm：折叠所有目录树
" Ctrl + n：跳转到上一个节点        Ctrl + p：跳转到下一个节点

" 插件ludovicchabant/vim-gutentags自定义设置
" 插件会自动识别.git、.hg等所在的目录为项目目录，在保存时后台自动生成tags文件
let g:gutentags_cache_dir = '~/.cache/gutentags' " 在gutentags这个缓存目录中存放所有项目的tags文件避免污染项目

" 插件crooloose/nerdcommenter自定义设置
let g:NERDSpaceDelims = 1       " 注释后添加空格
let g:NERDDefaultAlign = 'left' " 所有注释左对齐
let g:NERDCommentEmptyLines = 1 " 空白行也添加注释
" [count]<leader>cc         ：comment-comment 添加行注释
" [count]<leader>cu         ：comment-undo    取消行注释
" [count]<leader>c<Space>   ：comment-toggle  切换行注释
" [count]<leader>cn         ：comment-nested  对单词或片段代码注释
" [count]<leader>cs         ：comment-sexy    块注释用于函数介绍
" <leader>cA                ：comment-add     在行尾添加注释
" 对文件嵌套其他语言时注释的支持, 如Vue中的js, PHP中的Html
let g:jiang_ft = ''
let g:jiang_nesting_fts = ['html', 'vue', 'php', 'blade']
function Jiang_Simplify_Nesting_Filetype(ft)
    if a:ft =~ 'php.*'
        return 'php'
    elseif a:ft =~ 'html.*'
        return 'html'
    else
        return tolower(a:ft)
    endif
endf
function! NERDCommenter_before()
    if index(g:jiang_nesting_fts, &ft) >= 0
        let g:jiang_ft = &ft
        let stack = synstack(line('.'), col('.'))
        if len(stack) > 0
            let syn = synIDattr((stack)[0], 'name')
            if len(syn) > 0
                let syn = Jiang_Simplify_Nesting_Filetype(syn)
                exe 'setf '.syn
            endif
        endif
    endif
endf
function! NERDCommenter_after()
    if index(g:jiang_nesting_fts, g:jiang_ft) >= 0
        exe 'setf '.g:jiang_ft
        let g:jiang_ft = ''
    endif
endf

" 插件terryma/vim-multiple-cursors自定义设置
" Ctrl + n：选择下一个      Ctrl + p：回到上一个选择
" Ctrl + x：跳过这个选择    Ctrl + k：选择全部匹配
" :MultipleCursorsFind [your-search-string][\c|\C]  选择命令
let g:multi_cursor_select_all_word_key = '<C-k>'
" 退出visual模式时不退出多光标模式
let g:multi_cursor_exit_from_visual_mode = 0
" 退出insert模式时不退出多光标模式
let g:multi_cursor_exit_from_insert_mode = 0
" 在使用多光标模式的时候自动禁用有冲突的映射和插件
function! Multiple_cursors_before()
    call Jiang_UnmapAutoPairs()
    call deoplete#custom#buffer_option('auto_complete', v:false)
endf
function! Multiple_cursors_after()
    call Jiang_RemapAutoPairs()
    call deoplete#custom#buffer_option('auto_complete', v:true)
endf

" 插件jiangmiao/auto-pairs自定义设置
" 暂时禁用auto-pairs的map因为和MultipleCursor冲突
function Jiang_UnmapAutoPairs()
    iunmap <buffer> <SPACE>
    for key in b:jiang_autopairs_keys
        execute 'iunmap <buffer> '.key
    endfor
endf
" 重新map
function Jiang_RemapAutoPairs()
    inoremap <buffer> <silent> <SPACE> <C-R>=AutoPairsSpace()<CR>
    for key in b:jiang_autopairs_keys
        call AutoPairsMap(key)
    endfor
endf

" 插件tpope/vim-surround自定义设置
" cs'[          ：将   'Hello world!'     变为： [ Hello world! ]
" cs']          ：将   'Hello world!'     变为：  [Hello world!]
" cst'          ：将 <p>Hello world!</p>  变为：  'Hello world!'
" ds'           ：将   'Hello world!'     变为：   Hello world!
" ysiw{         ：将    Hello world!      变为： { Hello } world!
" yss{          ：将    Hello world!      变为： { Hello world! }
" visual模式S<p>：将    Hello world!      变为：<p>Hello world!</p>

" 插件easymotion/vim-easymotion自定义设置
let g:EasyMotion_do_mapping = 0 " 禁用默认的快捷键
let g:EasyMotion_smartcase = 1  " 忽略大小写
" 通过s键来启动快速跳转，按下s之后通过一个字符来定位想要跳转的位置
nmap s <Plug>(easymotion-overwin-f)

" 插件junegunn/vim-easy-align自定义设置
" 在完成motion之后进入交互的align命令模式，例如：gaip
nmap ga <Plug>(EasyAlign)
" 进入交互的align命令模式，例如：vipga
vmap ga <Plug>(EasyAlign)
" COMMAND命令
" :'<,'>EasyAlign {content} 例如：EasyAlign *= 也可以使用正则：EasyAlign */[+-]*=/ 其中输入ea<Tab>即可弹出EasyAlign
" :'<,'>LiveEasyAlign       进入实时预览的align命令模式
" align命令模式输入项
" 输入项最后以分隔符结束，默认的分隔符有：<Space> <Bar> : . , & # " =（包含：= == != += &&= 等）
" {delimiter}   ：对每行的第一个分隔符进行对齐
" 2{delimiter}  ：对每行的第二个分隔符进行对齐
" n{delimiter}  ：对每行的第n个分隔符进行对齐
" -{delimiter}  ：对每行的倒数第一个分隔符进行对齐
" -2{delimiter} ：对每行的倒数第二个分隔符进行对齐
" -n{delimiter} ：对每行的倒数第n个分隔符进行对齐
" *{delimiter}  ：对每行的所有分隔符进行对齐
" **{delimiter} ：对每行的所有分隔符进行对齐，分隔的内容成对的左右对齐，例如：name = Tom    =    age = 25
" align命令模式快捷键
" <Enter> ：切换分隔内容的对齐方式，L R C
" <Right> ：分隔符右对齐
" <Left>  ：分隔符左侧紧贴着分隔内容
" <Down>  ：分隔符右对齐，分隔符右侧紧贴着分隔内容
" Ctrl + p：切换EasyAlign的命令模式和LiveEasyAlign的命令模式
" Ctrl + x：输入自定义正则分隔符
" Ctrl + i：切换第一个分隔内容的缩进方式，keep，deep，shallow，none
" Ctrl + l：输入分隔符左侧的空格数
" Ctrl + r：输入分隔符右侧的空格数
" Ctrl + d：切换分隔符的对齐方式，L R C
" Ctrl + g：切换需要忽略的分隔符组，[]，['String']，['Comment']，['String', 'Comment']
" 高级应用
" Ctrl + v：当要对某一小块代码对齐而不是整行的时候可以块选择再ga对齐
" 使用参考：[vim-easy-align](https://github.com/junegunn/vim-easy-align)

" 插件mattn/emmet-vim自定义设置
" 只在html和css文件中启用Emmet
let g:user_emmet_install_global = 0
autocmd FileType html,css,blade,vue EmmetInstall
" 只在insert和visual模式下启用Emmet
let g:user_emmet_mode = 'iv'
" Ctrl + y + , ：触发Emmet自动生成代码
" Emmet语法参考：[Emmet Tutorial](https://raw.githubusercontent.com/mattn/emmet-vim/master/TUTORIAL)

" 插件StanAngeloff/php.vim自定义设置
" 修复类和方法在molokai主题上的显色错误
hi link phpRegion Function
" 修复注释中phpDocTag的颜色错误
hi link phpDocTags Tag
" 取消()[]{}的斜体
hi! Special guifg=#66D9EF guibg=bg gui=NONE

" 插件jwalton512/vim-blade自定义设置
" php模版引擎blade中主要还是html所以使用手动折叠
" 这样可以使用vatzf来折叠一个html标签
autocmd FileType blade setlocal foldmethod=manual

" 插件Shougo/deoplete.nvim自定义设置
" 启动neovim的时候就启动补全插件
let g:deoplete#enable_at_startup = 1
" 延迟200毫秒弹出补全菜单，开启智能大小写
call deoplete#custom#option({
            \ 'auto_complete_delay': 200,
            \ 'smart_case': v:true
            \})
" Omni提示会阻塞deoplete，所以慎用！
" PHP的Omni提示例子，[Vim正则表达式参考](http://vimregex.com/)
" call deoplete#custom#option('omni_patterns', {'php': '\w\+'})
" 修复Omni删除最后一个字母时还显示提示的Bug
" inoremap <expr> <BS> deoplete#smart_close_popup()."\<BS>"
" inoremap <expr> <C-h> deoplete#smart_close_popup()."\<BS>"

" 插件phpactor/phpactor自定义设置
augroup jiang_phpactor
  autocmd!
  " 调用phpactor的选项菜单
  autocmd FileType php nnoremap <buffer> <leader>mm :call phpactor#ContextMenu()<CR>
  " 调用phpactor的use引入菜单
  autocmd FileType php nnoremap <buffer> <leader>mp :call phpactor#UseAdd()<CR>
  " 跳转到定义处
  autocmd FileType php nnoremap <buffer> <C-]> :call phpactor#GotoDefinition()<CR>
  autocmd FileType php nnoremap <buffer> <C-\> <C-w>v:call phpactor#GotoDefinition()<CR>
augroup END

" 插件sbdchd/neoformat自定义设置
nnoremap <leader>ff :Neoformat<CR>
" :Neoformat! html ：强制使用特定的Filetype来格式化代码

" 插件vim-vdebug/vdebug自定义设置
" 在浏览器添加?XDEBUG_SESSION_START=1参数来开始调试
" 设置PHP的调试参数：端口9000，Vagrant虚拟机上文件路径和本地路径的映射。
if !exists('g:vdebug_options')
    let g:vdebug_options = {}
endif
let g:vdebug_options.port = 9000
let g:vdebug_options.path_maps = { "/vagrant/www": "/Users/jiang/program/www" }
let g:vdebug_options.break_on_open = 0
let g:vdebug_options.watch_window_style = "compact"
"  使用自定义的快捷键，覆盖vdebug的默认快捷
let g:vdebug_keymap = {
            \ "step_over": "<F2>",
            \ "step_into": "<F3>",
            \ "step_out": "<F4>",
            \ "run": "<F5>",
            \ "close": "<F6>",
            \ "run_to_cursor": "<F9>",
            \ "set_breakpoint": "<F10>",
            \ "get_context": "<F11>",
            \ "eval_under_cursor": "<F12>"
            \ }
" :BreakpointWindow 显示所有断点
nnoremap <leader>db :BreakpointWindow<CR>
" :BreakpointRemove ID/* 删除指定ID的断点/所有断点
nnoremap <leader>dd :BreakpointRemove *<CR>
" :VdebugEval <code>: 显示指定表达式的值
nnoremap <leader>de :VdebugEval<Space>
vnoremap <leader>de "ay:VdebugEval <C-r>a<CR>
" :VdebugTracd <code>: 在Tarce窗口固定显示指定表达式的值
nnoremap <leader>dw :VdebugTrace<Space>
vnoremap <leader>dw "ay:VdebugTrace <C-r>a<CR>

