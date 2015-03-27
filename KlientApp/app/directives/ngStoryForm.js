angular
	.module('clientApp')
	.directive('ngStoryform', function() {
		return {
			restrict: 'AE',
			templateUrl: 'app/html/storyForm.html',
			require: '?ngModel',
			scope: {
				ngModel: '='
			},
			controller: ['$scope', '$http', 'apiConstants', 'localStorageService', 'messageCenterService', '$location', 'StoriesService', '$routeParams', function($scope, $http, apiConstants, localStorage, messageCenter, $location, storiesService, $routeParams) {
				$scope.visibleAlert = false;
				$scope.alertMessage = "";
				
				$scope.getStory = function() {					
					storiesService.getById($routeParams.id).then(function(data) {
						$scope.story = data;
					});
				};
				
				$scope.submitForm = function() {
					var method = ($scope.story.id == 0) ? "POST" : "PUT";
					var url = ($scope.story.id == 0) ? apiConstants.url + "stories" : apiConstants.url + "stories/" + $scope.story.id;
					var authToken = localStorage.get("authToken").auth_token;

					var request = {
						method: method,
						url: url,
						headers: {
							'api-key': apiConstants.apiKey,
							'auth-token': authToken
						},
						data: {
							name: $scope.story.name,
							description: $scope.story.description,
							latitude: $scope.story.position.latitude,
							longitude: $scope.story.position.longitude
						}
					};
					
					$http(request)
						.success(function(data, status, headers, config) {
							messageCenter.add('success', 'Berättelsen skapades/redigerades.', { status: messageCenter.status.permanent });
							// redirect to my stories
							$location.path('/myStories');
						})
						.error(function(data, status, headers, config) {
							$scope.visibleAlert = true;
							$scope.alertMessage = "Ett fel inträffade.";
						});
				};
			}],
			link: function($scope, element, attribute, ngModelController) {
				if (ngModelController) {
					$scope.getStory();
				} else {
					$scope.story = { id: 0, name: "", description: "", position: { latitude: 0, longitude: 0 }};
				}
				
				element.on('submit', function(event) {
					event.preventDefault();
					$scope.submitForm();
				});
			}
		};
	});
