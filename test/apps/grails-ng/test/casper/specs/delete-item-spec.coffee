getAlbums = ->
    albums = document.querySelectorAll 'tbody td:nth-child(2)'
    Array:: map.call albums, (e) -> e.innerText

albums = []
json = null

casper.start 'http://localhost:8080/test-data/reset', ->
    @test.assertHttpStatus 200, 'test data is reset'
    json = JSON.parse(@fetchText('pre'))

casper.then ->
    @test.info 'when the show page is opened'
    @open "http://localhost:8080/album#/show/#{json[0].id}"

casper.then ->
    @test.assertUrlMatch /#\/show\/\d+$/, 'show view is loaded'
    @waitFor ->
        @fetchText('[data-ng-bind="item.artist"]') != ''
    , ->
        @test.info 'when the delete button is clicked'
        @click 'button.btn-danger'
    , ->
        @test.fail 'data should have loaded into show page'

casper.then ->
    @test.info 'return to the list view'
    @test.assertUrlMatch /#\/list$/, 'the list view is loaded'
    @waitForSelector 'tbody tr:nth-child(4)', ->
        albums = @evaluate getAlbums
        @test.assertEquals albums.length, 4, 'there are now fewer items in the list'
        @test.assert json[0].title not in albums, 'the item has been deleted'
    , ->
        @test.fail 'data should have loaded into list page'

casper.run ->
    @test.done()