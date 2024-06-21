import {Server} from '@hocuspocus/server'
import {SQLite} from '@hocuspocus/extension-sqlite'

const server = Server.configure({
    port: 443,
    ssl: {
        key: '/etc/letsencrypt/live/live.jot.dog/privkey.pem',
        cert: '/etc/letsencrypt/live/live.jot.dog/fullchain.pem'
    },

    async onConnect() {
        console.log('Running server.')
    },

    extensions: [
        new SQLite({
            database: 'db.sqlite',
        }),
    ],
})

server.listen()