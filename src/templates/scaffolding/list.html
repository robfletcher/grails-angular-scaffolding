<% import grails.persistence.Event %>
<div class="page-header">
    <h1>${className} List</h1>
</div>
<alert level="{{message.level}}" text="{{message.text}}"/>
<table class="table table-bordered table-striped">
    <thead>
        <tr>
        <%  excludedProps = Event.allEvents.toList() << 'id' << 'version'
            allowedNames = domainClass.persistentProperties*.name << 'dateCreated' << 'lastUpdated'
            props = domainClass.properties.findAll { allowedNames.contains(it.name) && !excludedProps.contains(it.name) && it.type != null && !Collection.isAssignableFrom(it.type) && !it.isAssociation() && !it.embedded }
            Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
            if (props.size() > 6) props = props[0..5]
            for (p in props) {
                if (p.isAssociation()) { %>
            <th>${p.naturalName}</th>
            <%  } else { %>
            <th data-sortable="${p.name}">${p.naturalName}</th>
            <%  } } %>
        </tr>
    </thead>
    <tbody>
        <tr data-ng-repeat="item in list" data-ng-click="show(item)">
            <%  for (p in props) { %>
            <td>{{item.${p.name}}}</td>
            <%  } %>
        </tr>
    </tbody>
</table>
<div class="pagination pagination-centered" data-pagination data-total="total"></div>