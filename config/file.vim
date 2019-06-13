" 文件操作
" 根据部分文件名模糊搜索当前目录下的文件，如:vs */*<partial file name><Tab>
set wildmenu        " 当模糊搜索文件时显示一个文件名的清单供选择
set splitright      " 在右侧打开新文件
set splitbelow      " 在下面打开文件
" 在新页面打开光标所在路径的文件，gf默认情况下在本页面打开需要跳转的文件，我们让它在新页面打开
nnoremap gf :vertical wincmd f<CR>

" For lab features, need test before use.
nnoremap t :tabe .<CR>
nnoremap vs :vs<CR>
nnoremap sp :sp<CR>

"map <C--> left tab
"map <C-=> right tab

"set guitablabel=%N\ %f
"function GuiTabLabel()
"    let label = ''
"    let bufnrlist = tabpagebuflist(v:lnum)
"
"     Add '+' if one of the buffers in the tab page is modified
"    for bufnr in bufnrlist
"        if getbufvar(bufnr, "&modified")
"            let label = '+'
"            break
"        endif
"    endfor
"
"     Append the number of windows in the tab page if more than one
"    let wincount = tabpagewinnr(v:lnum, '$')
"    if wincount > 1
"        let label .= wincount
"    endif
"    if label != ''
"        let label .= ' '
"    endif
"
"     Append the buffer name
"    return label . bufname(bufnrlist[tabpagewinnr(v:lnum) - 1])
"endfunction
"
"set guitablabel=%{GuiTabLabel()}
"
