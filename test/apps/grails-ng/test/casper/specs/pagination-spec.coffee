fixture = null
casper.start 'http://localhost:8080/test-data/reset', ->
    @test.assertHttpStatus 200, 'test data is reset'
    fixture = JSON.parse(@fetchText('pre'))

casper.thenOpen 'http://localhost:8080/album#/list?max=2', ->
    @test.info 'on a list view with 2 max items'
    @waitForSelector 'tbody tr', ->
        @test.assertEvalEquals ->
            $('.pagination li').length
        , Math.ceil(fixture.length / 2) + 2, 'correct number of pagination links are present'
        @test.assertEquals @fetchText('.pagination .active a'), '1', 'first page is active'
        @test.assertEval ->
            $('.pagination li:first-child').hasClass('disabled')
        , 'previous link is disabled as we are on the first page'

        titles = @getColumn(2)
        @test.assert album.title in titles, "'#{album.title}' appears in the list" for album in fixture[..1]
        @test.assert album.title not in titles, "'#{album.title}' does not appear in the list" for album in fixture[2..]

        @test.info 'clicking the next page button'
        @click '.pagination li:last-child a'
    , ->
        @test.fail 'data should have loaded into the list page'

casper.then ->
    @test.assertUrlMatch /\?max=2&offset=2$/, 'on page 2 of the list'
    @waitForSelector 'tbody tr', ->
        @test.assertEquals @fetchText('.pagination .active a'), '2', 'second page is selected'
        @test.assertEval ->
            !$('.pagination li:first-child').hasClass('disabled')
        , 'previous link is enabled as we are not on the first page'

        titles = @getColumn(2)
        @test.assert album.title not in titles, "'#{album.title}' does not appear in the list" for album in fixture[..1]
        @test.assert album.title in titles, "'#{album.title}' appears in the list" for album in fixture[2..3]
        @test.assert album.title not in titles, "'#{album.title}' does not appear in the list" for album in fixture[4..]

        @test.info 'clicking the next page button'
        @click '.pagination li:last-child a'
    , ->
        @test.fail 'data should have loaded into the list page'

casper.then ->
    @test.assertUrlMatch /\?max=2&offset=4$/, 'on page 3 of the list'
    @waitForSelector 'tbody tr', ->
        @test.assertEquals @fetchText('.pagination .active a'), '3', 'third page is selected'
        @test.assertEval ->
            $('.pagination li:last-child').hasClass('disabled')
        , 'next link is disabled as we are on the last page'

        titles = @getColumn(2)
        @test.assert album.title not in titles, "'#{album.title}' does not appear in the list" for album in fixture[..3]
        @test.assert album.title in titles, "'#{album.title}' appears in the list" for album in fixture[4..]

        @test.info 'next page button should not be clickable on the last page'
        @click '.pagination li:last-child a'
    , ->
        @test.fail 'data should have loaded into the list page'

casper.then ->
    @test.assertUrlMatch /\?max=2&offset=4$/, 'still on page 3 of the list'

    @test.info 'clicking the 1st page button'
    @click '.pagination li:nth-child(2) a'

casper.then ->
    @test.assertUrlMatch /\?max=2&offset=0$/, 'back on page 1'

    @test.info 'previous page button should not be clickable on the first page'
    @click '.pagination li:first-child a'

casper.then ->
    @test.assertUrlMatch /\?max=2&offset=0$/, 'still on page 1'

casper.run ->
    @test.done()