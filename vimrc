" gholk's vim rc

" highlight style
":colorscheme desert

:set nocp
":set number

:nmap Y y$
:nmap cc c^

:map! <C-B> <Left>
:map! <C-F> <Right>
:map! <C-e> <End>
:map! <C-a> <Home>


" use space instead tab
:set tabstop=4
:set expandtab

" use abbr for my site "
:abbr myweb~ myweb.ncku.edu.tw/~c34031328/ 

" use star dict console version "
:nmap K :!sdcv 
"
":nmap \m :!markdown

" use clipit "
:map "* :r !xsel -ob<CR>

:set autoindent
:set tabstop=4
:set shiftwidth=4


" ez HTML sup sub
"qs:s#_\([^ ^]\+\)#<sub>\1</sub>#g
":s#^\([^ _]\+\)#<sup>\1</sup>#g
"q

" format MathML
"qf:s# column[^>]*##g
":s#<math>#<math display="block">#
":s#</mn><mn>##g
":s#<.\{,50}>#&\r#g
"}I	<ESC>xq

" call remove tab and call eqn to MathML
"qq:!tr -d '\t' | eqn -T MathML
"q

" use pathogen for coffee script
"call pathogen#infect()
"syntax enable
"filetype plugin indent on
" use easy zip archive from vim.org instead.
" https://github.com/kchmck/vim-coffee-script#install-from-a-zip-file

