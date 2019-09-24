// const express = require('express');
// const app = express();
//
// const port = 3000;
//
// app.listen(port, () => console.log(`Example app listening on port ${port}!`));
//
// app.use('/', express.static('app'));

require('angular');
angular.module('playground', [
    require('../app/component/bodymovin').name
])
    .controller('testCtrl', ['$scope', ($scope) => {
        $scope.name = 'Ivan';
    }]);
