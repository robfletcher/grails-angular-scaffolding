casper.start 'http://localhost:8080/grails-ng/test-data/reset', ->
    @test.assertTextExists 'OK', 'test data is reset'

casper.thenOpen 'http://localhost:8080/grails-ng/album#/create', ->
    @test.info 'when a new item is saved'
    @fill 'form',
        artist: 'Yeasayer'
        title: 'Fragrant World'
    @click 'button.save'

casper.then ->
    @waitFor =>
        @evaluate =>
            @test.info @getCurrentUrl()
            /#\/show\/\d+$/.test(@getCurrentUrl())

casper.then ->
    @waitFor =>
        @evaluate =>
            jQuery('#artist-label + *').text() != ''

casper.then ->
    @test.assertEquals @fetchText('#artist-label + *'), 'Yeasayer', 'album artist is correct'
    @test.assertEquals @fetchText('#title-label + *'), 'Fragrant World', 'album title is correct'

casper.run ->
    @test.done()