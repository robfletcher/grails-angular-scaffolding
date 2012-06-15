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
]);

function ListCtrl($scope, $location, Grails) {
    $scope.list = Grails.list();

    $scope.show = function(item) {
        $location.path('/show/' + item.id);
    };
}

function ShowCtrl($scope, $routeParams, $location, Grails) {
    $scope.item = Grails.get({id: $routeParams.id});

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
    $scope.item = Grails.get({id: $routeParams.id});

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
        item.$delete(function(result) {
            if (result.status == 'ok') {
                $location.path('/list');
            } else {
                console.error(result);
            }
        });
    };
}
