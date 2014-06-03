
<%@ page import="grails.plugin.angular.test.Album" %>
<!doctype html>
<html>
    <head>
        <meta name="layout" content="ng-app">
        <g:set var="entityName" value="${message(code: 'album.label', default: 'Album')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
        <r:require module="angular-grails-resource"/>
    </head>
    <body data-ng-app="scaffolding">
        <div class="subnav">
            <ul class="nav nav-pills">
                <li><a class="list" href="#/list"><i class="icon-list"></i> <g:message code="default.list.label" args="[entityName]" /></a></li>
                <li><a class="create" href="#/create"><i class="icon-plus"></i> <g:message code="default.new.label" args="[entityName]" /></a></li>
            </ul>
        </div>
        <div class="content" data-ng-view>
        </div>
    </body>
</html>
