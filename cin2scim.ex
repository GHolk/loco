" usage: ex -S cin2scim.ex supcj.scim
"
" edit supcj.scim
" read chardef from supcj.cin

/BEGIN_TABLE/+1, /END_TABLE/-1 d
/BEGIN_TABLE/ r supcj.cin
/BEGIN_TABLE/+1,/%chardef begin/ d
/%chardef end/ d
g/^#\{1,2}[^#]/d
g/^$/d
/BEGIN_TABLE/,$ s/\(.\) /\1\t/
wq
