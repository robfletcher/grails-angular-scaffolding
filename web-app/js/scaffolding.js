angular.module('albumService', ['ngResource']).factory('Album', function($resource) {
    var baseUrl = $('body').data('base-url').replace(/index$/, '');

    return $resource(baseUrl + ':id', {id: '@id'}, {
        update: { method: 'POST' }
    });
});

angular.module('scaffolding', ['albumService']).config([
    '$routeProvider',
    function($routeProvider) {
		var baseUrl = $('body').data('base-url').replace(/index$/, '');
		$routeProvider.
            when('/list', {templateUrl: '/grails-ng/list.html', controller: ListCtrl}).
//            when('/create', {templateUrl: '/grails-ng/create.html', controller: CreateCtrl}).
            otherwise({redirectTo: '/list'});
    }
]);

function ListCtrl($scope, Album) {
    $scope.list = Album.query();
}

//ListCtrl.$inject = ['$scope', 'Album'];

//function CreateCtrl($scope, $location, Album) {
//    $scope.save = function() {
//        Album.save($scope.album, function(album) {
//            $location.path('/list');
//        });
//    };
//}
