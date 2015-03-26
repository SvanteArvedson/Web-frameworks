angular
	.module('clientApp')
	.factory('CreatorsService', ['$http' ,'apiConstants', '$q', 'localStorageService' ,function($http, apiConstants, $q, localStorage) {
		var creatorsService = {};
		
		/**
		 * Fetch all tags from api. 
		 */
		creatorsService.get = function() {
			var url = apiConstants.url + 'creators';
			var data = localStorage.get(url);
			var deferred = $q.defer();
			
			// stale after 30 minutes
			if (data && data.timestamp >= Date.now() - 1800000) {
				deferred.resolve(createCreators(data.data.creators));
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
						deferred.resolve(createCreators(data.creators));
					})
					.error(function(data, status, headers, config) {
						deferred.reject("ERROR CREATORS");
					});
			}
			
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