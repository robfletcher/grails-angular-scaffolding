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

angular.module('flashService', []).factory('Flash', function() {
    var flash = {};

    flash.get = function(key) {
        var value = this[key];
        this[key] = undefined;
        return value;
    };

    flash.error = function(text) { this.message = {level: 'error', text: text}; };
    flash.success = function(text) { this.message = {level: 'success', text: text}; };
    flash.info = function(text) { this.message = {level: 'info', text: text}; };

    return flash;
});

angular.module('scaffolding', ['grailsService', 'flashService']).config([
    '$routeProvider',
    function($routeProvider) {
        $routeProvider.
            when('/create', {templateUrl: '/create.html', controller: CreateCtrl}).
            when('/edit/:id', {templateUrl: '/edit.html', controller: EditCtrl}).
            when('/list', {templateUrl: '/list.html', controller: ListCtrl}).
            when('/show/:id', {templateUrl: '/show.html', controller: ShowCtrl}).
            otherwise({redirectTo: '/list'});
    }
]);

function ListCtrl($scope, $routeParams, $location, Grails, Flash) {
    Grails.list($routeParams, function(list, headers) {
		$scope.list = list;
		$scope.total = parseInt(headers('X-Pagination-Total'));
		$scope.max = parseInt($routeParams.max) || 10;
		$scope.offset = parseInt($routeParams.offset) || 0;
		$scope.currentPage = Math.ceil($scope.offset / $scope.max);
		$scope.message = Flash.get('message');
	});

    $scope.show = function(item) {
        $location.path('/show/' + item.id);
    };

	$scope.pages = function() {
		var pages = [];
		for (var i = 0; i < Math.ceil($scope.total / $scope.max); i++)
			pages.push(i);
		return pages;
	};
}

function ShowCtrl($scope, $routeParams, $location, Grails, Flash) {
    $scope.message = Flash.get('message');
    Grails.get({id: $routeParams.id}, function(item) {
        $scope.item = item;
    }, function(response) {
        Flash.error(response.data.message);
        $location.path('/list');
    });

    $scope.delete = function(item) {
        item.$delete(function(response) {
            Flash.success(response.message);
            $location.path('/list');
        });
    };
}

function CreateCtrl($scope, $location, Grails, Flash) {
    $scope.item = new Grails;
    $scope.save = function(item) {
        item.$save(function(response) {
            Flash.success(response.message);
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

function EditCtrl($scope, $routeParams, $location, Grails, Flash) {
    Grails.get({id: $routeParams.id}, function(item) {
        $scope.item = item;
    }, function(response) {
        Flash.error(response.data.message);
        $location.path('/list');
    });

    $scope.update = function(item) {
        item.$update(function(response) {
            Flash.success(response.message);
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
            Flash.success(response.message);
            $location.path('/list');
        });
    };
}
