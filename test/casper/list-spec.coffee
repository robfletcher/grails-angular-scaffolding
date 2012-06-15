getAlbums = ->
    albums = document.querySelectorAll 'tbody td:nth-child(2)'
    Array:: map.call albums, (e) -> e.innerText

albums = []

casper.start 'http://localhost:8080/test-data/reset', ->
    @test.assertTextExists 'OK', 'test data is reset'

casper.thenOpen 'http://localhost:8080/album', ->
    @test.info 'scaffolded page opens list view by default'
    @test.assertHttpStatus 200, 'page loads successfully'
    @test.assertUrlMatch /#\/list$/, 'list view is loaded'

casper.then ->
    @test.info 'list data loads from the server...'
    @waitForSelector 'tbody tr:nth-child(3)', ->
        albums = @evaluate getAlbums
        @test.assertEquals albums[0], 'Here', '1st album title is correct'
        @test.assertEquals albums[1], 'Synthetica', '2nd album title is correct'
        @test.assertEquals albums[2], 'Master of My Make Believe', '3rd album title is correct'

casper.run ->
    @test.done()