" ---------- plugin.vim ----------
" Vim-plug：[junegunn/vim-plug](https://github.com/junegunn/vim-plug)
" 默认放置到~/.vim/autoload/下，Vim-plug安装的插件会放到~/.vim/plugged/下
" 插件状态:PlugStatus
" 安装插件:PlugInstall
" 删除插件:PlugClean
call plug#begin('~/.vim/plugged')
Plug 'terryma/vim-multiple-cursors'     " 像Sublime那样的多光标插件
Plug 'rking/ag.vim'                     " 文件夹内快速搜索字符，需要系统安装命令行brew/apt install the_silver_searcher
Plug 'StanAngeloff/php.vim'             " PHP语法支持插件
Plug 'pangloss/vim-javascript'          " Javascript语法支持插件
call plug#end()

" 插件terryma/vim-multiple-cursors的自定义设置：
" 设置Ctrl + k用于全选匹配 
let g:multi_cursor_select_all_word_key = '<C-k>'
" 退出visual模式时不退出多光标模式
let g:multi_cursor_exit_from_visual_mode = 0
" 退出insert模式时不退出多光标模式
let g:multi_cursor_exit_from_insert_mode = 0
" 在使用多光标模式的时候自动禁用我的SmartEnter映射，有冲突
function! Multiple_cursors_before()
    iunmap <CR>
endfunction
function! Multiple_cursors_after()
    inoremap <CR> <C-r>=SmartEnter()<CR>
endfunction

" 插件StanAngeloff/php.vim的自定义设置：
" 修复类和方法在molokai主题上的显色错误
hi link phpRegion Function
" 修复注释中phpDocTag的颜色错误
hi link phpDocTags Tag

