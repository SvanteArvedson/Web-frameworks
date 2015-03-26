angular
	.module('clientApp')
	.factory('LoginService', ['$http' ,'apiConstants' ,function($http, apiConstants) {
		var loginService = {};
		
		/**
		 * Try to login to api. 
		 */
		loginService.login = function(email, password) {
			var url = apiConstants.url + 'authenticate';
			
			var request = {
				method: 'POST',
				url: url,
				headers: {
					'api-key': apiConstants.apiKey
				},
				data: {
					email: email,
					password: password
				}
			};
			
			return $http(request);
		};
		
		return loginService;
	}]);