" ---------- file.vim ----------
set wildmenu        " 在命令栏敲击tab会显示一个可选清单
set splitright      " 纵向打开文件显示在右侧
set splitbelow      " 横向打开文件显示在下侧

" 在输入状态下，使用Ctrl + r组合其他键可以完成自动输入
" Ctrl + r + %          ：输出当前文件完整路径
" Ctrl + r + =          ：输出表达式计算后的结果或者函数调用的结果
" Ctrl + r + "/0~9/+/*等：输出指定寄存器中的内容

" 复制当前文件的相对路径
nnoremap <leader>yy :let @*='<C-r>=expand("%") .":". line(".") .":". col(".")<CR>'<CR>
" 复制当前文件的绝对路径
nnoremap <leader>yp :let @*='<C-r>=expand("%:p") .":". line(".") .":". col(".")<CR>'<CR>

" 跳转到光标所在位置的tag, 只存在normal模式
" 针对不同的编程语言文件中, 可以覆盖这两个跳转到定义的操作
" Ctrl + ]: 在当前窗口中, 打开光标处tag
" Ctrl + \: 在纵向窗口中, 打开光标处tag
nnoremap <C-\> <C-w>v<C-]>
" Ctrl + t: 跳转回来

" 在新页面打开光标所在路径或链接，gf默认情况下在本页面打开需要跳转的文件，我们让它在新页面打开
nnoremap gf :vertical wincmd f<CR>
vnoremap gf "ay:call Jiang_GoToFilePath(@a)<CR>
function Jiang_GoToFilePath(file)
    if filereadable(a:file)
        execute "vs " . a:file
    else
        echohl ErrorMsg " 设置随后echo输出的配色
        echo 'E447: 在路径中找不到文件 "' . a:file . '"'
        echohl None     " 关闭echo配色
    endif
endf
" gF: 跳转到光标所在路径, 包括行号和列号, 由插件wsdjeg/vim-fetch提供的功能
" gx：用系统软件(如:浏览器/Office/图片查看器等), 打开光标所在路径或链接

" nvim自带的文件模糊搜索方式
" 例如输入:tabe **/*file<Tab>   弹出选项有：config/plugin.vim  init.vim  install.sh  pluginManager/
" 如果要打开所有匹配的文件可以输入:tabe config/*，然后在COMMAND栏Ctrl + a会自动补上所有匹配的文件打开文件

" 当前窗口浏览文件
nnoremap <leader>e :e .<CR>
" 新建横向文件浏览页
nnoremap <leader>s :sp .<CR>
" 新建纵向文件浏览页
nnoremap <leader>v :vs .<CR>
" 新建文件浏览的标签页
nnoremap <leader>t :tabe .<CR>
" 新建空白的标签页
nnoremap <leader>T :tabe<CR>

" 在当前窗口打开当前文件
nnoremap <leader>fe :e %<CR>
" 在横向窗口打开当前文件
nnoremap <leader>fs :sp<CR>
" 在纵向窗口打开当前文件
nnoremap <leader>fv :vs<CR>
" 在新tab页打开当前文件：Ctrl + w T
" 在新tab页复制当前文件
nnoremap <silent> <leader>fT :tabe <C-r>=expand('%') .':'. line('.') .':'. col('.')<CR><CR>

" 回到上一个buffer
nnoremap <silent> <leader>bp :e #<CR>

" 对比两个文件的差异，在当前文件的COMMAND栏输入要diff的文件
" :diffsplit {file-path}
" internal,filler是默认项，我主要添加了vertical让默认的diff为纵向
set diffopt=internal,filler,vertical

