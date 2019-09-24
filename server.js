const express = require('express');
const webpack = require('webpack');

const app = express();
const config = require('./webpack.config.js');
webpack(config);


app.listen(3000, function () {
    console.log('Example app listening on port 3000!\n');
});

console.log('ok server');
