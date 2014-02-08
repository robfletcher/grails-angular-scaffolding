grails.servlet.version = "3.0" // Change depending on target container compliance (2.5 or 3.0)
grails.project.class.dir = "target/classes"
grails.project.test.class.dir = "target/test-classes"
grails.project.test.reports.dir = "target/test-reports"
grails.project.work.dir = "target/work"
grails.project.target.level = 1.6
grails.project.source.level = 1.6
//grails.project.war.file = "target/${appName}-${appVersion}.war"

grails.project.fork = [
	// configure settings for compilation JVM, note that if you alter the Groovy version forked compilation is required
	//  compile: [maxMemory: 256, minMemory: 64, debug: false, maxPerm: 256, daemon:true],

	// configure settings for the test-app JVM, uses the daemon by default
	test: [maxMemory: 768, minMemory: 64, debug: false, maxPerm: 256, daemon:true],
	// configure settings for the run-app JVM
	run: [maxMemory: 768, minMemory: 64, debug: false, maxPerm: 256, forkReserve:false],
	// configure settings for the run-war JVM
	war: [maxMemory: 768, minMemory: 64, debug: false, maxPerm: 256, forkReserve:false],
	// configure settings for the Console UI JVM
	console: [maxMemory: 768, minMemory: 64, debug: false, maxPerm: 256]
]

grails.project.dependency.resolver = "maven" // or ivy

grails.project.dependency.resolution = {

	inherits 'global'
	log 'warn'

	repositories {
		inherits true // Whether to inherit repository definitions from plugins
		
        grailsPlugins()
        grailsHome()
 
		grailsCentral()
		mavenCentral()
		mavenLocal()
		mavenRepo 'http://maven.springframework.org/milestone/'
	}

	dependencies {
	}

	plugins {
        build ":tomcat:7.0.42"

		compile ':cloud-foundry:1.2.3',
				':cache-headers:1.1.5',
				':gson:1.1.4'

       // plugins needed at runtime but not for compilation
        runtime ":hibernate:3.6.10.5" // or ":hibernate4:4.1.11.1"
        runtime ":database-migration:1.3.5"
        runtime ":jquery:1.11.0"
        runtime ":resources:1.2"
        // Uncomment these (or add new ones) to enable additional resources capabilities
        runtime ":zipped-resources:1.0.1"
        runtime ":cached-resources:1.1"
		
	}
}

grails.plugin.location.'angular-scaffolding' = '../../..'