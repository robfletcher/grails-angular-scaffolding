casper.start 'http://localhost:8080/test-data/reset', ->
    @test.assertHttpStatus 200, 'test data is reset'

casper.thenOpen 'http://localhost:8080/album#/list', ->
    @waitForSelector 'tbody tr:nth-child(3)', ->
        @test.info 'clicking a row in the list'
        @click 'tbody tr:nth-child(1)'
        @test.assertUrlMatch /#\/show\/\d+$/, 'show view is loaded'
    , ->
        @test.fail 'data should have loaded into the list page'

casper.then ->
    @test.info 'going back'
    @back
    @waitFor ->
        /#\/list$/.test(@getCurrentUrl())
    , ->
        @test.pass 'returns to the list page'
    , ->
        @test.fail 'should have returned to the list page'

casper.run ->
    @test.done()