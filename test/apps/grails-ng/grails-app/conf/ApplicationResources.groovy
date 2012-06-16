modules = {
	bootstrap {
		resource url: 'bootstrap/css/bootstrap.min.css'
		resource url: 'bootstrap/js/bootstrap.min.js'
	}
	'font-awesome' {
		resource url: 'font-awesome/css/font-awesome.css'
	}
	'ui-common' {
		dependsOn 'bootstrap', 'font-awesome'
	}
}