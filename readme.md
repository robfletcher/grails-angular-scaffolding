This is a Grails plugin that allows you to use [Angular.js](http://angularjs.org/) based scaffolding.

## Usage

After installing the plugin run:

	grails ng-install-templates
	grails generate-controller _domain class name_
	grails ng-generate-views _domain class name_

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
