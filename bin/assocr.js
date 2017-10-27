#!/usr/bin/env node

const child_process = require('child_process')
const getTokenCommand = 'pass show application/assocr'

const apiOption = {
    api_key: 'e6fd511f93fccd0f7c34a54055e41214',
    secret: '745849c2772c3aa9',
    user_id: '135370742@N08',
    access_token: null,
    access_token_secret: null,
    permissions: 'write'
}

class Flickrp {
    constructor() {
        this.flickrcb = require('flickrapi')
    }
    authenticate(option) {
        return new Promise((pass, fail) => {
            this.flickrcb.authenticate(
                option,
                (authError, flickr) => {
                    if (authError) fail(authError)
                    else {
                        this.api = flickr
                        pass(flickr)
                    }
                }
            )
        })
    }
    upload(uploadOption, apiOption) {
        return new Promise((done, fail) => {
            this.flickrcb.upload(
                uploadOption,
                apiOption,
                (uploadError, result) => {
                    if (uploadError) fail(uploadError)
                    else done(result)
                }
            )
        })
    }
    info(photoid) {
        return new Promise((done, fail) => {
            this.api.photos.getInfo(
                {photo_id: photoid},
                (infoError, info) => {
                    if (infoError) fail(infoError)
                    else done(info)
                }
            )
        })
    }
}

class Photo {
    constructor(path, option) {
        this.photo = path
        if (option) Object.assign(this, option)
    }
}

class EmbedInfo {
    constructor(farm, server, photo, secret) {
        this.farm = 'farm' + farm // farm%d
        this.server = server
        this.photo = photo
        this.secret = secret
        this.user = apiOption.user_id
    }
    static fromInfo(info) {
        const farm = info.farm
        const server = info.server
        const photo = info.id
        const secret = info.secret

        return new this(farm, server, photo, secret)
    }
}

const argv = require('optimist')
argv.usage('upload images to flickr.\n' +
           'Usage:\n' +
           '\tassocr --login\n' +
           '\tassocr [--group GROUP] [--tag TAG1,TAG2,...] [--album ALBUM] IMAGE ...\n')
argv.option('t', {
    alias: 'tag',
    descript: 'tag of images'
})
argv.option('a', {
    alias: 'album',
    descript: 'album images belong'
})
argv.option('g', {
    alias: 'group',
    descript: 'group images belong'
})

argv.boolean('l')
argv.option('l', {
    alias: 'login',
    descript: 'login with OAuth'
})

const option = argv.argv
const pathList = option._
const fp = new Flickrp()

if (option.l) {
    fp.authenticate(apiOption)
}
else if (pathList.length > 0) {

    const photoOption = {
        tags: ['assocr']
    }

    if (option.t) {
        option.t.split(/,/g).forEach(
            (tag) => photoOption.tags.push(tag)
        )
    }

    const photoList = pathList.map((path) => new Photo(path, photoOption))

    const token = child_process.execSync(getTokenCommand, {encoding: 'utf8'})
    const rows = token.split(/\n/g)
    rows.forEach((row) => {
        const keyValue = row.split(/\t/)
        const key = keyValue[0]
        const value = keyValue[1]
        apiOption[key] = value
    })

    const uploadOption = {
        photos: photoList
    }

    fp.upload(uploadOption, apiOption)
        .then((result) => {
            logJson(pathList)
            return result
        }).catch((authError) => {
            console.error(authError)
        }).then((photoIds) => {
            return fp.authenticate(apiOption).then(() => photoIds)
        }).catch((authError) => {
            console.error(authError)
        }).then((photoIds) => {
            const infop = photoIds.map((id) => fp.info(id))
            return Promise.all(infop)
        }).then((infos) => {
            const embedInfos = infos.map(
                (info) => EmbedInfo.fromInfo(info.photo)
            )
            logJson(embedInfos)
            process.exit()
        })
}
else {
    console.log(argv.help())
}

function logJson(object) {
    console.log(JSON.stringify(object))
}
