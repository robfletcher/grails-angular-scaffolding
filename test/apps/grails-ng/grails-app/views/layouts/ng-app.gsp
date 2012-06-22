<!doctype html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<title><g:layoutTitle default="Grails"/></title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon.ico')}" type="image/x-icon">
		<link rel="apple-touch-icon" href="${resource(dir: 'images', file: 'apple-touch-icon.png')}">
		<link rel="apple-touch-icon" sizes="114x114" href="${resource(dir: 'images', file: 'apple-touch-icon-retina.png')}">
		<r:require module="ui-common"/>
		<style>
			body {
				padding-top: 60px;
				padding-bottom: 40px;
			}
		</style>
		<g:layoutHead/>
        <r:layoutResources />
	</head>
	<body data-ng-app="${pageProperty(name: 'body.data-ng-app')}"
          data-base-url="${pageProperty(name: 'body.data-base-url', default: createLink(action: 'index').replaceAll(/index$/, ''))}"
          data-template-url="${pageProperty(name: 'body.data-template-url', default: createLink(uri: "/ng-templates/$controllerName"))}">
		<g:render template="/templates/navbar"/>
		<div class="container">
			<g:layoutBody/>
			<hr>
            <footer>
                <p>&copy; <a href="http://freeside.co/">Freeside Software</a> 2012</p>
                <p>Last updated: <g:formatDate date="${Date.parse(/yyyy-MM-dd'T'HH:mm:ssZ/, grailsApplication.metadata.'cf.last.deployed')}"/></p>
            </footer>
        </div>
		<r:layoutResources />
	</body>
</html>