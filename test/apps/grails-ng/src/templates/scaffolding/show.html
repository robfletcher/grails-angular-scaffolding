<% import grails.persistence.Event %>
<div class="page-header">
	<h1>Show ${className}</h1>
</div>
<alert level="{{message.level}}" text="{{message.text}}"/>
<dl class="dl-horizontal">
	<%  excludedProps = Event.allEvents.toList() << 'id' << 'version'
	allowedNames = domainClass.persistentProperties*.name << 'dateCreated' << 'lastUpdated'
	props = domainClass.properties.findAll { allowedNames.contains(it.name) && !excludedProps.contains(it.name) }
	Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
	props.each { p -> %>
	<dt>${p.naturalName}</dt>
	<dd data-ng-bind="item.${p.name}"></dd>
	<%  } %>
</dl>
<div class="form-actions">
	<a class="btn" data-ng-href="#/edit/{{item.id}}"><i class="icon-edit"></i> Edit</a>
	<button type="button" class="btn btn-danger" data-ng-click="delete(item)"><i class="icon-trash"></i> Delete</button>
</div>
