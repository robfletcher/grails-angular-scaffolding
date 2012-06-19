casper.start 'http://localhost:8080/test-data/reset', ->
    @test.assertHttpStatus 200, 'test data is reset'

casper.thenOpen 'http://localhost:8080/album#/list', ->
    @waitForSelector 'tbody tr:nth-child(3)', ->
        @test.info 'clicking a row in the list'
        @click 'tbody tr:nth-child(1)'
    , ->
        @test.fail 'data should have loaded into the list page'

casper.then ->
    @test.assertUrlMatch /#\/show\/\d+$/, 'show view is loaded'

    @test.info 'when the edit button is clicked'
    @click 'a.btn'
    @test.assertUrlMatch /#\/edit\/\d+$/, 'edit view is loaded'

casper.back()
casper.then ->
    @test.assertUrlMatch /#\/show\/\d+$/, 'returned to show page'

casper.back()
casper.then ->
    @test.assertUrlMatch /#\/list$/, 'returned to list page'

    @test.info 'when the create link is clicked'
    @click '.subnav a.create'
    @test.assertUrlMatch /#\/create$/, 'create view is loaded'

    @test.info 'when the list link is clicked'
    @click '.subnav a.list'
    @test.assertUrlMatch /#\/list$/, 'list view is loaded'

casper.back()
casper.then ->
    @test.assertUrlMatch /#\/create$/, 'returned to create page'

casper.back()
casper.then ->
    @test.assertUrlMatch /#\/list$/, 'returned to list page'

casper.run ->
    @test.done()