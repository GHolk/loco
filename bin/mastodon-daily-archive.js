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
        object.run({
            accessToken: config['access-token'],
            ...config
        })
    }
    async run({path, limit, uid, accessToken}) {
        process.chdir(path)
        this.init = false
        if (!this.statusDirectoryExistOrCreate()) {
            this.init = true
            console.log('initiating')
        }
        const base = 'https://g0v.social/api/v1'
        let json = ''
        let list
        do {
            json = await this.fetch(`${base}/accounts/${uid}/statuses?limit=${limit}`, {
                headers: {
                    Authorization: `Bearer ${accessToken}`
                }
            })
            list = JSON.parse(json)
            if (this.init) break
            if (this.statusExist(list[list.length-1].id)) break
            else limit += 10
            console.log(`limit ${limit}`)
        }
        while (true)

        for (const status of list) {
            if (this.statusExist(status.id)) return
            else this.statusSave(status)
        }
    }
    statusDirectoryExistOrCreate() {
        let exist = true
        try {
            fs.accessSync('status')
        }
        catch (accessError) {
            exist = false
        }
        if (exist) return true
        else {
            fs.mkdirSync('status')
            return false
        }
    }
    statusSave(status) {
        fs.writeFileSync(
            `status/${status.id}.json`, JSON.stringify(status), 'utf8'
        )
        const attachment = status['media_attachments']
        if (attachment && attachment.length > 0) {
            this.attachmentSave(status)
        }
    }
    attachmentSave(status) {
        const attachments = status.media_attachments
        const post = status.id
        fs.mkdirSync(`attachment/${post}`)
        for (const item of attachments) {
            const scan = item.url.match(/.\w+$/)
            let suffix = ''
            if (scan) suffix = scan[0]
            const file = item.id + suffix
            const curl = `wget -O attachment/${post}/${file} ${item.url}`
            const result = child_process.execSync(curl)
        }
    }
    statusExist(id) {
        try {
            fs.accessSync(`status/${id}.json`)
        }
        catch (accessError) {
            return false
        }
        return true
    }
}

if (require.main == module) MastodonArchiver.main()
else exports.MastodonArchiver = MastodonArchiver
