require('angular');
angular.module('playground', [
    require('../app/component/error/error').name
])
    .controller('testCtrl', ['$scope', ($scope) => {
        $scope.name = 'Ivan';
    }]);


// console.log(require('html-loader!../app/index.html'));
