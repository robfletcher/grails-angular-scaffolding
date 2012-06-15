package grails.plugin.angular.test

import grails.util.GrailsUtil

import static javax.servlet.http.HttpServletResponse.SC_FORBIDDEN

class TestDataController {

    def beforeInterceptor = {
        if (GrailsUtil.environment == 'prod') {
            response.sendError SC_FORBIDDEN, 'Not available in production environment'
            return false
        }
    }

	def reset() {
		try {
			for (album in Album.list()) album.delete()

			new Album(artist: 'Edward Sharpe and the Magnetic Zeroes', title: 'Here').save(failOnError: true)
			new Album(artist: 'Metric', title: 'Synthetica').save(failOnError: true)
			new Album(artist: 'Santigold', title: 'Master of My Make Believe').save(failOnError: true)

			render 'OK'
		} catch (e) {
			render "ERROR: $e.message"
		}
	}

}
