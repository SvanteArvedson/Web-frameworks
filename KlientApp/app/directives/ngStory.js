angular
	.module('clientApp')
	.directive('ngStory', function() {
		return {
			restrict: 'AE',
			require: '^ngModel',
			templateUrl: 'app/html/storyView.html',
			scope: {
				ngModel: '='
			}
		};
	});
