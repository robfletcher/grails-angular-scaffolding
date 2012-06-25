import grails.util.GrailsNameUtils
import org.codehaus.groovy.grails.commons.GrailsDomainClass
import org.springframework.core.io.FileSystemResource
import org.springframework.core.io.support.PathMatchingResourcePatternResolver
import org.springframework.util.Assert
import org.codehaus.groovy.grails.scaffolding.*

includeTargets << grailsScript("_GrailsCreateArtifacts")
includeTargets << grailsScript("_GrailsGenerate")
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
	def templateGenerator = new AngularTemplateGenerator(classLoader)
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

/**
 * Can't seem to load this if it's on the plugin source path so I've inlined it here
 */
class AngularTemplateGenerator extends DefaultGrailsTemplateGenerator {

	def event

	AngularTemplateGenerator(ClassLoader classLoader) {
		super(classLoader)
	}

	@Override
	void generateViews(GrailsDomainClass domainClass, String destdir) {
		Assert.hasText destdir, 'Argument [destdir] not specified'

		for (t in getTemplateNames()) {
			event 'StatusUpdate', ["Generating $t for domain class ${domainClass.fullName}"]
			generateView domainClass, t, new File(destdir).absolutePath
		}
	}

	@Override
	void generateView(GrailsDomainClass domainClass, String viewName, Writer out) {
		def templateText = getTemplateText(viewName)

		if (templateText) {

			def t = engine.createTemplate(templateText)
			def multiPart = domainClass.properties.find {it.type == ([] as Byte[]).class || it.type == ([] as byte[]).class}

			boolean hasHibernate = pluginManager?.hasGrailsPlugin('hibernate')
			def packageName = domainClass.packageName ? "<%@ page import=\"${domainClass.fullName}\" %>" : ""
			def binding = [pluginManager: pluginManager,
					packageName: packageName,
					domainClass: domainClass,
					multiPart: multiPart,
					className: domainClass.shortName,
					propertyName: getPropertyName(domainClass),
					renderEditor: renderEditor,
					comparator: hasHibernate ? DomainClassPropertyComparator : SimpleDomainClassPropertyComparator]

			t.make(binding).writeTo(out)
		}
	}

	@Override
	void generateView(GrailsDomainClass domainClass, String viewName, String destDir) {
		def suffix = viewName.find(/\.\w+$/)

		def viewsDir = suffix == '.html' ? new File("$destDir/web-app/ng-templates/$domainClass.propertyName") : new File("$destDir/grails-app/views/$domainClass.propertyName")
		if (!viewsDir.exists()) viewsDir.mkdirs()

		def destFile = new File(viewsDir, "$viewName")
		destFile.withWriter { Writer writer ->
			generateView domainClass, viewName, writer
		}
	}

	@Override
	def getTemplateNames() {
		def resources = []
		def resolver = new PathMatchingResourcePatternResolver()
		def templatesDirPath = "${basedir}/src/templates/scaffolding"
		def templatesDir = new FileSystemResource(templatesDirPath)
		if (templatesDir.exists()) {
			try {
				resources.addAll(resolver.getResources("file:$templatesDirPath/*.html").filename)
				resources.addAll(resolver.getResources("file:$templatesDirPath/*.gsp").filename)
			} catch (e) {
				event 'StatusError', ['Error while loading views from grails-app scaffolding folder', e]
			}
		}

		resources
	}

	private String getPropertyName(GrailsDomainClass domainClass) { "${domainClass.propertyName}${domainSuffix}" }

}
