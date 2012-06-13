
<%@ page import="grails.plugin.angular.test.Album" %>
<!doctype html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:set var="entityName" value="${message(code: 'album.label', default: 'Album')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
        <r:require module="angular-scaffolding"/>
    </head>
    <body data-ng-app="scaffolding" data-base-url="${createLink(action: 'index')}">
        <a href="#list-album" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                <li><a class="list" href="#list"><g:message code="default.list.label" args="[entityName]" /></a></li>
                <li><a class="create" href="#create"><g:message code="default.new.label" args="[entityName]" /></a></li>
            </ul>
        </div>
        <div class="content" role="main" data-ng-view>
        </div>
    </body>
</html>
