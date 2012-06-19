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
        @test.assertEquals albums[0], 'Zonoscope', '1st album title is correct'
        @test.assertEquals albums[1], 'Here', '2nd album title is correct'
        @test.assertEquals albums[2], 'Sound Kapital', '3rd album title is correct'
        @test.assertEquals albums[3], 'Synthetica', '4th album title is correct'
        @test.assertEquals albums[4], 'Master of My Make Believe', '5th album title is correct'

casper.run ->
    @test.done()