" alt-v for linux paste
nmap <A-v> "+gP
imap <A-v> <ESC><A-v>i

if has("gui_macvim")
  macmenu &Tools.List\ Errors key=<nop>
  nnoremap <D-l> <C-w>l
endif

