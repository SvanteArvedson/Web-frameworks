angular
	.module('clientApp')
	.controller('loginController', ['LoginService', 'localStorageService', '$location', '$rootScope', function(loginService, localStorage, $location, $rootScope) {
		var vm = this;
		var keySessionStorage = "authToken";
		
		$rootScope.isLoggedIn = false;
		
		// for login form
		vm.email = "";
		vm.password = "";
		vm.login = function() {
			loginService.login(vm.email, vm.password)
				.success(function(data, status, headers, config) {
					console.log($rootScope.isLoggedIn);
					$rootScope.isLoggedIn = true;
					// redirect to home
					$location.path('/');
				})
				.error(function(data, status, headers, config) {
					console.log(data);
				});
		};
		
		vm.logout = function() {
			localStorage.remove(keySessionStorage);
			$rootScope.isLoggedIn = false;
		};
		
		/**
		 * Checks if authToken exists and is valid. 
		 */
		 /*function checkAuthToken() {
			var authToken = localStorage.get(keySessionStorage);
			if (authToken && Date.now() <= Date.parse(authToken.terminates_at)) {
				$rootScope.isLoggedIn = true;
			} else {
				$rootScope.isLoggedIn = false;
			}
			
			return $rootScope.isLoggedIn;
		};*/
	}]);
