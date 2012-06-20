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

        @click 'a.btn'
    , ->
        @test.fail 'should have gone to the show page'

casper.then ->
    @test.assertUrlMatch /#\/edit\/\d+$/, 'now on the edit page'
    @fill 'form',
        title: 'Odd Blood'
    @click 'button.btn-primary'

casper.then ->
    @waitForSelector '[data-ng-bind="item.artist"]:not(:empty)', ->
        @test.assertUrlMatch /#\/show\/\d+$/, 'now on the show page'
        @test.assert @visible('.alert'), 'alert should be visible'
        @test.assert /Album \d+ updated/.test(@fetchText('.alert')), 'item updated message should be displayed'
    , ->
        @test.fail 'should have gone to the show page'

casper.run ->
    @test.done()