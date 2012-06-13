class AngularScaffoldingGrailsPlugin {

    def version = '1.0-SNAPSHOT'
    def grailsVersion = '2.0 > *'
    def dependsOn = [:]
    def pluginExcludes = [
        'grails-app/conf/BootStrap.groovy',
        'grails-app/views/**/*',
        'web-app/css/**/*',
        'web-app/images/**/*'
    ]

    def title = 'Angular Scaffolding Plugin'
    def author = 'Rob Fletcher'
    def authorEmail = 'rob@freeside.co'
    def description = '''\
A plugin that enables Grails scaffolding to operate as an Angular.js one-page app.
'''

    def documentation = 'http://freeside.co/grails-angular-scaffolding'
    def license = 'MIT'
    def organization = [name: 'Freeside Software', url: 'http://freeside.co/']
    def issueManagement = [system: 'GitHub', url: 'https://github.com/robfletcher/grails-angular-scaffolding/issues']
    def scm = [url: 'https://github.com/robfletcher/grails-angular-scaffolding']

}
