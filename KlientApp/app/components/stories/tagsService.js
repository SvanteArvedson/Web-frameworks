angular
	.module('clientApp')
	.factory('TagsService', ['$http' ,'apiConstants', '$q', 'localStorageService' ,function($http, apiConstants, $q, localStorage) {
		var tagsService = {};
		
		/**
		 * Fetch all tags from api. 
		 */
		tagsService.get = function() {
			var url = apiConstants.url + 'tags';
			var dataFromStorage = localStorage.get(url);
			var deferred = $q.defer();
			
			// stale after 30 minutes
			if (dataFromStorage && dataFromStorage.timestamp >= Date.now() - 1800000) {
				deferred.resolve(createTags(dataFromStorage.data.tags));
			} else {
				var request = {
					method: 'GET',
					url: url,
					headers: {
						'api-key': apiConstants.apiKey
					}
				};
				$http(request)
					.success(function(data, status, headers, config) {
						dataToStorage = { timestamp: Date.now(), data: data };
						localStorage.set(url, dataToStorage);
						deferred.resolve(createTags(data.tags));
					})
					.error(function(data, status, headers, config) {
						deferred.reject("ERROR TAGS");
					});
			}

			return deferred.promise;
		};
		
		/**
		 * Creates a list of tag objects.
		 * 
		 * @param Object rawTags
		 */
		function createTags(rawTags) {
			var ret = [];
			rawTags.forEach(function(element, index, array) {
				ret.push(createTag(element));
			});
			return ret;
		};
		
		/**
		 * Create a tag object.
		 * 
		 * @param Object rawTag
		 */
		function createTag(rawTag) {
			return {
				id: rawTag.id,
				name: rawTag.name,
				createdAt: rawTag.created_at,
				updatedAt: rawTag.updated_at
			};
		};
		
		return tagsService;
	}]);