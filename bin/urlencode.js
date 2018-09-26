#!/usr/bin/env node

const inputState = {
    decode: false,
    data: '',
    result: '',
    async parse() {
        const parameter = process.argv.slice(2)
        if (parameter[0] == '-d') {
            this.decode = true
            parameter.shift()
        }
        if (parameter.length > 0) this.data = parameter.join(' ')
        else await this.readStdin()
    },
    readStdin() {
        return new Promise(finish => {
            const stdin = process.stdin
            stdin.on('data', chunk => this.data += chunk)
            stdin.on('end', finish)
        })
    },
    decodeURL() {
        this.result = decodeURIComponent(this.data)
    },
    encodeURL() {
        this.result = encodeURIComponent(this.data)
    },
    async execute() {
        await this.parse()
        if (this.decode) this.decodeURL()
        else this.encodeURL()
        console.log(this.result.trim())
    }
}

inputState.execute()
