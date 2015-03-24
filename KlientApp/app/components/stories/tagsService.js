angular
	.module('clientApp')
	.factory('TagsService', ['$http' ,'apiConstants', '$q' ,function($http, apiConstants, $q) {
		var tagsService = {};
		
		/**
		 * Fetch all tags from api. 
		 */
		tagsService.get = function() {
			var deferred = $q.defer();
			
			var request = {
				method: 'GET',
				url: apiConstants.url + 'tags',
				headers: {
					'api-key': apiConstants.apiKey
				}
			};
			
			$http(request)
				.success(function(data, status, headers, config) {
					deferred.resolve(createTags(data.tags));
				})
				.error(function(data, status, headers, config) {
					deferred.reject("ERROR TAGS");
				});
				
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