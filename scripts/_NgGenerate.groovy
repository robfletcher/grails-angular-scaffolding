import grails.util.GrailsNameUtils

includeTargets << grailsScript("_GrailsCreateArtifacts")
includeTargets << new File("$scaffoldingPluginDir/scripts/_GrailsGenerate.groovy")
includeTargets << grailsScript("_GrailsBootstrap")

generateForName = null
generateViews = true
generateController = true

target(generateForOne: 'Generates controllers and views for only one domain class.') {
	depends compile, loadApp

	def name = generateForName
	name = name.indexOf('.') > 0 ? name : GrailsNameUtils.getClassNameRepresentation(name)
	def domainClass = grailsApp.getDomainClass(name)

	if (!domainClass) {
		grailsConsole.updateStatus 'Domain class not found in grails-app/domain, trying hibernate mapped classes...'
		bootstrap()
		domainClass = grailsApp.getDomainClass(name)
	}

	if (domainClass) {
		generateForDomainClass(domainClass)
		event 'StatusFinal', ["Finished generation for domain class ${domainClass.fullName}"]
	}
	else {
		event 'StatusFinal', ["No domain class found for name ${name}. Please try again and enter a valid domain class name"]
		exit 1
	}
}

def generateForDomainClass(domainClass) {
	def AngularTemplateGenerator = classLoader.loadClass('grails.plugin.angularscaffolding.AngularTemplateGenerator')
	def templateGenerator = AngularTemplateGenerator.newInstance(classLoader)

	templateGenerator.grailsApplication = grailsApp
	templateGenerator.pluginManager = pluginManager
	templateGenerator.event = event
	if (generateViews) {
		event 'StatusUpdate', ["Generating views for domain class ${domainClass.fullName}"]
		templateGenerator.generateViews(domainClass, basedir)
		event 'GenerateViewsEnd', [domainClass.fullName]
	}

	if (generateController) {
		event 'StatusUpdate', ["Generating controller for domain class ${domainClass.fullName}"]
		templateGenerator.generateController(domainClass, basedir)
		event 'GenerateControllerEnd', [domainClass.fullName]
	}
}
