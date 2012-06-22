includeTargets << grailsScript("_GrailsInit")

target(default: "Installs HTML templates for Angular JS scaffolding") {
    depends(checkVersion, parseArguments)
}
