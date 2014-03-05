define(['app/config/module'], function (module) {
	'use strict';

	module.factory('ConstantService', ['$rootScope', '$http', function ($rootScope, $http) {
		var constantService = {
			data: {}
		};

		//

		var STATIC_DATA = {
			preset: [
				{
					inherit: 2,
					direct: 2,
					name: '<strong>Read-only Affiliate</strong>: View shared Databrary data and all my data.'
				},
				{
					inherit: 3,
					direct: 3,
					name: '<strong>Data Editor</strong>: Create and modify datasets and studies.'
				},
				{
					inherit: 4,
					direct: 4,
					name: '<strong>Lab Manager</strong>: Delegate authorization and data access.'
				},
				{
					inherit: undefined,
					direct: undefined,
					custom: true,
					name: '<strong>Custom...</strong>'
				}
			]
		};

		//

		constantService.update = function () {
			constantService.$promise = $http.get('/api/constants');

			constantService.$promise.then(function (result) {
				angular.extend(constantService.data, STATIC_DATA, result.data);
			});
		};

		constantService.get = function (key, id) {
			if (angular.isUndefined(constantService.data[key]))
				return undefined;

			if (angular.isDefined(id))
				return constantService.data[key][id] || undefined;

			return constantService.data[key];
		};

		constantService.find = function (key, name) {
			var data = constantService.data[key];

			if (angular.isDefined(data))
				for (var id in data)
					if (data.hasOwnProperty(id) && data[id].name == name)
						return data[id];

			return undefined;
		};

		//

		constantService.update();

		return constantService;
	}]);
});
