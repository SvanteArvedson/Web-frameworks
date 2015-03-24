angular
	.module('clientApp')
	.factory('CreatorsService', ['$http' ,'apiConstants', '$q' ,function($http, apiConstants, $q) {
		var creatorsService = {};
		
		/**
		 * Fetch all tags from api. 
		 */
		creatorsService.get = function() {
			var deferred = $q.defer();
			
			var request = {
				method: 'GET',
				url: apiConstants.url + 'creators',
				headers: {
					'api-key': apiConstants.apiKey
				}
			};
			
			$http(request)
				.success(function(data, status, headers, config) {
					deferred.resolve(createCreators(data.creators));
				})
				.error(function(data, status, headers, config) {
					deferred.reject("ERROR CREATORS");
				});
				
			return deferred.promise;
		};
		
		/**
		 * Creates a list of tag objects.
		 * 
		 * @param Object rawTags
		 */
		function createCreators(rawCreators) {
			var ret = [];
			rawCreators.forEach(function(element, index, array) {
				ret.push(createCreator(element));
			});
			return ret;
		};
		
		/**
		 * Create a tag object.
		 * 
		 * @param Object rawTag
		 */
		function createCreator(rawCreator) {
			return {
				id: rawCreator.id,
				email: rawCreator.email,
				createdAt: rawCreator.created_at,
				updatedAt: rawCreator.updated_at
			};
		};
		
		return creatorsService;
	}]);