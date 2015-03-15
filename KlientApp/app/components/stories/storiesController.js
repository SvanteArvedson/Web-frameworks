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
		
		// Gets and display all stories
		storiesService.get().then(function(data) {
			vm.stories = data;
			console.log(vm.stories);
		});

	}]);