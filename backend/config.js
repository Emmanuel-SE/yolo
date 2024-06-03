var config = {}

// Update to have your correct username and password
config.mongoURI = {
    production: 'mongodb+srv://emmanueltiti370:1fzeGgDEE9wcIOdK@moringacluster.ntquejx.mongodb.net/?retryWrites=true&w=majority&appName=moringacluster',
    // production: process.env.mongoURI,
    development: 'mongodb://emmanueltiti370:1fzeGgDEE9wcIOdK@moringacluster.ntquejx.mongodb.net/?retryWrites=true&w=majority&appName=moringacluster',
}
module.exports = config;