class UrlMappings {

	static mappings = {
		"/album/page"(controller: "album", action: "page")
		"/album"(resources: "album")

		"/"(view:"/index")
		"500"(view:'/error')
	}
}
