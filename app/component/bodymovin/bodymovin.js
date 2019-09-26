module.exports = angular.module('component.bodymovin', [])
    .constant('bodymovin', require('lottie-web'));

require('./directive/animation-bodymovin');
