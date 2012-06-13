angular.module('albumService', ['ngResource']).factory('Album', function($resource) {
    var baseUrl = $('body').data('base-url').replace(/index$/, '');

    return $resource(baseUrl + ':id', {id: '@id'}, {
        update: { method: 'POST' }
    });
});

angular.module('scaffolding', []).config([
    '$routeProvider',
    function($routeProvider) {
        $routeProvider.
            when('/list', {template: '/grails-ng/list.html', controller: ListCtrl}).
            when('/create', {template: '/grails-ng/create.html', controller: CreateCtrl}).
            otherwise({redirectTo: '/list'});
    }
]);

function ListCtrl($scope, Album) {
    $scope.list = Album.query();
}

function CreateCtrl($scope, $location, Album) {
    $scope.save = function() {
        Album.save($scope.album, function(album) {
            $location.path('/list');
        });
    };
}
