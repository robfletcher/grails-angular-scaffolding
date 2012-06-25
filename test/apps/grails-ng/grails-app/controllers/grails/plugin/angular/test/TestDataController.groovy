package grails.plugin.angular.test

import grails.util.GrailsUtil
import static javax.servlet.http.HttpServletResponse.SC_FORBIDDEN

class TestDataController {

	def beforeInterceptor = [action: this.&filter]

	private filter() {
		if (GrailsUtil.environment == 'production') {
			render status: SC_FORBIDDEN, text: 'Not available in production environment'
			return false
		}
	}

	def reset() {
		Album.withSession { session ->
			for (album in Album.list()) album.delete()
            session.flush()
        }

        Album.withSession { session ->
            new Album(artist: 'Edward Sharpe and the Magnetic Zeroes', title: 'Here').save(failOnError: true)
			new Album(artist: 'Metric', title: 'Synthetica').save(failOnError: true)
			new Album(artist: 'Santigold', title: 'Master of My Make Believe').save(failOnError: true)
			new Album(artist: 'Cut Copy', title: 'Zonoscope').save(failOnError: true)
			new Album(artist: 'Handsome Furs', title: 'Sound Kapital').save(failOnError: true)
			session.flush()
		}

		render view: 'reset', model: [data: Album.list()]
	}

}
