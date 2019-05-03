#!/bin/sh

sed <supcj.scim "
/^UUID = /c\
UUID = 1807537d-5dd4-f567-7875-e9845a373f23
/^ICON =/c\
ICON = $HOME/.scim/user-tables/supcj-cn.png
/^NAME =/c\
NAME = supcj-cn
" | cconv -f UTF8 -t UTF8-CN
