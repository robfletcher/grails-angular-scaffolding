import grails.plugin.angular.test.Album

class BootStrap {

    def init = { servletContext ->
        if (Album.count() == 0) {
            new Album(artist: 'Edward Sharpe and the Magnetic Zeroes', title: 'Here', year: '2012').save(failOnError: true)
            new Album(artist: 'Metric', title: 'Synthetica', year: '2012').save(failOnError: true)
            new Album(artist: 'Santigold', title: 'Master of My Make Believe', year: '2012').save(failOnError: true)
        }
    }

    def destroy = {
    }

}
