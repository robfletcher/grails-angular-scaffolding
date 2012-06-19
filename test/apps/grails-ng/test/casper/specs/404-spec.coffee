casper.start 'http://localhost:8080/album#/show/invalid', ->
    @test.assertUrlMatch /#\/list$/, 'invalid id in show URL redirects to the list page'

casper.thenOpen 'http://localhost:8080/album#/edit/invalid', ->
    @test.assertUrlMatch /#\/list$/, 'invalid id in edit URL redirects to the list page'

casper.run ->
    @test.done()