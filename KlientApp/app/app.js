angular
	.module('clientApp', ['ngRoute', 'ngMap', 'LocalStorageModule', 'MessageCenterModule'])
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
			.when('/myStories', {
				templateUrl: 'app/html/myStoriesView.html',
				controller: 'storiesController',
				controllerAs: 'stories'
			})
			.when('/newStory', {
				templateUrl: 'app/html/newStoryView.html',
				controller: 'newStoryController',
				controllerAs: 'newStory'
			})
			.when('/editStory/:id', {
				templateUrl: 'app/html/editStoryView.html',
				controller: 'editStoryController',
				controllerAs: 'editStory'
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
