angular
	.module('clientApp')
	.factory('StoriesService', ['$http' ,'apiConstants', '$q' ,function($http, apiConstants, $q) {
		var storiesService = {};
		
		/**
		 * Fetch all stories from api. 
		 */
		storiesService.get = function() {
			var deferred = $q.defer();
			
			var request = {
				method: 'GET',
				url: apiConstants.url + 'stories',
				headers: {
					'api-key': apiConstants.apiKey
				}
			};
			
			$http(request)
				.success(function(data, status, headers, config) {
					deferred.resolve(createStories(data.stories));
				})
				.error(function(data, status, headers, config) {
					deferred.reject("ERROR STORIES");
				});
				
			return deferred.promise;
		};
		
		/**
		 * Fetch all stories from api. 
		 */
		storiesService.search = function(query) {
			var deferred = $q.defer();
			
			var request = {
				method: 'GET',
				url: apiConstants.url + 'stories/search',
				headers: {
					'api-key': apiConstants.apiKey
				},
	            params: {
	                'query': query
	            }
			};
			
			$http(request)
				.success(function(data, status, headers, config) {
					deferred.resolve(createStories(data.stories));
				})
				.error(function(data, status, headers, config) {
					deferred.reject("ERROR STORIES");
				});
				
			return deferred.promise;
		};
		
		/**
		 * Looping through all items in rawStories and calls createStory()
		 * 
		 * @param Array rawStories All stories from api.
		 * @return Array An array with complete story objects
		 */
		function createStories(rawStories) {
			var ret = [];
			rawStories.forEach(function(element, index, array) {
				ret.push(createStory(element));
			});
			return ret;
		}
		
		/**
		 * Fetch creator information and tags for story.
		 * 
		 * @param Object story A story object
		 * @return Object A story object
		 */
		function createStory(story) {
			getCreator(story.creator).then(function(data) {
				story.creator = data;
			});
			getTags(story.tags).then(function(data) {
				story.tags = data;
			});
			return story;
		}
		
		/**
		 * Fetch creator object from api.
		 * 
		 * @param String urlToCreator
		 */
		function getCreator(urlToCreator) {
			var deferred = $q.defer();
			
			var request = {
				method: 'GET',
				url: urlToCreator,
				headers: {
					'api-key': apiConstants.apiKey
				}
			};
			$http(request)
				.success(function(data, status, headers, config) {
					deferred.resolve(data.creator);
				})
				.error(function(data, status, headers, config) {
					deferred.reject("ERROR CREATOR");
				});
			
			return deferred.promise;
		}
		
		/**
		 * Fetch tag objects from api.
		 * 
		 * @param String urlToTags
		 */
		function getTags(urlToTags) {
			var deferred = $q.defer();
			
			var request = {
				method: 'GET',
				url: urlToTags,
				headers: {
					'api-key': apiConstants.apiKey
				}
			};
			
			$http(request)
				.success(function(data, status, headers, config) {
					deferred.resolve(data.tags);
				})
				.error(function(data, status, headers, config) {
					deferred.reject("ERROR TAGS");
				});
			
			return deferred.promise;
		}
		
		return storiesService;
	}]);