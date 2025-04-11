const { environment } = require('@rails/webpacker')
const webpack = require('webpack')

// Add CSS loader
environment.loaders.append('css', {
  test: /\.css$/,
  use: ['style-loader', 'css-loader']
})

module.exports = environment 