const { environment } = require('@rails/webpacker')
const webpack = require('webpack');

environment.plugins.prepend('Provide', new webpack.ProvidePlugin({
 $: 'jquery/src/jquery',
 jQuery: 'jquery/src/jquery',
 Popper: ['popper.js', 'default']
}));

//environment.config.merge(customConfig);

module.exports = environment
