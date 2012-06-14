angular.module('albumService', ['ngResource']).factory('Album', function($resource) {
	var baseUrl = $('body').data('base-url').replace(/index$/, '');

	return $resource(baseUrl + ':action/:id', {id: '@id'}, {
		list: {method: 'GET', params: {action: 'list'}, isArray: true},
		get: {method: 'GET', params: {action: 'get'}},
		save: {method: 'POST', params: {action: 'save'}},
		update: {method: 'POST', params: {action: 'update'}},
		remove: {method: 'POST', params: {action: 'delete'}}
	});
});

angular.module('scaffolding', ['albumService']).config([
	'$routeProvider',
	function($routeProvider) {
		var baseUrl = $('body').data('base-url').replace(/index$/, '');
		$routeProvider.
			when('/list', {templateUrl: '/grails-ng/list.html', controller: ListCtrl}).
			when('/show/:id', {templateUrl: '/grails-ng/show.html', controller: ShowCtrl}).
            when('/create', {templateUrl: '/grails-ng/create.html', controller: CreateCtrl}).
			otherwise({redirectTo: '/list'});
	}
]);

function ListCtrl($scope, $location, Album) {
	$scope.list = Album.list();

	$scope.show = function(item) {
		$location.path('/show/' + item.id);
	};
}

function ShowCtrl($scope, $routeParams, $location, Album) {
	$scope.item = Album.get({id: $routeParams.id});

	$scope.delete = function(item) {
		Album.remove(item, function(result) {
			if (result.status == 'ok') {
				$location.path('/list');
			} else {
				console.error(result);
			}
		});
	};
}

function CreateCtrl($scope, $location, Album) {
    $scope.item = new Album;
    $scope.save = function(item) {
        item.$save(function(album) {
            // TODO: check status and display errors if not ok
            $location.path('/show/' + album.id);
        });
    };
}
