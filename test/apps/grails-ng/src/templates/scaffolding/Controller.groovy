<%=packageName ? "package ${packageName}\n\n" : ''%>import org.springframework.dao.DataIntegrityViolationException
import grails.converters.JSON
import static javax.servlet.http.HttpServletResponse.*

class ${className}Controller {

    static final int SC_UNPROCESSABLE_ENTITY = 422

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() { }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
		response.setIntHeader('X-Pagination-Total', ${className}.count())
		render ${className}.list(params) as JSON
    }

    def save() {
        def ${propertyName} = new ${className}(request.JSON)
        def responseJson = [:]
        if (${propertyName}.save(flush: true)) {
            response.status = SC_CREATED
            responseJson.id = ${propertyName}.id
            responseJson.message = message(code: 'default.created.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), ${propertyName}.id])
        } else {
            response.status = SC_UNPROCESSABLE_ENTITY
            responseJson.errors = ${propertyName}.errors.fieldErrors.collectEntries {
                [(it.field): message(error: it)]
            }
        }
        render responseJson as JSON
    }

    def get() {
        def ${propertyName} = ${className}.get(params.id)
        if (${propertyName}) {
			render ${propertyName} as JSON
        } else {
			notFound params.id
		}
    }

    def update() {
        def ${propertyName} = ${className}.get(params.id)
        if (!${propertyName}) {
            notFound params.id
            return
        }

        def responseJson = [:]

        if (request.JSON.version != null) {
            if (${propertyName}.version > request.JSON.version) {<% def lowerCaseName = grails.util.GrailsNameUtils.getPropertyName(className) %>
				response.status = SC_CONFLICT
				responseJson.message = message(code: 'default.optimistic.locking.failure',
						args: [message(code: '${domainClass.propertyName}.label', default: '${className}')],
						default: 'Another user has updated this ${className} while you were editing')
				cache false
				render responseJson as JSON
				return
            }
        }

        ${propertyName}.properties = request.JSON

        if (${propertyName}.save(flush: true)) {
            response.status = SC_OK
            responseJson.id = ${propertyName}.id
            responseJson.message = message(code: 'default.updated.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), ${propertyName}.id])
        } else {
            response.status = SC_UNPROCESSABLE_ENTITY
            responseJson.errors = ${propertyName}.errors.fieldErrors.collectEntries {
                [(it.field): message(error: it)]
            }
        }

        render responseJson as JSON
    }

    def delete() {
        def ${propertyName} = ${className}.get(params.id)
        if (!${propertyName}) {
            notFound params.id
            return
        }

        def responseJson = [:]
        try {
            ${propertyName}.delete(flush: true)
            responseJson.message = message(code: 'default.deleted.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), params.id])
        } catch (DataIntegrityViolationException e) {
            response.status = SC_CONFLICT
            responseJson.message = message(code: 'default.not.deleted.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), params.id])
        }
        render responseJson as JSON
    }

    private void notFound(id) {
        response.status = SC_NOT_FOUND
        def responseJson = [message: message(code: 'default.not.found.message', args: [message(code: '${domainClass.propertyName}.label', default: '${className}'), params.id])]
        render responseJson as JSON
    }
}
