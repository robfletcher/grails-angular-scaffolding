package grails.plugin.angular.test

class Review {

    int rating
    String text

    static constraints = {
        rating range: 1..5
        text blank: true
    }

}
