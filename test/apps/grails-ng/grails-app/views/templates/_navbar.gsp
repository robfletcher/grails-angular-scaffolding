<div class="navbar navbar-fixed-top">
	<div class="navbar-inner">
		<div class="container">
			<a class="brand" href="${createLink(uri: '/')}">Grails Angular Scaffolding</a>
			<div class="nav-collapse">
				<ul class="nav">
					<g:each var="c" in="${grailsApplication.controllerClasses.sort { it.fullName } }">
						<li <g:if test="${controllerName == c.logicalPropertyName}">class="active"</g:if>><g:link controller="${c.logicalPropertyName}">${c.naturalName}</g:link></li>
					</g:each>
				</ul>
			</div>
            <ul class="nav pull-right social-buttons">
                <li><g:render template="/templates/tweet-button"/></li>
                <li><g:render template="/templates/flattr-button"/></li>
            </ul>
        </div>
	</div>
</div>
