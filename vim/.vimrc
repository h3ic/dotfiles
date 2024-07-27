imap jj <Esc>
inoremap <S-Tab> <Esc>la
inoremap <C-e> <C-o>A
set novisualbell
set noerrorbells
set tabstop=2
set shiftwidth=2
set expandtab
	
"leave yanked text in buffer after pasting
xnoremap <leader>p \_dP

"toggle rel and abs numbers when switching modes
:set nu
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
:  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
:augroup END

nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

