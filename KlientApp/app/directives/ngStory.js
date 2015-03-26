angular
	.module('clientApp')
	.directive('ngStory', function() {
		return {
			restrict: 'AE',
			require: '^ngModel',
			templateUrl: 'app/html/storyPresentation.html',
			scope: {
				ngModel: '='
			}
		};
	});
