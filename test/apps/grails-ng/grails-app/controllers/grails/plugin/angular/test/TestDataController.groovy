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
		for (album in Album.list()) album.delete()

		def albums = []
		albums << new Album(artist: 'Edward Sharpe and the Magnetic Zeroes', title: 'Here').save(failOnError: true)
		albums << new Album(artist: 'Metric', title: 'Synthetica').save(failOnError: true)
		albums << new Album(artist: 'Santigold', title: 'Master of My Make Believe').save(failOnError: true)
		albums << new Album(artist: 'Cut Copy', title: 'Zonoscope').save(failOnError: true)
		albums << new Album(artist: 'Handsome Furs', title: 'Sound Kapital').save(failOnError: true)

		render view: 'reset', model: [data: albums]
	}

}
