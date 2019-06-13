" 设置Vim自带的文件浏览器Netrw
" u：切换到最近查看的目录   i：切换查看模式树状、横向等
" %：创建文件               d：创建文件夹
" D：删除文件或目录         R：重命名文件或目录
" p：预览文件               t：新tab中打开文件
" v：竖向打开文件           o：横向打开文件
" mt -> mf -> mc（必须在源目录执行）：标记目标 -> 标记源 -> 复制文件或目录
" mt -> mf -> mm（必须在源目录执行）：标记目标 -> 标记源 -> 移动文件或目录
" mf -> md（必须在源目录执行）      ：Diff文件更改
" mF：取消标记
let g:netrw_liststyle = 3   " 目录窗口展示文件目录结构
let g:netrw_keepdir = 0     " 让Nettrw的current directory和我们正在浏览的目录一致，否则每次执行mc，mm，md等之前都要先c一下

