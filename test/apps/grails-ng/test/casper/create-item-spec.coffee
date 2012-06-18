casper.start 'http://localhost:8080/test-data/reset', ->
    @test.assertTextExists 'OK', 'test data is reset'

casper.thenOpen 'http://localhost:8080/album#/create', ->
    @test.info 'when a new item is saved'
    @fill 'form',
        artist: 'Yeasayer'
        title: 'Fragrant World'
    @evaluate ->
        $('#artist').trigger('input')
        $('#title').trigger('input')
    @click 'button.btn-primary'

casper.then ->
    @waitFor ->
        /#\/show\/\d+$/.test(@getCurrentUrl()) && @fetchText('[data-ng-bind="item.artist"]') != ''

casper.then ->
    @test.assertEquals @fetchText('[data-ng-bind="item.artist"]'), 'Yeasayer', 'album artist is correct'
    @test.assertEquals @fetchText('[data-ng-bind="item.title"]'), 'Fragrant World', 'album title is correct'

casper.run ->
    @test.done()