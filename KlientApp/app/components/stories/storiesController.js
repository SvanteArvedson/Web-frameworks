angular
	.module('clientApp')
	.controller('storiesController', ['StoriesService', function(storiesService) {
		var vm = this;
		
		// For search functionality
		vm.searchVisible = true;
		vm.searchToggleText = "göm sökfältet";
		
		vm.query = "";
		vm.searchCreatorOptions = [
			{ name: 'Alla', id: -1 }
		];
		vm.searchCreatorValue = vm.searchCreatorOptions[0];
		vm.searchTagOptions = [
			{ name: 'Alla', id: -1 }
		];
		vm.searchTagValue = vm.searchTagOptions[0];
		
		vm.toggleSearch = function() {
			vm.searchVisible = !vm.searchVisible;
			if (vm.searchVisible) {
				vm.searchToggleText = "göm sökfältet";
			} else {
				vm.searchToggleText = "visa sökfältet";
			}
		};
		
		vm.searchStories = function() {
			if (vm.query) {
				storiesService.search(vm.query).then(function(data) {
					vm.stories = data;
				});
			}
		};
		
		// Gets and display all stories
		storiesService.get().then(function(data) {
			vm.stories = data;
		});

	}]);