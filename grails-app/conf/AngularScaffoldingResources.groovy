modules = {
    angular {
        resource id: 'js', url: [plugin: 'angular-scaffolding', dir: 'js/angular', file: 'angular-1.0.0rc10.min.js'], nominify: true
    }
    'angular-dev' {
        resource id: 'js', url: [plugin: 'angular-scaffolding', dir: 'js/angular', file: 'angular-1.0.0rc10.js'], nominify: true
    }

    'angular-scaffolding' {
        dependsOn 'angular'
        resource id: 'js', url: [plugin: 'angular-scaffolding', dir: 'js', file: 'scaffolding.js']
    }
}