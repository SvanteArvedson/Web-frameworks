angular
	.module('clientApp', ['ngRoute', 'ngMap'])
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
		
		/*uiGmapGoogleMapApiProvider.configure({
	        key: 'AIzaSyCSrgWJ3z9FBw0euGCh5nKXuup6X-T-J0Q',
	        v: '3.17',
	        libraries: 'weather,geometry,visualization'
	    });*/
	}]);