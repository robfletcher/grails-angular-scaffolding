includeTargets << new File("${angularScaffoldingPluginDir}/scripts/_NgGenerate.groovy")

target(default: 'Generates a CRUD interface (controller + Angular JS views) for a domain class') {
	depends checkVersion, parseArguments, packageApp

	promptForName type: 'Domain Class'
	generateController = true
	generateForName = argsMap.params[0]

	generateForOne()
}
