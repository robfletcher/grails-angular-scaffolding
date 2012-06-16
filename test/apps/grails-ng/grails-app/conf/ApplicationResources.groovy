modules = {
	bootstrap {
		resource url: 'bootstrap/css/bootstrap.min.css'
		resource url: 'bootstrap/js/bootstrap.min.js'
	}
	'font-awesome' {
		resource url: 'font-awesome/css/font-awesome.css'
	}
	fonts {
		resource url: 'fonts/chunk/stylesheet.css'
	}
	'ui-common' {
		dependsOn 'bootstrap', 'font-awesome', 'fonts'
	}
}