casper.start 'http://localhost:8080/album#/create', ->
    @disableFormValidation()
    @test.info 'when an empty form is submitted'
    @click '.btn-primary'

casper.then ->
    @waitUntilVisible '.help-inline', ->
        for field in ['artist', 'title', 'year']
            @test.assertExists ".error ##{field}", "#{field} has error class"
            @test.assertEquals @fetchText("##{field} + .help-inline"), "Property [#{field}] of class [class grails.plugin.angular.test.Album] cannot be null", "error message is displayed for #{field}"
            @test.assertVisible "##{field} + .help-inline", "error message for #{field} is visible"

        @test.info 'when a partially completed form is submitted'
        @fill 'form',
            artist: 'Yeasayer'
            year: 'foo'
        @click '.btn-primary'
    , ->
        @test.fail 'submit did not complete'

casper.then ->
    @waitForSelector '#artist:not(.ng-invalid)', ->
        @test.assertNotExists ".error #artist", "artist does not have error class"
        @test.assertEquals @fetchText("#artist + .help-inline"), '', "error message is not displayed for artist"
        @test.assertNotVisible "#artist + .help-inline", "error message for artist is not visible"

        @test.assertExists ".error #title", "title has error class"
        @test.assertEquals @fetchText("#title + .help-inline"), "Property [title] of class [class grails.plugin.angular.test.Album] cannot be null", "error message is displayed for title"
        @test.assertVisible "#title + .help-inline", "error message for title is visible"
        @test.assertExists ".error #year", "year has error class"
        @test.assertEquals @fetchText("#year + .help-inline"), "Property [year] of class [class grails.plugin.angular.test.Album] with value [foo] does not match the required pattern [\\d{4}]", "error message is displayed for year"
        @test.assertVisible "#year + .help-inline", "error message for year is visible"
    , ->
        @test.fail 'submit did not complete'

casper.run ->
    @test.done()