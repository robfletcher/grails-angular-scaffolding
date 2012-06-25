This is a Grails plugin that allows you to use [Angular.js](http://angularjs.org/) based scaffolding.

## Usage

After installing the plugin run:

	grails ng-install-templates

This will install the Angular JS scaffolding templates into your project under `src/templates/scaffolding`. It will also copy some common HTML template files that will be shared by all scaffolded views into `web-app/ng-templates`.

### Static scaffolding

To generate the controller and views for a domain class run:

	grails ng-generate-all _domain class name_

### Dynamic scaffolding

Dynamic scaffolding is only supported for the controller. Currently you will need to generate the views for each domain class.

To generate only the views and use a dynamically scaffolded controller run:

	grails ng-generate-views _domain class name_

## How it works

Instead of the Grails controller rendering a view for each page using a GSP the controller's _index_ action serves up an initial framework page containing the JavaScript resources required by Angular JS. The remaining controller actions simply return _JSON_ data.

Each _'page'_ in the CRUD interface for a particular domain class is accessed using a URL fragment; `#/list`, `#/create`, etc. The page content is rendered by Angular JS using an HTML template and the data to populate the page is retrieved from the controller using an _AJAX_ call.

The HTML templates need to be generated individually for each domain class as they contain the markup needed to represent the properties of that class in a list or a form. However, the JavaScript used for the CRUD interface is the same for all domain classes.

## Limitations

This is an experimental work-in-progress. See the [issues list](https://github.com/robfletcher/grails-angular-scaffolding/issues) for outstanding features.

## Demo

There is [a demo of this plugin](http://grails-ng.cloudfoundry.com/) running on Cloud Foundry.

The demo application is also included under `test/apps/grails-ng` in this project.

## Tests

There are some simple end-to-end tests that use [Casper JS](http://casperjs.org/). To run the tests:

    cd test/apps/grails-ng
    grails run-app

Then in another terminal:

	casperjs test --includes=test/casper/includes/casper-angular.coffee test/casper/specs/
