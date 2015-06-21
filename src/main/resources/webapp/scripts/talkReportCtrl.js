angular.module('cakeReduxModule')
    .controller('TalkReportCtrl', ['$scope', '$http', '$routeParams', 'talkList','roomSlotFactory','slotFilterService',
        function($scope, $http, $routeParams,talkList,roomSlotFactory,slotFilterService) {
            $scope.talks = talkList.talks;


            $scope.showTitle = true;
            $scope.showSummary = true;
            $scope.showAbstract = true;
            $scope.showPostcode = true;
            $scope.showOutline = true;
            $scope.showKeywords = true;
            $scope.showAudience = true;
            $scope.showEquipment = true;
            $scope.showState = true;
            $scope.showPublished = true;
            $scope.showFormat = true;
            $scope.showLevel = true;
            $scope.showLanguage = true;
            $scope.showRoom = true;
            $scope.showSlot = true;
            $scope.showSpeakers = true;
            $scope.showSpeakername = true;
            $scope.showSpeakerbio = true;
            $scope.showPostcode = true;
            $scope.showLastModified = true;

            var updateFromServer = function(data) {
                var atalk = _.findWhere($scope.talks,{ref:data.ref});
                if (!atalk) {
                    return;
                }
                for (var prop in data) {
                    atalk[prop] = data[prop];
                }


            };

            $scope.talks.forEach(function(talk) {
                $http({method: "GET", url: "data/atalk?talkId=" + talk.ref})
                    .success(updateFromServer);
            });


        }
    ]
);