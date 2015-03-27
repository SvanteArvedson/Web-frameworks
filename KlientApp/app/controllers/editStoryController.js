angular
	.module('clientApp')
	.controller('editStoryController', ['StoriesService', '$routeParams', function(storiesService, $routeParams) {
		var vm = this;	
		vm.story = $routeParams.id;
	}]);
