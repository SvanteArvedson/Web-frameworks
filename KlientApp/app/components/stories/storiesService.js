angular
	.module('clientApp')
	.factory('StoriesService', ['$http' ,'apiConstants' ,function($http, apiConstants) {
		var storiesService = {};
		
		storiesService.get = function() {
			request = {
				method: 'GET',
				url: apiConstants.url + 'stories',
				headers: {
					'api-key': apiConstants.apiKey
				}
			};
			
			return $http(request);
		};
		
		return storiesService;
	}]);
