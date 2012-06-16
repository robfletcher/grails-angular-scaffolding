<!doctype html>
<html>
    <head>
        <meta name="layout" content="main"/>
        <title>Welcome to Grails</title>
    </head>
    <body>
		<div class="hero-unit">
			<h1>Grails with Angular.js</h1>
			<p>This is a demo of <a href="http://grails.org/" rel="external">Grails</a> scaffolding using
				<a href="http://angularjs.org/" rel="external">Angular.js</a>.</p>
			<p>This is an in-progress Grails plugin. See the
				<a href="https://github.com/robfletcher/grails-angular-scaffolding">source code</a> and
				<a href="https://github.com/robfletcher/grails-angular-scaffolding/issues">issues list</a> on GitHub.
			Any contributions, comments, bug reports etc. are very welcome.</p>
		</div>
		<div class="row">
			<div class="span4">
				<h2>Application Status</h2>
				<dl class="dl-horizontal">
					<dt>App version:</dt><dd><g:meta name="app.version"/></dd>
					<dt>Grails version</dt><dd><g:meta name="app.grails.version"/></dd>
					<dt>Groovy version</dt><dd>${org.codehaus.groovy.runtime.InvokerHelper.getVersion()}</dd>
					<dt>JVM version</dt><dd>${System.getProperty('java.version')}</dd>
					<dt>Reloading active</dt><dd>${grails.util.Environment.reloadingAgentEnabled}</dd>
					<dt>Controllers</dt><dd>${grailsApplication.controllerClasses.size()}</dd>
					<dt>Domains</dt><dd>${grailsApplication.domainClasses.size()}</dd>
					<dt>Services</dt><dd>${grailsApplication.serviceClasses.size()}</dd>
					<dt>Tag Libraries</dt><dd>${grailsApplication.tagLibClasses.size()}</dd>
				</dl>
			</div>
			<div class="span4">
				<h2>Installed Plugins</h2>
				<dl class="dl-horizontal">
					<g:each var="plugin" in="${applicationContext.getBean('pluginManager').allPlugins}">
						<dt>${plugin.name}</dt><dd>${plugin.version}</dd>
					</g:each>
				</dl>
	        </div>
		</div>
    </body>
</html>
