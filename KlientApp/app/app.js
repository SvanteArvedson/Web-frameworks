angular
	.module('clientApp', ['ngRoute', 'ngMap', 'LocalStorageModule'])
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
	}])
	.config(function(localStorageServiceProvider) {
		localStorageServiceProvider
          .setPrefix('clientApp')
          .setStorageType('sessionStorage')
          .setNotify(true, true);
	});
