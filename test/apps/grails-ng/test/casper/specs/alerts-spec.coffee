fixture = null
casper.start 'http://localhost:8080/test-data/reset', ->
    @test.assertHttpStatus 200, 'test data is reset'
    fixture = JSON.parse(@fetchText('pre'))

casper.thenOpen 'http://localhost:8080/album#/list', ->
    @test.assertNot @visible('.alert'), 'alert should not be visible'

casper.thenOpen 'http://localhost:8080/album#/create', ->
    @fill 'form',
        artist: 'Yeasayer'
        title: 'Fragrant World'
    @click 'button.btn-primary'

casper.then ->
    @waitForSelector '[data-ng-bind="item.artist"]:not(:empty)', ->
        @test.assertUrlMatch /#\/show\/\d+$/, 'now on the show page'
        @test.assert @visible('.alert'), 'alert should be visible'
        @test.assert /Album \d+ created/.test(@fetchText('.alert')), 'item created message should be displayed'
    , ->
        @test.fail 'should have gone to the show page'

casper.run ->
    @test.done()