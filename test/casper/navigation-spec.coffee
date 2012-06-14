getAlbums = ->
    albums = document.querySelectorAll 'tbody td:nth-child(2)'
    Array:: map.call albums, (e) -> e.innerText

albums = []

casper.start 'http://localhost:8080/grails-ng/test-data/reset', ->
    @test.assertTextExists 'OK', 'test data is reset'

casper.thenOpen 'http://localhost:8080/grails-ng/album', ->
    @test.info 'clicking on a row in the list page transitions to the show page'
    @test.assertHttpStatus 200, 'page loads successfully'
    @waitForSelector 'tbody tr:nth-child(3)', ->
        albums = @evaluate getAlbums

        @test.info 'clicking a row in the list'
        @click 'tbody tr:nth-child(1)'
        @test.assertUrlMatch /#\/show\/\d+$/, 'show view is loaded'

        @test.info 'going back'
        @back
        @test.assertUrlMatch /#\/list$/, 'returns to the list page'

casper.run ->
    @test.done()