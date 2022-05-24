#!/usr/bin/env node
'use strict'

const helpText =
`usage:
    jquery [-p JAVASCRIPT] [-q] SELECTOR [FILE ...] [[-q SELECTOR FILE ...] ...]
    jquery -e JAVASCRIPT [FILE ...] [[-e JAVASCRIPT FILE ...] ...]
    jquery -s JAVASCRIPT [FILE ...] [[-s JAVASCRIPT FILE ...] ...]
    -p, --preload, script execute at begin
    -s, --edit, execute script once and output the html
    -q, --query, --jquery: jquery selector
    -e, --eval, --evaluate: javascript code
    -h, --help: print this help
    -t, --text: output html node text content
    -a, --all: match all selector
    -x, --xml: output xml
    -: if file is \`-\` or no file specified, read from stdin
`

const cheerio = require('cheerio').default
const process = require('process')
const fs = require('fs/promises')

function sleep(second) {
    return new Promise(wake => setTimeout(wake, second*1000))
}
function evaluateSelectScript($, script, option, context) {
    const ctx = context
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
async function *main(argv, option = {}) {
    if (argv.length == 0) {
        console.log(helpText)
        return
    }

    option.mode = 'query'
    option.firstLoop = true
    let context = {}
    let ctx = context
    do {
        let argument
        if (argv.length > 0) argument = argv.shift()
        else argument = null

        switch (argument) {
        case '-q':
        case '--query':
        case '--jquery':
            option.mode = 'query'
            option.command = argv.shift()
            continue
        case '-e':
        case '--eval':
        case '--evaluate':
            option.mode = 'script'
            option.command = argv.shift()
            continue
        case '-p':
        case '--preload':
            eval(argv.shift())
            continue
        case '-s':
        case '--edit':
            option.mode = 'edit'
            option.command = argv.shift()
            continue
        case '-a':
        case '--all':
            option.selectorMatchAll = true
            continue
        case '-t':
        case '--text':
            option.textOutput = true
            continue
        case '-h':
        case '--help':
            console.log(helpText)
            return
        case '-x':
        case '--xml':
            option.xml = true
            option.xmlMode = true
            continue
        case null:
            if (option.firstLoop) argv.push('-')
            break
        default:
            if (/^-[a-z]{2,}/.test(argument)) {
                const argumentFirst = argument.slice(0,2)
                const argumentOther = argument.slice(2)
                argv.unshift(argumentFirst, `-${argumentOther}`)
                continue
            }
            if (option.firstLoop && option.mode == 'query' && !option.command) {
                option.command = argument
                continue
            }
            else argv.unshift(argument)
        }

        // no file provide then imply input from stdin
        if (option.firstLoop) option.firstLoop = false

        while (argv.length > 0 && !/^-./.test(argv[0])) {
            const path = argv.shift()
            option.path = path
            const html = await loadFileSmart(path)
            const $ = cheerioLoadHtml(html, option)
            if (option.mode == 'query') {
                const result = querySelector($, option.command)
                if (option.selectorMatchAll) {
                    yield* result.get().map(e => $(e))
                }
                else yield result.first()
            }
            else if (option.mode == 'edit') {
                const wrap = new Function('$', 'option', option.command)
                const result = wrap($, option)
                if (result != undefined) yield result
                else yield $.html()
            }
            else yield evaluateSelectScript($, option.command, option, context)
        }
    }
    while (argv.length > 0 || option.firstLoop)
}

function cheerioLoadHtml(html, option) {
    return cheerio.load(html, option)
}
function cheerioStringify(node, option = {}) {
    if (option.textOutput) return cheerio.text(node)
    else if (option.xml) return cheerio.xml(node)
    else return cheerio.html(node)
}

if (require.main == module) {
    new Promise(async () => {
        const option = {}
        for await (const result of main(process.argv.slice(2), option)) {
            if (result?.cheerio == '[cheerio object]') {
                console.log(cheerioStringify(result, option))
            }
            else console.log(result)
        }
    })
}
else {
    exports.main = main
    exports.cheerioStringify = cheerioStringify
}
