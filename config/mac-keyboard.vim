" ---------- mac-keyboard.vim ----------
" 针对Mac电脑键盘的绑定
" Mac键盘下，Alt + <letter>会输出一个拉丁符号
" 利用这个特点来绑定tab的切换和移动快捷键
" Alt + ]：切换下一个tab 
nnoremap ‘ gt
inoremap ‘ <ESC>gt
vnoremap ‘ <ESC>gt
" Alt + [：切换上一个tab 
nnoremap “ gT
inoremap “ <ESC>gT
vnoremap “ <ESC>gT
" Alt + 1：切换至第1个tab
nnoremap ¡ 1gt
inoremap ¡ <ESC>1gt
vnoremap ¡ <ESC>1gt
" Alt + 2：切换至第2个tab
nnoremap ™ 2gt
inoremap ™ <ESC>2gt
vnoremap ™ <ESC>2gt
" Alt + 3：切换至第3个tab
nnoremap £ 3gt
inoremap £ <ESC>3gt
vnoremap £ <ESC>3gt
" Alt + 4：切换至第4个tab
nnoremap ¢ 4gt
inoremap ¢ <ESC>4gt
vnoremap ¢ <ESC>4gt
" Alt + 5：切换至第5个tab
nnoremap ∞ 5gt
inoremap ∞ <ESC>5gt
vnoremap ∞ <ESC>5gt
" Alt + 6：切换至第6个tab
nnoremap § 6gt
inoremap § <ESC>6gt
vnoremap § <ESC>6gt
" Alt + 7：切换至第7个tab
nnoremap ¶ 7gt
inoremap ¶ <ESC>7gt
vnoremap ¶ <ESC>7gt
" Alt + 8：切换至第8个tab
nnoremap • 8gt
inoremap • <ESC>8gt
vnoremap • <ESC>8gt
" Alt + 9：切换至最后一个tab
nnoremap ª :tablast<CR>
inoremap ª <ESC>:tablast<CR>
vnoremap ª <ESC>:tablast<CR>

" Alt + 0：关闭其他Window
nnoremap º :only<CR>
inoremap º <ESC>:only<CR>a
vnoremap º <ESC>:only<CR>gv
" Alt + o（字母o）：关闭其他tab
nnoremap ø :tabonly<CR>
inoremap ø <ESC>:tabonly<CR>a
vnoremap ø <ESC>:tabonly<CR>gv

" Alt + >：当前tab往前移动一位
nnoremap ≥ :+tabmove<CR>
inoremap ≥ <ESC>:+tabmove<CR>
vnoremap ≥ <ESC>:+tabmove<CR>
" Alt + <：当前tab往后移动一位
nnoremap ≤ :-tabmove<CR>
inoremap ≤ <ESC>:-tabmove<CR>
vnoremap ≤ <ESC>:-tabmove<CR>

" Alt + '：去到下一次编辑的地方
nnoremap æ g,
inoremap æ <ESC>g,
vnoremap æ <ESC>g,
" Alt + ;：回到上一次编辑的地方 
nnoremap … g;
inoremap … <ESC>g;
vnoremap … <ESC>g;

