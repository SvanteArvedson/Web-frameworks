angular
	.module('clientApp')
	.controller('storiesController', ['StoriesService', function(storiesService) {
		var vm = this;
		
		// For search functionality
		vm.searchVisible = true;
		vm.searchToggleText = "göm sökfältet";
		
		vm.query = "";
		vm.searchCreatorOptions = [
			{ label: 'Alla1', value: 0 },
			{ label: 'Alla2', value: 1 },
			{ label: 'Alla3', value: 2 },
			{ label: 'Alla4', value: 3 },
			{ label: 'Alla5', value: 4 }
		];
		vm.searchCreatorValue = vm.searchCreatorOptions[0];
		vm.searchTagOptions = [
			{ label: 'Alla', value: -1 }
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