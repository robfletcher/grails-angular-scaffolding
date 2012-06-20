angular.module('grailsService', ['ngResource']).factory('Grails', function($resource) {
	var baseUrl = $('body').data('base-url').replace(/index$/, '');

	return $resource(baseUrl + ':action/:id', {id: '@id'}, {
		list: {method: 'GET', params: {action: 'list'}, isArray: true},
		get: {method: 'GET', params: {action: 'get'}},
		save: {method: 'POST', params: {action: 'save'}},
		update: {method: 'POST', params: {action: 'update'}},
		delete: {method: 'POST', params: {action: 'delete'}}
	});
});

angular.module('scaffolding', ['grailsService']).config([
	'$routeProvider',
	function($routeProvider) {
		$routeProvider.
			when('/create', {templateUrl: '/create.html', controller: CreateCtrl}).
			when('/edit/:id', {templateUrl: '/edit.html', controller: EditCtrl}).
			when('/list', {templateUrl: '/list.html', controller: ListCtrl}).
			when('/show/:id', {templateUrl: '/show.html', controller: ShowCtrl}).
			otherwise({redirectTo: '/list'});
	}
]).run([
	'$rootScope',
	function($rootScope) {
		$rootScope.message = {};
	}
]);

function ListCtrl($scope, $location, Grails) {
	$scope.list = Grails.list();

	$scope.show = function(item) {
		$location.path('/show/' + item.id);
	};
}

function ShowCtrl($scope, $rootScope, $routeParams, $location, Grails) {
	Grails.get({id: $routeParams.id}, function(item) {
		$scope.item = item;
	}, function(response) {
		$rootScope.message = { level: 'error', text: response.data.message };
		$location.path('/list');
	});

	$scope.delete = function(item) {
		item.$delete(function(response) {
			$location.path('/list');
		});
	};
}

function CreateCtrl($scope, $location, Grails) {
	$scope.item = new Grails;
	$scope.save = function(item) {
		item.$save(function(response) {
			$location.path('/show/' + response.id);
		}, function(response) {
			switch (response.status) {
				case 422:
					$scope.errors = response.data.errors;
					break;
			}
		});
	};
}

function EditCtrl($scope, $routeParams, $location, Grails) {
	Grails.get({id: $routeParams.id}, function(item) {
		$scope.item = item;
	}, function() {
		$location.path('/list');
	});

	$scope.update = function(item) {
		item.$update(function(response) {
			$location.path('/show/' + response.id);
		}, function(response) {
			switch (response.status) {
				case 409:
					// TODO: display optimistic lock error
					break;
				case 422:
					$scope.errors = response.data.errors;
					break;
			}
		});
	};

	$scope.delete = function(item) {
		item.$delete(function(response) {
			$location.path('/list');
		});
	};
}
