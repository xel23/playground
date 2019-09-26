angular.module('component.bodymovin')
    .directive('animationBodymovin', ['bodymovin', (bodymovin) => {
        return {
            restrict: 'E',
            template: require('html-loader!../template/animation-bodymovin.html'),
            link: (scope, element, attrs) => {
                element[0].firstChild.style.width = attrs.width;
                bodymovin.loadAnimation({
                    container: element[0].firstChild,
                    renderer: 'svg',
                    loop: true,
                    autoplay: true,
                    animationData: require('../assets/' + attrs.src)
                })
            }
        }
    }]);
