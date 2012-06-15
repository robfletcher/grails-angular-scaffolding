This is a Grails plugin that allows you to use [Angular.js](http://angularjs.org/) based scaffolding.

## Usage

After installing the plugin run `grails generate-all _domain class name_` to install scaffolding.

## Limitations

This is an experimental work-in-progress. It is far from complete. See the [issues list](https://github.com/robfletcher/grails-angular-scaffolding/issues) for outstanding features.

- HTML templates for each page are not currently being generated. There are hardcoded ones for the test domain class.
- Currently default scaffolding GSP templates (_create,gsp_, _edit.gsp_, _list.gsp_, _show.gsp_ and __form.gsp_) will be created alongside the _Angular_ enabled _index.gsp_ you can delete these extra files.

## Demo

There is [a demo of this plugin](http://grails-ng.cloudfoundry.com/) running on Cloud Foundry

## Tests

There are some simple end-to-end tests that use [Casper JS](http://casperjs.org/). To run the tests:

	casperjs test test/casper
