includeTargets << grailsScript("_GrailsInit")

target(default: 'Installs the Angular JS scaffolding templates') {
	depends checkVersion, parseArguments

	event 'InstallTemplatesStart', ['Installing Templates...']

	def paths = [scaffolding: "$basedir/src/templates/scaffolding", common: "$basedir/web-app/ng-templates"]

	def overwrite = false
	if (paths.any { new File(it.value).exists() }) {
		if (!isInteractive || confirmInput('Overwrite existing templates? [y/n]', 'overwrite.templates')) {
			overwrite = true
		}
	}

	paths.each { sourcePath, targetDir ->
		def sourceDir = "$angularScaffoldingPluginDir/src/templates/$sourcePath"

		ant.mkdir dir: targetDir
		event 'StatusUpdate', ["Copying files to $targetDir..."]
		ant.copy(todir: targetDir, overwrite: overwrite) {
			fileset dir: sourceDir
		}

		event 'StatusUpdate', ['Templates installed successfully']
	}

	event 'InstallTemplatesEnd', ['Finished Installing Templates']
}
