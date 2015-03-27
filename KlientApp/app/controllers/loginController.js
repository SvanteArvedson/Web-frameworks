angular
	.module('clientApp')
	.controller('loginController', ['LoginService', 'localStorageService', '$location', '$rootScope', 'messageCenterService', function(loginService, localStorage, $location, $rootScope, messageCenterService) {
		var vm = this;
		var keyAuthToken = "authToken";
		
		// for checking if logged in
		$rootScope.isLoggedIn = checkAuthToken();
		
		// for alert message
		vm.visibleAlert = false;
		vm.alertMessage = "";
		
		// for login form
		vm.email = "";
		vm.password = "";
		vm.login = function() {
			loginService.login(vm.email, vm.password)
				.success(function(data, status, headers, config) {
					localStorage.set(keyAuthToken, data);
					$rootScope.isLoggedIn = true;
					messageCenterService.add('info', 'Du är inloggad', { status: messageCenterService.status.permanent });
					// redirect to home
					$location.path('/');
				})
				.error(function(data, status, headers, config) {
					vm.visibleAlert = true;
					vm.alertMessage = "Felaktig epostadress och/eller lösenord.";
				});
		};
		vm.logout = function() {
			localStorage.remove(keyAuthToken);
			$rootScope.isLoggedIn = false;
			messageCenterService.add('info', 'Du är utloggad', { status: messageCenterService.status.permanent });
		};
		
		/**
		 * Checks if authToken exists and is valid. 
		 */
		 function checkAuthToken() {
			var authToken = localStorage.get(keyAuthToken);
			return (authToken && Date.now() <= Date.parse(authToken.terminates_at));
		};
	}]);
