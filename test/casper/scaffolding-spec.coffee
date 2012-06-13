getAlbums = ->
    albums = document.querySelectorAll 'tbody td:nth-child(2)'
    Array:: map.call albums, (e) -> e.innerText

albums = []

casper.start 'http://localhost:8080/grails-ng/album', ->
    @test.assertHttpStatus 200, 'page loads successfully'
    @test.assertUrlMatch /#\/list$/, 'list view is loaded'

casper.then ->
    @test.info 'list data loads from the server...'
    @waitForSelector 'tbody tr:nth-child(3)', ->
        albums = @evaluate getAlbums
        @test.assertEquals albums[0], 'Here', '1st album title is correct'
        @test.assertEquals albums[1], 'Synthetica', '2nd album title is correct'
        @test.assertEquals albums[2], 'Master of My Make Believe', '3rd album title is correct'

casper.then ->
    @test.info 'when a row in the list is clicked...'
    @click 'tbody tr:nth-child(1)'
    @test.assertUrlMatch /#\/show\/1$/, 'show view is loaded'
    @waitFor ->
        @evaluate ->
            $('#artist-label + *').text() != ''
        @test.assertEquals @fetchText('#artist-label + *'), 'Edward Sharpe and the Magnetic Zeroes', 'album artist is correct'
        @test.assertEquals @fetchText('#title-label + *'), 'Here', 'album title is correct'

casper.then ->
    @test.info 'when the delete button is clicked...'
    @click 'button.delete'
    @waitFor ->
        /#\/list$/.test @getCurrentUrl()
    @waitForSelector 'tbody tr:nth-child(2)', ->
        albums = @evaluate getAlbums
        @test.assertEquals albums.length, 2, 'there are now only 2 albums'
        @test.assertEquals albums[0], 'Synthetica', '1st album title is correct'
        @test.assertEquals albums[1], 'Master of My Make Believe', '2nd album title is correct'

casper.run ->
    @test.done()