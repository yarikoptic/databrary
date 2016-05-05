'use strict'

app.directive 'notifications', [
  '$sce', 'constantService', 'routerService', 'messageService', 'modelService'
  ($sce, constants, router, messages, models) ->
    restrict: 'E'
    templateUrl: 'site/notifications.html'
    scope: {}
    link: ($scope) ->
      $scope.party = models.Login.user
      router.http(router.controllers.getNotifications).then (res) ->
          for n in $scope.notifications = res.data
            n.html = $sce.trustAsHtml(n.html)
          return
        , (res) ->
          messages.addError
            type: 'red'
            body: 'An error occurred retrieving your notifications'
            report: res
          return
      state = [constants.notice.AuthorizeExpiring, constants.notice.AuthorizeExpired, constants.notice.AuthorizeChildExpiring, constants.notice.AuthorizeChildExpired]
      $scope.deletable = (n) ->
        not (n.notice in state)
      $scope.delete = (n) ->
        router.http(router.controllers.deleteNotification, [n.id]).then () ->
          n.deleted = true
          return
      return
]
