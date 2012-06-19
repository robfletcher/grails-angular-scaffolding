casper.start 'http://localhost:8080/test-data/reset', ->
    @test.assertHttpStatus 200, 'test data is reset'

casper.thenOpen 'http://localhost:8080/album#/create', ->
    @test.info 'when a new item is saved'
    @fill 'form',
        artist: 'Yeasayer'
        title: 'Fragrant World'
    @click 'button.btn-primary'

casper.then ->
    @test.info 'should go to the show page'
    @waitFor ->
        /#\/show\/\d+$/.test(@getCurrentUrl()) and @fetchText('[data-ng-bind="item.artist"]') isnt ''
    , ->
        @test.info 'details should be displayed correctly'
        @test.assertEquals @fetchText('[data-ng-bind="item.artist"]'), 'Yeasayer', 'album artist is correct'
        @test.assertEquals @fetchText('[data-ng-bind="item.title"]'), 'Fragrant World', 'album title is correct'
    , ->
        @test.fail 'should have gone to the show page'

casper.run ->
    @test.done()