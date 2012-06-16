<!doctype html>
<html>
    <head>
        <meta name="layout" content="main"/>
        <title>Welcome to Grails</title>
		<link href='http://fonts.googleapis.com/css?family=Abril+Fatface' rel='stylesheet' type='text/css'>
		<style>
			.hero-unit {
				background-color: #68B940 ;
				background-image: -webkit-gradient(linear, left top, left bottom, from(#68B940 ), to(#48802c));
				background-image: -webkit-linear-gradient(top, #68B940 , #48802c);
				background-image:    -moz-linear-gradient(top, #68B940 , #48802c);
				background-image:      -o-linear-gradient(top, #68B940 , #48802c);
				background-image:         linear-gradient(to bottom, #68B940 , #48802c);
			}
			.hero-unit h1 {
				font-family: cursive;
				font-weight: normal;
			}
			.hero-unit h1 img {
				margin-bottom: 10px;
				max-height: 43px;
				vertical-align: middle;
			}
			.hero-unit .actions .btn {
				font-size: 18px;
				margin-bottom: 10px;
				margin-right: 10px;
				padding: 13px 22px 13px 74px;
				position: relative;
				text-align: left;
				white-space: nowrap;
			}
			.hero-unit .actions .btn {
				background-color: hsl(0, 0%, 79%);
				background-repeat: repeat-x;
				background-image: -khtml-gradient(linear, left top, left bottom, from(hsl(0, 0%, 121%)), to(hsl(0, 0%, 79%)));
				background-image: -moz-linear-gradient(top, hsl(0, 0%, 121%), hsl(0, 0%, 79%));
				background-image: -ms-linear-gradient(top, hsl(0, 0%, 121%), hsl(0, 0%, 79%));
				background-image: -webkit-gradient(linear, left top, left bottom, color-stop(0%, hsl(0, 0%, 121%)), color-stop(100%, hsl(0, 0%, 79%)));
				background-image: -webkit-linear-gradient(top, hsl(0, 0%, 121%), hsl(0, 0%, 79%));
				background-image: -o-linear-gradient(top, hsl(0, 0%, 121%), hsl(0, 0%, 79%));
				background-image: linear-gradient(hsl(0, 0%, 121%), hsl(0, 0%, 79%));
				border-color: hsl(0, 0%, 79%) hsl(0, 0%, 79%) hsl(0, 0%, 68.5%);
				color: #333;
				text-shadow: 0 1px 1px rgba(255, 255, 255, 0.69);
				-webkit-font-smoothing: antialiased;
			}
			.hero-unit .actions [class^="icon-"] {
				font-size: 46px;
				left: 22px;
				position: absolute;
				vertical-align: text-top;
			}
		</style>
    </head>
    <body>
		<div class="hero-unit">
			<h1><a href="http://grails.org/" rel="external" title="Grails"><r:img dir="images" file="grails_logo.png" alt="Grails"/></a> &amp;
				<a href="http://angularjs.org/" rel="external" title="Angular.js"><r:img dir="images" file="AngularJS-large.png" alt="Angular.js"/></a></h1>
			<p>This is a demo of <em>Grails</em> scaffolding using <em>Angular.js</em>.</p>
			<p>This is an in-progress Grails plugin. Any contributions, comments, bug reports etc. are very welcome.</p>
			<div class="actions">
				<g:link controller="album" class="btn btn-large"><i class="icon-road"></i> Try the<br>demo</g:link>
				<a class="btn btn-large" href="https://github.com/robfletcher/grails-angular-scaffolding/issues"><i class="icon-exclamation-sign"></i> Raise an<br>issue</a>
				<a class="btn btn-large" href="https://github.com/robfletcher/grails-angular-scaffolding"><i class="icon-github"></i> Fork me<br>on GitHub</a>
				<a class="btn btn-large" href="http://twitter.com/rfletcherEW"><i class="icon-twitter"></i> Follow me<br>on Twitter</a>
			</div>
		</div>
		<div class="row">
			<div class="span4">
				<h2>Built with&hellip;</h2>
				<ul class="unstyled">
					<li><a href="http://grails.org/">Grails</a></li>
					<li><a href="http://angularjs.org/">Angular JS</a></li>
					<li><a href="http://twitter.github.com/bootstrap/">Twitter Bootstrap</a></li>
					<li><a href="http://fortawesome.github.com/Font-Awesome/">Font Awesome</a></li>
				</ul>
			</div>
			<div class="span4">
				<h2>Application Status</h2>
				<dl class="dl-horizontal">
					<dt>App version</dt><dd><g:meta name="app.version"/></dd>
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
