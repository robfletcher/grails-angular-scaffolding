angular.module('scaffolding', []).config([
    '$routeProvider',
    function($routeProvider) {
        $routeProvider.
            when('/list', {template: '/angular-scaffolding/list.html', controller: ListCtrl}).
            otherwise({redirectTo: '/list'});
    }
]);

function ListCtrl($scope) {
    jQuery.getJSON('list', function(data) {
        $scope.$apply(function() {
            $scope.list = data;
        });
    });
}