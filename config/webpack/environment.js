const { environment } = require('@rails/webpacker')

module.exports = environment
process.env.NODE_OPTIONS = "--openssl-legacy-provider";