angular.module('clientApp').factory('StoriesService', ['$http', 'apiConstants', '$q', 'localStorageService',
function($http, apiConstants, $q, localStorage) {
	var storiesService = {};

	/**
	 * Fetch all stories from api.
	 */
	storiesService.get = function() {
		var url = apiConstants.url + 'stories';
		var dataFromStorage = localStorage.get(url);
		var deferred = $q.defer();

		// stale after 2 minutes
		if (dataFromStorage && dataFromStorage.timestamp >= Date.now() - 120000) {
			deferred.resolve(createStories(dataFromStorage.data.stories));
		} else {
			var request = {
				method : 'GET',
				url : url,
				headers : {
					'api-key' : apiConstants.apiKey
				}
			};

			$http(request).success(function(data, status, headers, config) {
				dataToStorage = { timestamp: Date.now(), data: data };
				localStorage.set(url, dataToStorage);
				deferred.resolve(createStories(data.stories));
			}).error(function(data, status, headers, config) {
				deferred.reject("ERROR STORIES");
			});
		}

		return deferred.promise;
	};
	
	storiesService.getById = function(id) {
		var url = apiConstants.url + 'stories/' + id;
		var dataFromStorage = localStorage.get(url);
		var deferred = $q.defer();
		
		// stale after 2 minutes
		if (dataFromStorage && dataFromStorage.timestamp >= Date.now() - 120000) {
			deferred.resolve(createStory(dataFromStorage.data.story));
		} else {
			var request = {
				method : 'GET',
				url : url,
				headers : {
					'api-key' : apiConstants.apiKey
				}
			};

			$http(request).success(function(data, status, headers, config) {
				dataToStorage = { timestamp: Date.now(), data: data };
				localStorage.set(url, dataToStorage);
				deferred.resolve(createStory(data.story));
			}).error(function(data, status, headers, config) {
				deferred.reject("ERROR STORY");
			});
		}
		
		return deferred.promise;
	};

	/**
	 * Fetch all stories from api matching query.
	 */
	storiesService.search = function(query, creator, tag) {
		var url = apiConstants.url + 'stories/search';
		var dataFromStorage = localStorage.get(url + "-" + query + "-" + creator.id || creator + "-" + tag.id);
		var deferred = $q.defer();

		// stale after 2 minutes
		if (dataFromStorage && dataFromStorage.timestamp >= Date.now() - 120000) {
			deferred.resolve(createStories(dataFromStorage.data.stories));
		} else {
			var params = {};
			if (query) {
				params.query = query;
			}
			if (creator && creator.id != 0) {
				if (creator.id) {
					params.creator = creator.id;
				} else {
					params.creator = creator;
				}
			}
			if (tag && tag.id != 0) {
				if (tag.id) {
					params.tag = tag.id;
				} else {
					params.tag = tag;
				}
			}
			var request = {
				method : 'GET',
				url : url,
				headers : {
					'api-key' : apiConstants.apiKey
				},
				params : params
			};
			$http(request).success(function(data, status, headers, config) {
				dataToStorage = { timestamp: Date.now(), data: data };
				localStorage.set(url + "-" + query + "-" + creator.id + "-" + tag.id, dataToStorage);
				deferred.resolve(createStories(data.stories));
			}).error(function(data, status, headers, config) {
				deferred.reject("ERROR STORIES");
			});
		}
		

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
		var dataFromStorage = localStorage.get(urlToCreator);
		var deferred = $q.defer();

		// stale after 30 minutes
		if (dataFromStorage && dataFromStorage.timestamp >= Date.now() - 1800000) {
			deferred.resolve(dataFromStorage.data.creator);
		} else {
			var request = {
				method : 'GET',
				url : urlToCreator,
				headers : {
					'api-key' : apiConstants.apiKey
				}
			};
			$http(request).success(function(data, status, headers, config) {
				dataToStorage = { timestamp: Date.now(), data: data };
				localStorage.set(urlToCreator, dataToStorage);
				deferred.resolve(data.creator);
			}).error(function(data, status, headers, config) {
				deferred.reject("ERROR CREATOR");
			});
		}

		return deferred.promise;
	}

	/**
	 * Fetch tag objects from api.
	 *
	 * @param String urlToTags
	 */
	function getTags(urlToTags) {
		var dataFromStorage = localStorage.get(urlToTags);
		var deferred = $q.defer();

		// stale after 30 minutes
		if (dataFromStorage && dataFromStorage.timestamp >= Date.now() - 1800000) {
			deferred.resolve(dataFromStorage.data.tags);
		} else {
			var request = {
				method : 'GET',
				url : urlToTags,
				headers : {
					'api-key' : apiConstants.apiKey
				}
			};
	
			$http(request).success(function(data, status, headers, config) {
				dataToStorage = { timestamp: Date.now(), data: data };
				localStorage.set(urlToTags, dataToStorage);
				deferred.resolve(data.tags);
			}).error(function(data, status, headers, config) {
				deferred.reject("ERROR TAGS");
			});
		}

		return deferred.promise;
	}

	return storiesService;
}]); 