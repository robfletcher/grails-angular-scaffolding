fixture = null
casper.start 'http://localhost:8080/test-data/reset', ->
    @test.assertHttpStatus 200, 'test data is reset'
    fixture = JSON.parse(@fetchText('pre'))

casper.then ->
    @open "http://localhost:8080/album#/edit/#{fixture[0].id}"

casper.then ->
    @test.info 'when duplicate data is submitted'
    @fill 'form',
        artist: fixture[1].artist
        title: fixture[1].title
    @click '.btn-primary'

casper.then ->
    # TODO: should be able to wait for #title.ng-invalid but server side validation is not setting Angular errors: https://github.com/robfletcher/grails-angular-scaffolding/issues/15
    @waitUntilVisible '#title + .help-inline', ->
        @test.assertExists '.error #title', 'title has error class'
        @test.assertEquals @fetchText('#title + .help-inline'), "Property [title] of class [class grails.plugin.angular.test.Album] with value [#{fixture[1].title}] must be unique", 'error message for the title field is displayed'
    , ->
        @test.fail 'error for the title field was not displayed'

casper.run ->
    @test.done()