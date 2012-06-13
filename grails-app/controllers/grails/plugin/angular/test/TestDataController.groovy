package grails.plugin.angular.test

class TestDataController {

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
