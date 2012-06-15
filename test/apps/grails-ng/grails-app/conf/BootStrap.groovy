import grails.plugin.angular.test.Album

class BootStrap {

    def init = { servletContext ->
        if (Album.count() == 0) {
            new Album(artist: 'Edward Sharpe and the Magnetic Zeroes', title: 'Here').save(failOnError: true)
            new Album(artist: 'Metric', title: 'Synthetica').save(failOnError: true)
            new Album(artist: 'Santigold', title: 'Master of My Make Believe').save(failOnError: true)
        }
    }

    def destroy = {
    }

}
