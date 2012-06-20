fixture = null
casper.start 'http://localhost:8080/test-data/reset', ->
    @test.assertHttpStatus 200, 'test data is reset'
    fixture = JSON.parse(@fetchText('pre'))

casper.thenOpen 'http://localhost:8080/album#/show/1', ->
    @test.assertUrlMatch /#\/list$/, 'invalid id in show URL redirects to the list page'
    @test.assertEquals @fetchText('.alert-error'), 'Album not found with id 1', 'not-found message is displayed'
    @click 'tbody tr:nth-child(1)'

casper.then ->
    @test.assertUrlMatch /#\/show\/\d+$/, 'can visit a valid show page'

casper.back()

casper.then ->
    @test.assertUrlMatch /#\/list$/, 'returned to list page'
    @waitForSelector 'tbody tr', ->
        @test.fail "no alert should be displayed but found '#{@fetchText('.alert-error')}`" if @exists('.alert-error')

casper.thenOpen 'http://localhost:8080/album#/edit/1', ->
    @test.assertUrlMatch /#\/list$/, 'invalid id in edit URL redirects to the list page'
    @test.assertEquals @fetchText('.alert-error'), 'Album not found with id 1', 'not-found message is displayed'

casper.run ->
    @test.done()