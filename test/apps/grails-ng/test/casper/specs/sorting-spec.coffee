fixture = null
casper.start 'http://localhost:8080/test-data/reset', ->
  @test.assertHttpStatus 200, 'test data is reset'
  fixture = JSON.parse(@fetchText('pre'))

casper.thenOpen 'http://localhost:8080/album', ->
  @test.info 'scaffolded page opens list view by default'
  @test.assertHttpStatus 200, 'page loads successfully'
  @test.assertUrlMatch /#\/list$/, 'list view is loaded'

casper.then ->
  @test.info 'list data loads from the server...'
  @waitForSelector 'tbody tr:nth-child(5)', ->
    @test.info 'clicking on the title column sorts the list'
    @click 'thead th:nth-child(2) a'
  , ->
    @test.fail 'data should have loaded into the list page'

casper.then ->
  @test.assertUrlMatch /\?sort=title$/, 'list is now sorted by title'
  @waitForSelector 'tbody tr', ->
#    assert that column header is active

    titles = @getColumn(2)
    @test.assert title == titles[i], "'#{title}' appears at position #{i+1} in the list" for title, i in ['Here', 'Master of My Make Believe', 'Sound Kapital', 'Synthetica', 'Zonoscope']

    @test.info 'clicking on the artist column sorts the list'
    @click 'thead th:nth-child(1) a'

casper.then ->
  @test.assertUrlMatch /\?sort=artist$/, 'list is now sorted by artist'
  @waitForSelector 'tbody tr', ->
#    assert that column header is active

    titles = @getColumn(2)
    @test.assert title == titles[i], "'#{title}' appears at position #{i+1} in the list" for title, i in ['Zonoscope', 'Here', 'Sound Kapital', 'Synthetica', 'Master of My Make Believe']

casper.run ->
  @test.done()