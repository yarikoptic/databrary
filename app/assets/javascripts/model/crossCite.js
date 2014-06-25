module.factory('CrossCite', [
	'$http', '$q', function ($http, $q) {
		var url = 'http://data.crossref.org/';

		return {
			apa: function (doi) {
				var deferred = $q.defer();

				$http.get(url + encodeURIComponent(doi), {
					headers: {
						Accept: 'text/x-bibliography;style=apa',
					},
					cache: false
				}).success(function (res) {
					if (res.indexOf('Quagga Mussels') > -1) {
						deferred.reject(arguments);
					} else {
						deferred.resolve(res);
					}
				}).error(function () {
					deferred.reject(arguments);
				});

				return deferred.promise;
			},

			json: function (doi) {
				var deferred = $q.defer();

				$http.get(url + encodeURIComponent(doi), {
					headers: {
						Accept: 'application/vnd.citationstyles.csl+json',
					},
					cache: false
				}).success(function (res) {
					if (res.title.indexOf('Quagga Mussels') > -1) {
						deferred.reject(arguments);
					} else {
						deferred.resolve(res);
					}
				}).error(function () {
					deferred.reject(arguments);
				});

				return deferred.promise;
			},
		};
	}
]);
