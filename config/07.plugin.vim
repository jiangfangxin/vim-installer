" ---------- plugin.vim ----------
" Vim-plug：[junegunn/vim-plug](https://github.com/junegunn/vim-plug)
" 默认放置到~/.vim/autoload/下，Vim-plug安装的插件会放到~/.vim/plugged/下
" 插件状态:PlugStatus           安装插件:PlugInstall
" 更新插件:PlugUpdate {name}    删除插件:PlugClean
" Vim-plug窗口快捷键
" S：显示所有插件的状态     R：重试安装或更新失败的任务
" U：更新选中的插件         L：加载插件
" q：关闭插件窗口

call plug#begin(g:jiang_plugin_dir)
Plug 'mhinz/vim-startify'                                                                     " 自定义vim启动页
Plug 'wsdjeg/vim-fetch'                                                                       " 支持在文件末尾添加行号和列号
Plug 'tpope/vim-fugitive', { 'do': function('Jiang_ChangeFugitive') }                         " 支持在nvim中使用Git
Plug 'airblade/vim-gitgutter', { 'on': 'GitGutterEnable' }                                    " 显示Git文件的变化
Plug 'kshenoy/vim-signature', { 'do': function('Jiang_FixSignature') }                        " 在最左侧显示marks
Plug 'vim-airline/vim-airline'                                                                " 展示更多信息的导航条
Plug 'junegunn/fzf', { 'on': ['FZF', 'Files', 'Buffers', 'Ag', 'BLines', 'Tags', 'BTags', 'Marks',
                         \  'Maps','Commits', 'BCommits', 'Commands', 'History', 'Helptags', 'Filetypes'],
                         \ 'do': function('Jiang_InstallFzf') }                               " Fzf模糊搜索
Plug 'junegunn/fzf.vim', { 'on': ['FZF', 'Files', 'Buffers', 'Ag', 'BLines', 'Tags', 'BTags', 'Marks',
                         \ 'Maps','Commits', 'BCommits', 'Commands', 'History', 'Helptags', 'Filetypes'],
                         \ 'do': function('Jiang_InstallFzfVim') }                            " Fzf功能扩展
Plug 'brooth/far.vim', { 'on': ['F', 'Far', 'Fardo'], 'do': function('Jiang_ChangeFar') }     " 多文件搜索和替换工具
Plug 'tpope/vim-eunuch', { 'on': ['Move', 'Delete', 'Chmod', 'Mkdir'] }                       " 提供Unix风格的命令行操作当前文件
Plug 'scrooloose/nerdtree', { 'do': function('Jiang_CustomNerdtree') }                        " 文件浏览器
Plug 'Xuyuanp/nerdtree-git-plugin'                                                            " 给Nerdtree目录树添加git标识
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' , 'do': function('Jiang_InstallCtags')}      " 显示对象和函数大纲
Plug 'ludovicchabant/vim-gutentags'                                                           " 自动化生成和管理tags文件
Plug 'scrooloose/nerdcommenter'                                                               " 快速注释代码
Plug 'terryma/vim-multiple-cursors'                                                           " 像Sublime那样的多光标插件
Plug 'jiangmiao/auto-pairs', { 'do': function('Jiang_AddBufMapVar') }                         " 成对添加/删除''()[]{}<>等字符
Plug 'tpope/vim-surround'                                                                     " 成对修改''()[]{}<>等字符
Plug 'easymotion/vim-easymotion', { 'on': '<Plug>(easymotion-overwin-f)' }                    " 文档内精确快速移动光标
Plug 'junegunn/vim-easy-align', { 'on': ['EasyAlign', 'LiveEasyAlign', '<Plug>(EasyAlign)'] } " 片段代码对齐工具
Plug 'mattn/emmet-vim', { 'on': 'EmmetInstall' }                                              " 快速编写HTML和CSS的插件
Plug 'StanAngeloff/php.vim', { 'for': 'php', 'do': function('Jiang_ChangePhpHighlight') }     " PHP语法支持插件
Plug 'jwalton512/vim-blade', { 'for': 'blade' }                                               " Blade模版引擎语法支持
Plug 'pangloss/vim-javascript'                                                                " Javascript语法支持插件
Plug 'posva/vim-vue', { 'for': 'vue' }                                                        " Vue模板文件的语法支持
Plug 'Shougo/deoplete.nvim', { 'do': function('Jiang_InstallDeoplete') }                      " 代码自动补全框架
Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }                                       " 具有深度学习能力的代码补全插件
Plug 'phpactor/phpactor', { 'for': 'php', 'do': function('Jiang_InstallPhpactor') }           " PHP代码补全
Plug 'kristijanhusak/deoplete-phpactor', { 'for': 'php' }                                     " 连接代码补全框架和PHP库
Plug 'sbdchd/neoformat', { 'on': 'Neoformat', 'do': function('Jiang_InstallFormatters') }     " 代码自动化格式化工具
Plug 'vim-syntastic/syntastic'                                                                " 语法错误提示
Plug 'vim-vdebug/vdebug', { 'do': function('Jiang_FixVdebug') }                               " 支持多种语言的代码调试
call plug#end()

