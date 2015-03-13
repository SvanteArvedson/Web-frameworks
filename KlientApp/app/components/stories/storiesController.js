angular
	.module('clientApp')
	.controller('storiesController', ['StoriesService', function(storiesService) {
		var vm = this;
		
		// For search functionality
		vm.searchVisible = true;
		vm.searchToggleText = "göm sökfältet";
		
		vm.toggleSearch = function() {
			vm.searchVisible = !vm.searchVisible;
			if (vm.searchVisible) {
				vm.searchToggleText = "göm sökfältet";
			} else {
				vm.searchToggleText = "visa sökfältet";
			}
		};
		
		// Starts by getting all stories
		storiesService.get()
			.success(function(data, status, headers, config) {
				console.log("SUCCESS");
				console.log(data);
				console.log(status);
				console.log(headers());
				console.log(config);
			})
			.error(function(data, status, headers, config) {
				console.log("ERROR");
				console.log(data);
				console.log(status);
				console.log(headers());
				console.log(config);
			});
		
	}]);
	
