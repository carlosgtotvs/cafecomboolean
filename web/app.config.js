(function () {
    'use strict';
    angular
        .module(global.config.APP_NAME)
        .config(Config);

    Config.$inject = ['$translateProvider', '$translateStaticFilesLoaderProvider', '$urlRouterProvider', '$stateProvider'];

    function Config($translateProvider, $translateStaticFilesLoaderProvider, $urlRouterProvider, $stateProvider) {
        var config = this;

        $urlRouterProvider.otherwise('/viagem');

        $stateProvider
            .state('viagem', {
                url: '/viagem',
                cache: false,
                views: {
                    'pageContent@':{templateUrl: 'views/viagem/viagem.html'}
                }
            })
			
			.state('aponta', {
                url: '/aponta/:param',
                cache: false,
                views: {
                    'pageContent@':{templateUrl: 'views/aponta/aponta.html'}
                }
            })
			
            .state('docs', {
                url: '/:docs',
                cache: false,
                views: {
                    'pageContent@':{templateUrl: 'views/docs/docs.html'}
                }	
            });

        var language = navigator.language.substr(0, 2);

        $translateProvider.useStaticFilesLoader({
            prefix: 'locales/',
            suffix: '.json'
        });

        $translateProvider.preferredLanguage(language);
        $translateProvider.fallbackLanguage('pt');
        $translateProvider.useSanitizeValueStrategy('escaped');
    }
}());
