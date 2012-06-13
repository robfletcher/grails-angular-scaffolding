modules = {
    angular {
        resource id: 'js', url: [plugin: 'angular-scaffolding', dir: 'js/angular', file: 'angular-1.0.0rc10.min.js'], nominify: true
    }
    'angular-resource' {
        resource id: 'js', url: [plugin: 'angular-scaffolding', dir: 'js/angular', file: 'angular-resource-1.0.0rc10.min.js'], nominify: true
    }

    'angular-scaffolding' {
        dependsOn 'jquery', 'angular', 'angular-resource'
        resource id: 'js', url: [plugin: 'angular-scaffolding', dir: 'js', file: 'scaffolding.js']
    }
}