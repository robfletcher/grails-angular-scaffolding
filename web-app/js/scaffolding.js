angular.module('albumService', ['ngResource']).factory('Album', function($resource) {
	var baseUrl = $('body').data('base-url').replace(/index$/, '');

	return $resource(baseUrl + ':action/:id', {}, {
		list: {method: 'GET', params: {action: 'list'}, isArray: true},
		show: {method: 'GET', params: {action: 'show', id: '@id'}},
		save: {method: 'POST', params: {action: 'save'}},
		update: {method: 'POST', params: {action: 'update', id: '@id'}},
		delete: {method: 'POST', params: {action: 'delete', id: '@id'}}
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
	$scope.list = Album.list();
}

//ListCtrl.$inject = ['$scope', 'Album'];

//function CreateCtrl($scope, $location, Album) {
//    $scope.save = function() {
//        Album.save($scope.album, function(album) {
//            $location.path('/list');
//        });
//    };
//}
