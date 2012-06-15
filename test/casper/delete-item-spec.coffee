getAlbums = ->
    albums = document.querySelectorAll 'tbody td:nth-child(2)'
    Array:: map.call albums, (e) -> e.innerText

albums = []

casper.start 'http://localhost:8080/test-data/reset', ->
    @test.assertTextExists 'OK', 'test data is reset'

casper.thenOpen 'http://localhost:8080/album', ->
    @test.info 'scaffolded page opens list view by default'
    @test.assertHttpStatus 200, 'page loads successfully'
    @waitForSelector 'tbody tr:nth-child(3)', ->
        @click 'tbody tr:nth-child(1)'

casper.then ->
    @test.assertUrlMatch /#\/show\/\d+$/, 'show view is loaded'
    @waitFor ->
        @evaluate ->
            $('#artist-label + *').text() != ''
        @test.info 'when the delete button is clicked'
        @click 'button.delete'

casper.then ->
    @test.assertUrlMatch /#\/list$/, 'the list view is loaded'
    @waitForSelector 'tbody tr:nth-child(2)', ->
        albums = @evaluate getAlbums
        @test.assertEquals albums.length, 2, 'there are now only 2 albums'
        @test.assertEquals albums[0], 'Synthetica', '1st album title is correct'
        @test.assertEquals albums[1], 'Master of My Make Believe', '2nd album title is correct'

casper.run ->
    @test.done()