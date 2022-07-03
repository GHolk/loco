#!/usr/bin/env node

const https = require('https')
const process = require('process')
const fs = require('fs')
const child_process = require('child_process')
const util = require('util')

class MastodonArchiver {
    fetch(url, option = {}) {
        return new Promise(ok => {
            const request = https.request(url, option, res => {
                const result = []
                res.setEncoding('utf8')
                res.on('data', chunk => result.push(String(chunk)))
                res.on('end', () => ok(result.join('')))
            })
            request.end()
        })
    }
    static main() {
        const config = require('./config.json')
        const object = new this()
        object.setOption({
            accessToken: config['access-token'],
            ...config
        })
        object.run()
    }
    setOption(option) {
        this.apiUrl = 'https://g0v.social/api/v1'
        Object.assign(this, option)
        process.chdir(this.path)
    }
    async run() {
        this.init = false
        if (!this.directoryExistOrCreate('status')) {
            this.init = true
            console.log('initiating')
        }
        await this.backup(`accounts/${this.uid}/statuses`, 'status')

        if (!this.directoryExistOrCreate('favourite')) {
            this.init = true
            console.log('initiating favourite')
        }
        else this.init = false
        await this.backup('favourites', 'favourite')
    }
    async backup(apiPath, subDir) {
        const base = this.apiUrl
        let limit = this.limit
        let json = ''
        let list
        let firstStatus
        do {
            json = await this.fetch(`${base}/${apiPath}?limit=${limit}`, {
                headers: {
                    Authorization: `Bearer ${this.accessToken}`
                }
            })
            list = JSON.parse(json)
            const firstStatusCurrent = list[list.length-1]
            if (this.init) {
                if (firstStatus == firstStatusCurrent.id) break
                else firstStatus = firstStatusCurrent.id
            }
            else if (this.statusExist(firstStatusCurrent.id, subDir)) break
            limit += 10
            console.log(`limit ${limit}`)
        }
        while (true)
        console.log(`fetch first ${limit} ${subDir}`)

        for (const status of list) {
            if (this.statusExist(status.id, subDir)) break
            else this.statusSave(status, subDir)
        }
    }
    directoryExistOrCreate(name) {
        let exist = true
        try {
            fs.accessSync(name)
        }
        catch (accessError) {
            exist = false
        }
        if (exist) return true
        else {
            fs.mkdirSync(name)
            return false
        }
    }
    statusSave(status, dir) {
        fs.writeFileSync(
            `${dir}/${status.id}.json`, JSON.stringify(status), 'utf8'
        )
        const attachment = status['media_attachments']
        if (attachment && attachment.length > 0) {
            this.attachmentSave(status)
        }
    }
    attachmentSave(status) {
        const attachments = status.media_attachments
        const post = status.id
        try {
            fs.mkdirSync(`attachment/${post}`)
        }
        catch (error) {
            console.log(error)
        }
        for (const item of attachments) {
            const scan = item.url.match(/.\w+$/)
            let suffix = ''
            if (scan) suffix = scan[0]
            const file = item.id + suffix
            const curl = `wget -O attachment/${post}/${file} ${item.url}`
            const result = child_process.execSync(curl)
        }
    }
    statusExist(id, dir) {
        try {
            fs.accessSync(`${dir}/${id}.json`)
        }
        catch (accessError) {
            return false
        }
        return true
    }
}

if (require.main == module) MastodonArchiver.main()
else exports.MastodonArchiver = MastodonArchiver
