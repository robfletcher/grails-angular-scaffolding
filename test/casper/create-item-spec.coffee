casper.start 'http://localhost:8080/grails-ng/test-data/reset', ->
    @test.assertTextExists 'OK', 'test data is reset'

casper.thenOpen 'http://localhost:8080/grails-ng/album#/create', ->
    @test.info 'when a new item is saved'
    @fill 'form',
        artist: 'Yeasayer'
        title: 'Fragrant World'
    @captureSelector 'form.png', 'body'
#        , true
    @click 'button.save'

casper.then ->
    @waitFor ->
        /#\/show\/\d+$/.test(@getCurrentUrl())
        @waitFor ->
            @evaluate ->
                $('#artist-label + *').text() != ''
            @captureSelector 'show.png', 'body'
            @test.assertEquals @fetchText('#artist-label + *'), 'Yeasayer', 'album artist is correct'
            @test.assertEquals @fetchText('#title-label + *'), 'Fragrant World', 'album title is correct'

casper.run ->
    @test.done()