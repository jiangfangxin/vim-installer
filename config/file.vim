" ---------- file.vim ----------
set wildmenu        " 在命令栏敲击tab会显示一个可选清单
set splitright      " 纵向打开文件显示在右侧
set splitbelow      " 横向打开文件显示在下侧
" 在新页面打开光标所在路径的文件，gf默认情况下在本页面打开需要跳转的文件，我们让它在新页面打开
nnoremap gf :vertical wincmd f<CR>

" 快速打开文件快捷键
" 在新tab页打开当前文件：Ctrl + w T
" 根据部分文件名模糊搜索当前目录下的文件，如:vs */*<partial file name><Tab>
nnoremap E :e */*
nnoremap T :tabe<CR>
nnoremap t :tabe */*
nnoremap vs :vs */*
nnoremap sp :sp */*

