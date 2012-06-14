angular.module('albumService', ['ngResource']).factory('Album', function($resource) {
	var baseUrl = $('body').data('base-url').replace(/index$/, '');

	return $resource(baseUrl + ':action/:id', {id: '@id'}, {
		list: {method: 'GET', params: {action: 'list'}, isArray: true},
		get: {method: 'GET', params: {action: 'get'}},
		save: {method: 'POST', params: {action: 'save'}},
		update: {method: 'POST', params: {action: 'update'}},
		delete: {method: 'POST', params: {action: 'delete'}}
	});
});

angular.module('scaffolding', ['albumService']).config([
	'$routeProvider',
	function($routeProvider) {
		var baseUrl = $('body').data('base-url').replace(/index$/, '');
		$routeProvider.
			when('/create', {templateUrl: '/grails-ng/create.html', controller: CreateCtrl}).
			when('/edit/:id', {templateUrl: '/grails-ng/edit.html', controller: EditCtrl}).
			when('/list', {templateUrl: '/grails-ng/list.html', controller: ListCtrl}).
			when('/show/:id', {templateUrl: '/grails-ng/show.html', controller: ShowCtrl}).
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
		item.$delete(function(result) {
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
        item.$save(function(response) {
            // TODO: check status and display errors if not ok
            $location.path('/show/' + response.id);
        });
    };
}

function EditCtrl($scope, $routeParams, $location, Album) {
	$scope.item = Album.get({id: $routeParams.id});

	$scope.update = function(item) {
        item.$update(function(response) {
            // TODO: check status and display errors if not ok
            $location.path('/show/' + response.id);
        });
    };

	$scope.delete = function(item) {
		item.$delete(function(result) {
			if (result.status == 'ok') {
				$location.path('/list');
			} else {
				console.error(result);
			}
		});
	};
}
