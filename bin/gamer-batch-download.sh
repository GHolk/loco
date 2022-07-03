#!/bin/sh

gamer_download() {
    local url="$1"
    local page_list
    page_list="$(
        curl "$url" | gamer_page_list | tac | tee urllist | grep "^http"
    )"

    local i=1
    for page in $page_list
    do 
        (
            chapter=`printf ch-%02d $i`
            mkdir $chapter
            cd $chapter
            curl $page | gamer_image_list |
                wget -i - --no-use-server-timestamps --wait=2 
            rename-date -p *
        )
        i=$((i+1))
    done
}

gamer_image_list() {
    jquery -e '$(".MSG-list8C img").map((i, e) => $(e).attr("data-src")).get().join("\n")'
}

gamer_image_list_2021() { 
    jquery -e '$("img.gallery-image").map((i, e) => $(e).attr("src")).get().join("\n")'
}

gamer_page_list() {
    jquery -e '$("h1 .TS1").map((i,e) => "# " + $(e).text() + "\n" + "https://home.gamer.com.tw/" + $(e).attr("href") + "\n").get().join("\n")'
}
gamer_page_list_2021() { 
    jquery -e '$("a.HOME-mainbox2a").map((i,e) => "# " + $(e).text() + "\n" + "https://home.gamer.com.tw/" + $(e).attr("href") + "\n").get().join("\n")'
}

gamer_page_search() {
    local owner="$1"
    shift
    local keyword
    keyword=`urlencode "$*"`
    curl "https://home.gamer.com.tw/search.php?kw=$keyword&owner=$owner"
}

