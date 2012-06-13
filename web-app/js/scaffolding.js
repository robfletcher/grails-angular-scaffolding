angular.module('scaffolding', []).config([
    '$routeProvider',
    function($routeProvider) {
        $routeProvider.
            when('/list', {template: '/grails-ng/list.html', controller: ListCtrl}).
            otherwise({redirectTo: '/list'});
    }
]);

function ListCtrl($scope) {
    $scope.baseUrl = $('body').data('base-url').replace(/index$/, '');

    jQuery.getJSON($scope.baseUrl + 'list', function(data) {
        $scope.$apply(function() {
            $scope.list = data;
        });
    });
}