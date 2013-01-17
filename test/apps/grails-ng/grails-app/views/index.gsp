<!doctype html>
<html>
    <head>
        <meta name="layout" content="home"/>
        <title>Grails Angular.js Scaffolding</title>
    </head>

    <body>
        <div class="masthead">
            <div class="container">
                <h1><a href="http://grails.org/" rel="external" title="Grails"><r:img dir="images" file="grails_logo.png" alt="Grails"/></a> &amp; <a href="http://angularjs.org/" rel="external" title="Angular.js"><r:img dir="images" file="AngularJS-large.png" alt="Angular.js"/></a>
                </h1>
                <p>This is a demo of <em>Grails</em> scaffolding using <em>Angular.js</em>.</p>
                <p>This is an in-progress Grails plugin. Any contributions, comments, bug reports etc. are very welcome.</p>
                <div class="actions">
                    <g:link controller="album" class="btn btn-large"><i class="icon-road"></i> Try the<br>demo</g:link>
                    <a class="btn btn-large" href="https://github.com/robfletcher/grails-angular-scaffolding/issues"><i class="icon-exclamation-sign"></i> Raise an<br>issue
                    </a>
                    <a class="btn btn-large" href="https://github.com/robfletcher/grails-angular-scaffolding"><i class="icon-github"></i> Fork<br>on GitHub
                    </a>
                </div>
            </div>
        </div>

        <div class="container">
            <div class="row">
                <div class="span4">
                    <h2><i class="icon-wrench"></i> Built with&hellip;</h2>
                    <p>This application is designed as a test for an experimental scaffolding plugin. Core to the plugin are:</p>
                    <ul class="nav nav-list">
                        <li><a href="http://grails.org/"><i class="icon-external-link"></i> Grails</a></li>
                        <li><a href="http://angularjs.org/"><i class="icon-external-link"></i> Angular JS</a></li>
                    </ul>
                    <p>Additionally the demo application uses the following libraries:</p>
                    <ul class="nav nav-list">
                        <li><a href="http://twitter.github.com/bootstrap/"><i class="icon-external-link"></i> Twitter Bootstrap
                        </a></li>
                        <li><a href="http://fortawesome.github.com/Font-Awesome/"><i class="icon-external-link"></i> Font Awesome
                        </a></li>
                    </ul>
                </div>

                <div class="span4">
                    <h2><i class="icon-user"></i> Built by&hellip;</h2>

                    <h3><r:img class="avatar" uri="/images/avatar.jpg"/> Rob Fletcher</h3>
                    <ul class="nav nav-list">
                        <li><a href="http://freeside.co/"><i class="icon-home icon-large"></i> Freeside Software</a>
                        </li>
                        <li><a href="http://twitter.com/rfletcherEW"><i class="icon-twitter icon-large"></i> Follow me on Twitter
                        </a></li>
                        <li><a href="http://github.com/robfletcher"><i class="icon-github icon-large"></i> See my other projects on GitHub
                        </a></li>
                        <li><a href="http://hipsterdevstack.tumblr.com/"><i class="icon-rss"></i> Hipster Dev Stack</a>
                        </li>
                    </ul>
                </div>

                <div class="span4">
                    <h2><i class="icon-dashboard"></i> Status</h2>
                    <ul class="nav nav-tabs">
                        <li class="active"><a href="#status" data-toggle="tab">Application Status</a></li>
                        <li><a href="#plugins" data-toggle="tab">Installed Plugins</a></li>
                    </ul>
                    <div class="tab-content">
                        <div class="tab-pane active" id="status">
                            <dl class="dl-horizontal">
                                <dt>Last updated</dt><dd><g:formatDate date="${Date.parse(/yyyy-MM-dd'T'HH:mm:ssZ/, grailsApplication.metadata.'cf.last.deployed')}"/></dd>
                                <dt>App version</dt><dd><g:meta name="app.version"/></dd>
                                <dt>Grails version</dt><dd><g:meta name="app.grails.version"/></dd>
                                <dt>Groovy version</dt><dd>${GroovySystem.version}</dd>
                                <dt>JVM version</dt><dd>${System.getProperty('java.version')}</dd>
                                <dt>Reloading active</dt><dd>${grails.util.Environment.reloadingAgentEnabled}</dd>
                                <dt>Controllers</dt><dd>${grailsApplication.controllerClasses.size()}</dd>
                                <dt>Domains</dt><dd>${grailsApplication.domainClasses.size()}</dd>
                                <dt>Services</dt><dd>${grailsApplication.serviceClasses.size()}</dd>
                                <dt>Tag Libraries</dt><dd>${grailsApplication.tagLibClasses.size()}</dd>
                            </dl>
                        </div>
                        <div class="tab-pane" id="plugins">
                            <dl class="dl-horizontal">
                                <g:each var="plugin" in="${applicationContext.getBean('pluginManager').allPlugins}">
                                    <dt>${plugin.name}</dt><dd>${plugin.version}</dd>
                                </g:each>
                            </dl>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
