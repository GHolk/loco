#!/usr/bin/env node

const marked = require('marked')
const fs = require('fs')

function SuffixMap(map) {
    if (map) this.map = map
}
SuffixMap.prototype.info = function (file) {
    const scan = file.match(/\.(\w+)$/)
    if (scan) {
        const suffix = scan[1]
        const info = this.mapSuffix(suffix)
        return info(file)
    }
    else {
        const info = this.mapSuffix(undefined)
        return info(file)
    }
}
SuffixMap.prototype.mapSuffix = function (suffix) {
    let type
    const suffixMap = this.suffixMap
    if (suffixMap.hasOwnProperty(suffix)) type = suffixMap[suffix]
    else type = 'anchor'
    return this.infoBy[type]
}
const map = {}
SuffixMap.prototype.suffixMap = map

map.png = map.jpg = map.gif = map.svg = 'image'
map.pdf = map.html = 'iframe'
map.md = 'markdown'
map[undefined] = 'anchor'

const infoBy = {}
SuffixMap.prototype.infoBy = infoBy
infoBy.image = function infoImage(file) {
    return `<img src="${file}">`
}
infoBy.iframe = function infoIframe(file) {
    // return `<iframe src="${file}"></iframe>`
    return detail(file, `<iframe src="${file}"></iframe>`)
}
infoBy.markdown = function infoMarkdown(file) {
    const markdown = fs.readFileSync(file, 'utf8')
    const html = marked(markdown)
    return detail(file, html)
}
infoBy.anchor = function infoAnchor(file) {
    return `<a href="${file}">${file}</a>`
}

function detail(file, html) {
    return `
<details>
<summary>${file}</summary>
${html}
</details>
`
}

function figurify(file, html) {
    return `
<figure>
<figcaption>${file}</figcaption>
${html}
</figure>
`
}

module.exports = SuffixMap

function htmlWrap(html) {
    const head = `
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<style>
img { 
  max-width: 100%;
}
</style>
`
    const foot = '</html>'
    return head + html + foot
}
const list = fs.readdirSync('.')
const suffixMap = new SuffixMap()

console.log(htmlWrap(list.map(file => suffixMap.info(file)).join('\n')))
