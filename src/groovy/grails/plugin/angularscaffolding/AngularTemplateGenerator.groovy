package grails.plugin.angularscaffolding

import org.springframework.util.Assert
import org.codehaus.groovy.grails.commons.GrailsDomainClass
import org.springframework.core.io.FileSystemResource
import org.springframework.core.io.support.PathMatchingResourcePatternResolver
import org.codehaus.groovy.grails.scaffolding.*

/**
 * Can't seem to load this if it's on the plugin source path so I've inlined it here
 */
class AngularTemplateGenerator extends DefaultGrailsTemplateGenerator
{
	def event

	AngularTemplateGenerator(ClassLoader classLoader) {
		super(classLoader)
	}

	def renderEditor = { property, prefix ->
		def domainClass = property.domainClass
		def cp
		if (pluginManager?.hasGrailsPlugin('hibernate4')||pluginManager?.hasGrailsPlugin('hibernate3')) {
			cp = domainClass.constrainedProperties[property.name]
		}

		if (!renderEditorTemplate) {
			// create template once for performance
			def templateText = getTemplateText('renderEditor.template')
			renderEditorTemplate = engine.createTemplate(templateText)
		}

		def binding = [
				pluginManager: pluginManager,
				property: property,
				domainClass: domainClass,
				cp: cp,
				domainInstance: getPropertyName(domainClass),
				prefix: prefix
		]
		renderEditorTemplate.make(binding).toString()
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

println "viewName: $viewName, domainClass: $domainClass, class: ${domainClass.class.name}"
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
	protected Set<String> getTemplateNames() {
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

		resources as Set
	}

	protected String getPropertyName(GrailsDomainClass domainClass) { "${domainClass.propertyName}${domainSuffix}" }

}
