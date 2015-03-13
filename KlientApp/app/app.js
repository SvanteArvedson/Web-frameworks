angular
	.module('clientApp', ['ngRoute'])
	.config(['$routeProvider', '$locationProvider', function($routeProvider, $locationProvider) {
		$routeProvider
			.when('/', {
				templateUrl: 'app/components/stories/storiesView.html',
				controller: 'storiesController',
				controllerAs: 'stories'
			})
			.otherwise({
          		redirectTo: '/'
        	});
		$locationProvider.html5Mode(true);
	}]);