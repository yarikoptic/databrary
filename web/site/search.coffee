'use strict'

app.controller 'site/search', [
  '$scope', '$location', 'displayService', 'results',
  ($scope, $location, display, results) ->
    console.log("results")
    console.log(results)

    limit = 10 # server-side default
    offset = parseInt($location.search().offset, 10) || 0
    display.title = 'Search'
    $scope.results = results?.response
    $scope.number = 1 + (offset / limit)

    console.log(results)

    params = $location.search()
    $scope.query = params.query
    $scope.offset = offset
    $scope.limit = 10
    $scope.search = ->
      $location.search('query', $scope.query, 'offset', offset)

#      We want the query to look something like this:
#    facet=true&facet.field=content_type&facet.mincount=1&group=true&group.field=content_type&group.limit=10

    # group.offset is offset
    # group.limit is limit

#    $scope.containersForVoume = (volume_id) ->
#      $location.search('query', $scope.query, 'offset', offset)

    $scope.selectedVolume = []

    $scope.minPage = 1
    $scope.maxPage = 1 + ($scope.results.numFound / limit)
    pageRange = []
    for i in [$scope.minPage .. $scope.maxPage] by 1
      pageRange.push(i)

    $scope.pageRange = pageRange

    $scope.goToPage = (page) -> $location.search('offset', limit * (page-1))

    if parseInt($scope.results.numFound) > (offset + limit)
      $scope.next = -> $location.search('offset', offset + limit)
    if offset > 0
      $scope.prev = -> $location.search('offset', Math.max(0, offset - limit))
    return
]