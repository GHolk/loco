
# loco: 我的 linux 配置 #

這個 git 是我的 linux 使用 CLI 時的設定檔，
像 bashrc 、 vimrc 、 inputrc ；
另外還有一些小腳本和 man page 。

基本上看到就知道怎麼處理了 (x　
像 rc 們就加上點丟到家目錄，
腳本就看要把 loco 加入 PATH 或 ln 到 `~/.local/bin` 。
man page 就複製放到 mappath 。


## 上標倉頡 supcj ##

這是我自己客製化的倉頡，從 [泰瑞倉頡][terry] 改來的，
泰瑞倉頡又是從 [亂倉打鳥][newcj] 改來的。
我也自己取了個名字，雖然我後來覺得有點太自大了；
因為和泰倉比起我改的很少。

幾乎所有的改動都是用註解達成，也都會說明；
所以從底部看上去就是一次次的改動記錄。

[terry]: http://terryhung.pixnet.net/blog/post/25102388 "泰瑞的部落格"
[newcj]: http://hyperrate.com/thread.php?tid=5775 "目前寄居在 gcin 的論壇裡"

### 關於 cin 格式 ###

我是使用 `*.cin` 格式，這是台灣之前一次輸入法開發者聚會後，
討論出來的共通格式。
因為台灣的輸入法曾經很活躍，之間需要一個共通的格式交流。
港澳人太少，中國當時尚為蠻荒之地。

 - 以 `#` 開頭的行是註釋。
 - 以 `%` 開頭的行的指令。
 - 其它行是字符對應。由一串字元、空白鍵、再一串字元組成。


字符對應是輸入法最要的部份。
輸入開頭的一串字元，再按空白鍵，就會輸出後面的一串字元。
有些軟體空白後只能接受一個字元，不是一串。這點沒有規定。
其實我也沒有看過討論結果，這些都是猜的。
我只有看過 cin 檔 XD　
如果有誰看過，歡迎通知；我也很好奇。

接受 cin 格式的輸入法不少。
其中，我也不是特別喜歡 [gcin][] ，只是她在 linux 上普及度不錯，
開發者也很認真。（一人開發 XD ）

[gcin]: http://hyperrate.com/dir.php?eid=67


 - 奇摩輸入法：windows 下的軟體。這傢伙幾乎被放生了，但蠻多人喜歡用的。
 - 香草輸入法：macOS 的中文輸入法，也有 fork 到 windows 。
 - gcin：我正在用。
 - PIME：不確定……，應該可以吧？有泰瑞倉頡。 P is for python. 


以 gcin 來說，要使用 cin 要用 gcin 內的工具：
gcin2tab 把 cin 檔轉換成 gcin 內部的格式，
生出一個 supcj.gtab 檔，把她放到 
`/usr/share/gcin/table` 下就好了。


## markdown 客制化版本 ##

這是所有腳本中最大的一個，
由 John Gurber 的原始版本 perl markdown 改來的。
加了許多我自己需要的功能。
但我其實對 perl 也沒有很在行，
原始版本的也沒有全部看懂，就隨便亂改。
所以產生了一些 bug 。


### obml-parser.py ###

這個 python 腳本可以將 opera mini 
內部的格式： *obml* 轉換成 html 。
是來複製自 [grawity][] 的 [obml-parser.py][] . 
詳細可以參考我寫的 [obml-parser 使用方法][obml_man] 。

[grawity]: http://github.com/grawity/
[obml-parser.py]: https://github.com/grawity/hacks/blob/master/hacks/Text/obml-parser
[obml_man]: https://github.com/GHolk/escape/blob/master/diary/obml.markdown


### index.sh ###

這個 shell 腳本可以產生 index.html ，
大略讓你可以用瀏覽器，知道現在目錄下有什麼。

 1. 一開始是只有一個，會把圖檔自動轉成 `<img>` 標籤，
    其它轉成超連結。

 2. 現在是會先去找該目錄下的 `index.sh` ，
    如果有就用，然後把結果輸出到 `index.html` 。



### groff charactor ###

*i use html to write report.*
so i need some tool to rendering equation. 
i use **eqn** of **troff** . `eqn -T MathML < eqn.txt `
can genrate MathML from eqn. 

but spetial charator in troff is too odd
to remember, so I find this manual from
ubuntus forum and install it. 


### html entity ###

so do groff charactor. 
but this is done by myself; 
[copy and paste from wikipedia. ][entity-wiki]

[entity-wiki]: https://en.wikipedia.org/wiki/List_of_XML_and_HTML_character_entity_references

