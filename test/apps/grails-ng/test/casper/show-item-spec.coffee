casper.start 'http://localhost:8080/test-data/reset', ->
    @test.assertTextExists 'OK', 'test data is reset'

casper.thenOpen 'http://localhost:8080/album', ->
    @test.info 'clicking on a row in the list page transitions to the show page'
    @test.assertHttpStatus 200, 'page loads successfully'
    @waitForSelector 'tbody tr:nth-child(3)', ->
        @click 'tbody tr:nth-child(1)'

casper.then ->
    @test.assertUrlMatch /#\/show\/\d+$/, 'show view is loaded'
    @waitFor ->
        @evaluate ->
            $('#artist-label + *').text() != ''
        @test.assertEquals @fetchText('#artist-label + *'), 'Edward Sharpe and the Magnetic Zeroes', 'album artist is correct'
        @test.assertEquals @fetchText('#title-label + *'), 'Here', 'album title is correct'

casper.run ->
    @test.done()