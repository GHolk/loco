#!/usr/bin/env node
/* usage:
 * jquery [-q] selector [file ...] [[-q selector file ...] ...]
 * jquery -e javascript [file ...] [[-e javascript file ...] ...]
 */
'use strict'

const cheerio = require('cheerio')
const process = require('process')
const fs = require('fs/promises')

function evaluateSelectScript($, script) {
    return eval(script)
}
function querySelector($, selector) {
    return $(selector)
}
async function loadStream(stream) {
    return new Promise(resolve => {
        const buffer = []
        stream.on('data', seg => buffer.push(seg))
        stream.on('end', () => resolve(buffer.join('')))
    })
}
async function loadFile(path) {
    const html = await fs.readFile(path, 'utf8')
    return html
}
async function loadFileSmart(path) {
    if (path == '-') return await loadStream(process.stdin)
    else return await loadFile(path)
}
async function *main(argv) {
    let mode = 'query'
    let firstLoop = true
    do {
        if (argv[0] == '-q') {
            argv.shift()
            mode = 'query'
        }
        if (argv[0] == '-e') {
            mode = 'script'
            argv.shift()
        }
        let command = argv[0]
        argv.shift()

        // no file provide then imply input from stdin
        if (firstLoop && argv.length == 0) {
            argv.push('-')
            firstLoop = false
        }

        while (argv.length > 0 && !/^-./.test(argv[0])) {
            const path = argv[0]
            argv.shift()
            const html = await loadFileSmart(path)
            const $ = cheerioLoadHtml(html)
            if (mode == 'query') yield querySelector($, command)
            else yield evaluateSelectScript($, command)
        }
    }
    while (argv.length > 0)
}

function cheerioLoadHtml(html) {
    return cheerio.load(html)
}
function cheerioStringify(node) {
    return cheerio.html(node, {keepNonAscii: true})
}

if (require.main == module) {
    new Promise(async () => {
        for await (const result of main(process.argv.slice(2))) {
            if (result instanceof cheerio) {
                console.log(cheerioStringify(result))
            }
            else console.log(result)
        }
    })
}
