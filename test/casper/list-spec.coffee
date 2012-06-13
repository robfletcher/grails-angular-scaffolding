getAlbums = ->
    albums = document.querySelectorAll 'tbody td:nth-child(2)'
    Array:: map.call albums, (e) -> e.innerText

albums = []

casper.start 'http://localhost:8080/grails-ng/album', ->
    @test.assertHttpStatus 200, 'page loads successfully'
    @test.assertUrlMatch /#\/list$/, 'list view is loaded'
    @waitForSelector 'tbody tr:nth-child(3)', ->
        albums = @evaluate getAlbums
        @test.assertEquals albums[0], 'Here', '1st album title is correct'
        @test.assertEquals albums[1], 'Synthetica', '2nd album title is correct'
        @test.assertEquals albums[2], 'Master of My Make Believe', '3rd album title is correct'

casper.run ->
    @test.done()