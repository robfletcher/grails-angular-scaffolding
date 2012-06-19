json = null

casper.start 'http://localhost:8080/test-data/reset', ->
    @test.assertHttpStatus 200, 'test data is reset'
    json = JSON.parse(@fetchText('pre'))

casper.then ->
    @test.info 'when the edit page is opened'
    @open "http://localhost:8080/album#/edit/#{json[0].id}"

casper.then ->
    @test.info 'details are displayed correctly'
    @test.assertUrlMatch /#\/edit\/\d+$/, 'edit view is loaded'
    @test.assertEvalEquals ->
        $('input[name=artist]').val()
    , json[0].artist, 'artist field is correct'
    @test.assertEvalEquals ->
        $('input[name=title]').val()
    , json[0].title, 'title field is correct'

casper.then ->
    @test.info 'when the form is updated'
    @fill 'form',
        artist: 'Edward Sharpe & the Magnetic Zeroes'
    @click 'button.btn-primary'

casper.then ->
    @test.info 'the show page is displayed'
    @waitForSelector '[data-ng-bind="item.artist"]:not(:empty)', ->
        @test.assertEquals @fetchText('[data-ng-bind="item.artist"]'), 'Edward Sharpe & the Magnetic Zeroes', 'album artist is correct'
        @test.assertEquals @fetchText('[data-ng-bind="item.title"]'), json[0].title, 'album title is correct'
    , ->
        @test.fail 'show page should have loaded'

casper.run ->
    @test.done()