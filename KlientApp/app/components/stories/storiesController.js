angular
	.module('clientApp')
	.controller('storiesController', ['StoriesService', 'TagsService', 'CreatorsService', function(storiesService, tagsService, creatorsService) {
		var vm = this;
		
		// For search functionality
		vm.searchVisible = true;
		vm.searchToggleText = "göm sökfältet";
		
		vm.query = "";
		
		vm.searchCreatorOptions = [
			{ label: 'Alla', value: 0 }
		];
		vm.searchCreatorValue = vm.searchCreatorOptions[0];
		
		vm.searchTagOptions = [
			{ label: 'Alla', value: 0 }
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

		// Gets all creators for select box
		creatorsService.get().then(function(data) {
			vm.searchCreatorOptions = vm.searchCreatorOptions.concat(data);
		});
		
		// Gets all tags for select box
		tagsService.get().then(function(data) {
			vm.searchTagOptions = vm.searchTagOptions.concat(data);
		});
	}]);