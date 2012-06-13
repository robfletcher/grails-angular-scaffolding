import grails.util.GrailsUtil

def fileVersion = GrailsUtil.isDevelopmentEnv() ? '1.0.0rc12' : '1.0.0rc12.min'

modules = {
    angular {
        resource id: 'js', url: [plugin: 'angular-scaffolding', dir: 'js/angular', file: "angular-${fileVersion}.js"], nominify: true
    }
    'angular-resource' {
		dependsOn 'angular'
        resource id: 'js', url: [plugin: 'angular-scaffolding', dir: 'js/angular', file: "angular-resource-${fileVersion}.js"], nominify: true
    }

    'angular-scaffolding' {
        dependsOn 'jquery', 'angular-resource'
        resource id: 'js', url: [plugin: 'angular-scaffolding', dir: 'js', file: 'scaffolding.js']
    }
}