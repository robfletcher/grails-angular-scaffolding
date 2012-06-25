/**
 * A service for storing one-time messages to be displayed after redirecting to
 * another view.
 */
angular.module('flashService', []).factory('Flash', function() {
    var flash = {};

    flash.getMessage = function() {
        var value = this.message;
        this.message = undefined;
        return value;
    };

    flash.error = function(text) { this.message = {level: 'error', text: text}; };
    flash.success = function(text) { this.message = {level: 'success', text: text}; };
    flash.info = function(text) { this.message = {level: 'info', text: text}; };

    return flash;
});

/**
 * The main scaffolding module.
 */
var scaffoldingModule = angular.module('scaffolding', ['grailsService', 'flashService']);

/**
 * Route definitions connecting URL fragments to views and controllers.
 */
scaffoldingModule.config([
    '$routeProvider',
    function($routeProvider) {
        var baseUrl = $('body').data('template-url');
        $routeProvider.
            when('/create', {templateUrl: baseUrl + '/create.html', controller: CreateCtrl}).
            when('/edit/:id', {templateUrl: baseUrl + '/edit.html', controller: EditCtrl}).
            when('/list', {templateUrl: baseUrl + '/list.html', controller: ListCtrl}).
            when('/show/:id', {templateUrl: baseUrl + '/show.html', controller: ShowCtrl}).
            otherwise({redirectTo: '/list'});
    }
]);

/**
 * A directive for including a standard pagination block in the page.
 */
scaffoldingModule.directive('pagination', function() {
    return {
        restrict: 'A', // can only be used as an attribute
        transclude: false, // the element should not contain any content so there's no need to transclude
        scope: {
            total: '=total' // inherit the total property from the controller scope
        },
        controller: function($scope, $routeParams) {
            $scope.max = parseInt($routeParams.max) || 10;
            $scope.offset = parseInt($routeParams.offset) || 0;
            $scope.currentPage = Math.ceil($scope.offset / $scope.max);

            $scope.pages = function() {
                var pages = [];
                for (var i = 0; i < Math.ceil($scope.total / $scope.max); i++)
                    pages.push(i);
                return pages;
            };

            $scope.lastPage = function() {
                return $scope.pages().slice(-1)[0];
            };
        },
        templateUrl: '/ng-templates/pagination.html',
        replace: false
    }
});

function ListCtrl($scope, $routeParams, $location, Grails, Flash) {
    Grails.list($routeParams, function(list, headers) {
		$scope.list = list;
        $scope.total = parseInt(headers('X-Pagination-Total'));
        $scope.message = Flash.getMessage();
    });

    $scope.show = function(item) {
        $location.path('/show/' + item.id);
    };
}

function ShowCtrl($scope, $routeParams, $location, Grails, Flash) {
    $scope.message = Flash.getMessage();

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
        }, function(response) {
			switch (response.status) {
				case 404:
					Flash.error(response.data.message);
					$location.path('/list');
					break;
			}
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
				case 404:
					Flash.error(response.data.message);
					$location.path('/list');
					break;
				case 409:
					$scope.message = {level: 'error', text: response.data.message};
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
        }, function(response) {
			switch (response.status) {
				case 404:
					Flash.error(response.data.message);
					$location.path('/list');
					break;
			}
		});
    };
}
