grails.project.work.dir = 'target'
grails.project.class.dir = 'target/classes'
grails.project.test.class.dir = 'target/test-classes'
grails.project.test.reports.dir = 'target/test-reports'
grails.project.target.level = 1.6

grails.project.dependency.resolution = {
    inherits 'global'
    log 'warn'
    repositories {
        grailsCentral()
        mavenLocal()
    }
    dependencies {
    }

    plugins {
        build(":tomcat:$grailsVersion",
            ':release:2.0.2') {
            export = false
        }

        runtime(":hibernate:$grailsVersion",
            ':resources:1.1.6',
            ':jquery:1.7.2') {
            export = false
        }

        test(':spock:0.6') {
            export = false
        }
    }
}
