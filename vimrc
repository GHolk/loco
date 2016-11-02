" gholk's vim rc

:set nocp
:set nu

:nmap Y y$
:nmap cc c^
:map! zx <Esc>

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
:map "* :r!clipit -c<CR>

:set autoindent


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


