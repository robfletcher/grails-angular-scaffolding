package grails.plugin.angular.test

import grails.plugin.gson.converters.GSON
import org.springframework.dao.DataIntegrityViolationException
import static javax.servlet.http.HttpServletResponse.*
import static org.codehaus.groovy.grails.web.servlet.HttpHeaders.*
import static grails.plugin.gson.http.HttpConstants.*

class AlbumController {

	def index() { }

	def list(Integer max) {
		params.max = Math.min(max ?: 10, 100)
		response.addIntHeader X_PAGINATION_TOTAL, Album.count()
		render Album.list(params) as GSON
	}

	def save() {
		if (!requestIsJson()) {
			respondNotAcceptable()
			return
		}

		def albumInstance = new Album(request.GSON)
		if (albumInstance.save(flush: true)) {
			respondCreated albumInstance
		} else {
			respondUnprocessableEntity albumInstance
		}
	}

	def show(long id) {
		def albumInstance = Album.get(id)
		if (albumInstance) {
			respondFound albumInstance
		} else {
			respondNotFound id
		}
	}

	def update(long id) {
		if (!requestIsJson()) {
			respondNotAcceptable()
			return
		}

		def albumInstance = Album.get(id)
		if (!albumInstance) {
			respondNotFound id
			return
		}

		if (params.version != null) {
			if (albumInstance.version > params.long('version')) {
				respondConflict(albumInstance)
				return
			}
		}

		albumInstance.properties = request.GSON

		if (albumInstance.save(flush: true)) {
			respondUpdated albumInstance
		} else {
			respondUnprocessableEntity albumInstance
		}
	}

	def delete(long id) {
		def albumInstance = Album.get(id)
		if (!albumInstance) {
			respondNotFound id
			return
		}

		try {
			albumInstance.delete(flush: true)
			respondDeleted id
		} catch (DataIntegrityViolationException e) {
			respondNotDeleted id
		}
	}

	private boolean requestIsJson() {
		GSON.isJson(request)
	}

	private void respondFound(Album albumInstance) {
		response.status = SC_OK
		render albumInstance as GSON
	}

	private void respondUpdated(Album albumInstance) {
		response.status = SC_OK
		render albumInstance as GSON
	}

	private void respondDeleted(id) {
		def responseBody = [:]
		responseBody.message = message(code: 'default.deleted.message', args: [message(code: 'album.label', default: 'Album'), id])
		response.status = SC_OK
		render responseBody as GSON
	}

	private void respondCreated(Album albumInstance) {
		response.status = SC_CREATED
		response.addHeader LOCATION, createLink(action: 'show', id: albumInstance.id)
		render albumInstance as GSON
	}

	private void respondNotFound(id) {
		def responseBody = [:]
		responseBody.message = message(code: 'default.not.found.message', args: [message(code: 'album.label', default: 'Album'), id])
		response.status = SC_NOT_FOUND
		render responseBody as GSON
	}

	private void respondNotAcceptable() {
		response.status = SC_NOT_ACCEPTABLE
		response.contentLength = 0
		response.outputStream.flush()
		response.outputStream.close()
	}

	private void respondConflict(Album albumInstance) {
		albumInstance.errors.rejectValue('version', 'default.optimistic.locking.failure',
				[message(code: 'album.label', default: 'Album')] as Object[],
				'Another user has updated this Album while you were editing')
		def responseBody = [:]
		responseBody.errors = albumInstance.errors.allErrors.collect {
			message(error: it)
		}
		response.status = SC_CONFLICT
		render responseBody as GSON
	}

	private void respondUnprocessableEntity(Album albumInstance) {
		def responseBody = [:]
		responseBody.errors = albumInstance.errors.allErrors.collect {
			message(error: it)
		}
		response.status = SC_UNPROCESSABLE_ENTITY
		render responseBody as GSON
	}

	private void respondNotDeleted(id) {
		def responseBody = [:]
		responseBody.message = message(code: 'default.not.deleted.message', args: [message(code: 'album.label', default: 'Album'), id])
		response.status = SC_INTERNAL_SERVER_ERROR
		render responseBody as GSON
	}

}
