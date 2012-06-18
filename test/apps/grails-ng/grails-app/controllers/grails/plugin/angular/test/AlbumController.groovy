package grails.plugin.angular.test

import org.springframework.dao.DataIntegrityViolationException
import grails.converters.JSON
import static javax.servlet.http.HttpServletResponse.*

class AlbumController {

    static final int SC_UNPROCESSABLE_ENTITY = 422

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() { }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        render Album.list(params) as JSON
    }

    def save() {
        def albumInstance = new Album(request.JSON)
        def responseJson = [:]
        if (albumInstance.save(flush: true)) {
            response.status = SC_CREATED
            responseJson.id = albumInstance.id
            responseJson.message = message(code: 'default.created.message', args: [message(code: 'album.label', default: 'Album'), albumInstance.id])
        } else {
            response.status = SC_UNPROCESSABLE_ENTITY
            responseJson.errors = albumInstance.errors.fieldErrors.collectEntries {
                [(it.field): message(error: it)]
            }
        }
		cache false
        render responseJson as JSON
    }

    def get() {
        def albumInstance = Album.get(params.id)
        if (albumInstance) {
			cache false
			render albumInstance as JSON
        } else {
			notFound params.id
		}
    }

    def update() {
        def albumInstance = Album.get(params.id)
        if (!albumInstance) {
            notFound params.id
            return
        }

        def responseJson = [:]

        if (request.JSON.version != null) {
            if (albumInstance.version > request.JSON.version) {
                render status: SC_CONFLICT, text: message(code: 'default.optimistic.locking.failure',
                          args: [message(code: 'album.label', default: 'Album')],
                          default: 'Another user has updated this Album while you were editing')
                return
            }
        }

        albumInstance.properties = request.JSON

        if (albumInstance.save(flush: true)) {
            response.status = SC_OK
            responseJson.id = albumInstance.id
            responseJson.message = message(code: 'default.updated.message', args: [message(code: 'album.label', default: 'Album'), albumInstance.id])
        } else {
            response.status = SC_UNPROCESSABLE_ENTITY
            responseJson.errors = albumInstance.errors.fieldErrors.collectEntries {
                [(it.field): message(error: it)]
            }
        }

		cache false
		render responseJson as JSON
    }

    def delete() {
        def albumInstance = Album.get(params.id)
        if (!albumInstance) {
            notFound params.id
            return
        }

        def responseJson = [:]
        try {
            albumInstance.delete(flush: true)
            responseJson.message = message(code: 'default.deleted.message', args: [message(code: 'album.label', default: 'Album'), params.id])
        } catch (DataIntegrityViolationException e) {
            response.status = SC_CONFLICT
            responseJson.message = message(code: 'default.not.deleted.message', args: [message(code: 'album.label', default: 'Album'), params.id])
        }
		cache false
		render responseJson as JSON
    }

    private void notFound(id) {
        response.status = SC_NOT_FOUND
        def responseJson = [message: message(code: 'default.not.found.message', args: [message(code: 'album.label', default: 'Album'), params.id])]
        render responseJson as JSON
    }
}
