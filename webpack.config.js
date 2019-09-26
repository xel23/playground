const path = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin');

module.exports = {
    mode: 'development',
    entry: {
        app: './src/index.js',
    },
    devtool: 'inline-source-map',
    devServer: {
        contentBase: './dist'
    },
    // module: {
    //     rules: [
    //         {
    //             test: /\.html$/,
    //             use: {
    //                 loader: 'html-loader'
    //             },
    //         },
    //         { test: /\.png$/, use: [ "url-loader?mimetype=image/png" ] }
    //     ]
    // },
    plugins: [
        // new CleanWebpackPlugin(),
        new HtmlWebpackPlugin({
            title: 'Output Management',
            template: 'app/index.html'
        })
    ],
    output: {
            filename: 'main.js',
            path: path.resolve(__dirname, 'dist'),
             publicPath: '/'
}
};
