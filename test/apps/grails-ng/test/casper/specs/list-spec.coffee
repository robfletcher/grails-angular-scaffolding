getAlbums = ->
    albums = document.querySelectorAll 'tbody td:nth-child(2)'
    Array:: map.call albums, (e) -> e.innerText

albums = []

casper.start 'http://localhost:8080/test-data/reset', ->
    @test.assertHttpStatus 200, 'test data is reset'

casper.thenOpen 'http://localhost:8080/album', ->
    @test.info 'scaffolded page opens list view by default'
    @test.assertHttpStatus 200, 'page loads successfully'
    @test.assertUrlMatch /#\/list$/, 'list view is loaded'

casper.then ->
    @test.info 'list data loads from the server...'
    @waitForSelector 'tbody tr:nth-child(5)', ->
        albums = @evaluate getAlbums
        @test.assert title in albums, "'#{title}' appears in the album list" for title in ['Zonoscope', 'Here', 'Sound Kapital', 'Synthetica', 'Master of My Make Believe']
    , ->
        @test.fail 'data should have loaded into the list page'

casper.run ->
    @test.done()