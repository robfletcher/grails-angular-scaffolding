class UrlMappings {

	static mappings = {
		"/album/index"(controller: "album", action: "index")
		"/album"(controller: "album", action: "list")
		"/album/$id?"(resource: "album")

		"/$controller/$action?/$id?"{
			constraints {
				// apply constraints here
			}
		}

		"/"(view:"/index")
		"500"(view:'/error')
	}
}
