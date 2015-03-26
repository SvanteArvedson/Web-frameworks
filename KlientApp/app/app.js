angular
	.module('clientApp', ['ngRoute', 'ngMap', 'LocalStorageModule'])
	.config(['$routeProvider', '$locationProvider', function($routeProvider, $locationProvider) {
		$routeProvider
			.when('/', {
				templateUrl: 'app/html/storiesView.html',
				controller: 'storiesController',
				controllerAs: 'stories'
			})
			.when('/login', {
				templateUrl: 'app/html/loginView.html',
				controller: 'loginController',
				controllerAs: 'login'
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
