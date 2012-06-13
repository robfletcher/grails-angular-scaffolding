package grails.plugin.angular.test

class Album {

    String artist
    String title

    static constraints = {
        artist blank: false
        title blank: false
    }
}
