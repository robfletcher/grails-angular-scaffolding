package grails.plugin.angular.test

class Album {

    String artist
    String title
    String year
    boolean compilation
    Review review

    static constraints = {
        artist blank: false
        title blank: false, unique: 'artist'
        year blank: true, matches: /\d{4}/
        compilation()
        review nullable: true
    }

    static embedded = ['review']

	static mapping = {
		sort 'artist'
	}
}
