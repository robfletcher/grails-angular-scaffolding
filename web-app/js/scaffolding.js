angular.module('albumService', ['ngResource']).factory('Album', function($resource) {
	var baseUrl = $('body').data('base-url').replace(/index$/, '');

	return $resource(baseUrl + ':action/:id', {}, {
		list: {method: 'GET', params: {action: 'list'}, isArray: true},
		show: {method: 'GET', params: {action: 'show'}},
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
			when('/list', {templateUrl: '/grails-ng/list.html', controller: ListCtrl}).
			when('/show/:id', {templateUrl: '/grails-ng/show.html', controller: ShowCtrl}).
//            when('/create', {templateUrl: '/grails-ng/create.html', controller: CreateCtrl}).
			otherwise({redirectTo: '/list'});
	}
]);

function ListCtrl($scope, $location, Album) {
	$scope.list = Album.list();

	$scope.show = function(item) {
		$location.path('/show/' + item.id);
	};
}

function ShowCtrl($scope, $routeParams, Album) {
	console.log('showing', $routeParams.id);
	$scope.item = Album.show({id: $routeParams.id});
}

//ListCtrl.$inject = ['$scope', 'Album'];

//function CreateCtrl($scope, $location, Album) {
//    $scope.save = function() {
//        Album.save($scope.album, function(album) {
//            $location.path('/list');
//        });
//    };
//}
