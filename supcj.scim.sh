#!/bin/sh

cat <<SCIM_TEMPLATE
SCIM_Generic_Table_Phrase_Library_TEXT
VERSION_1_0
### Begin Table definition.
BEGIN_DEFINITION
UUID = b1c97690-e247-cf19-37ba-6a2b59721d9c
SERIAL_NUMBER = 20170730
ICON = $HOME/.scim/user-tables/supcj.png
NAME = supcj
NAME.zh_CN = 上標倉頡
NAME.zh_HK = 上標倉頡
NAME.zh_TW = 上標倉頡
LANGUAGES = zh_TW,zh_HK,zh_CN,zh_SG
AUTHOR = gholk
STATUS_PROMPT = 槍
KEYBOARD_LAYOUT = US_Default
VALID_INPUT_CHARS = ',./;[\]abcdefghijklmnopqrstuvwxyz
### KEY_END_CHARS =
SINGLE_WILDCARD_CHAR = ?
MULTI_WILDCARD_CHAR = *
SPLIT_KEYS = apostrophe
COMMIT_KEYS = space
FORWARD_KEYS = Return
SELECT_KEYS = 1,2,3,4,5,6,7,8,9,0
PAGE_UP_KEYS = Page_Up,less
PAGE_DOWN_KEYS = Page_Down,greater
### MODE_SWITCH_KEYS =
### FULL_WIDTH_PUNCT_KEYS =
### FULL_WIDTH_LETTER_KEYS =
MAX_KEY_LENGTH = 5
SHOW_KEY_PROMPT = FALSE
AUTO_SELECT = FALSE
AUTO_WILDCARD = TRUE
AUTO_COMMIT = FALSE
AUTO_SPLIT = TRUE
AUTO_FILL = FALSE
DISCARD_INVALID_KEY = FALSE
DYNAMIC_ADJUST = FALSE
ALWAYS_SHOW_LOOKUP = FALSE
USE_FULL_WIDTH_PUNCT = FALSE
DEF_FULL_WIDTH_PUNCT = FALSE
USE_FULL_WIDTH_LETTER = FALSE
DEF_FULL_WIDTH_LETTER = FALSE
BEGIN_CHAR_PROMPTS_DEFINITION
' 、
* *
, ，
. 。
/ ？
; ；
[ [
\ ＼
] ]
` `
a 日
b 月
c 金
d 木
e 水
f 火
g 土
h 竹
i 戈
j 十
k 大
l 中
m 一
n 弓
o 人
p 心
q 手
r 口
s 尸
t 廿
u 山
v 女
w 田
x 難
y 卜
z 重
END_CHAR_PROMPTS_DEFINITION
END_DEFINITION
SCIM_TEMPLATE

echo BEGIN_TABLE
sed -nE <supcj.cin '
/^%chardef begin$/,/^%chardef end$/ {
    /^%/d
    s/#+/###/
    /^#/! s/ /\t/
    p
}'

echo END_TABLE

