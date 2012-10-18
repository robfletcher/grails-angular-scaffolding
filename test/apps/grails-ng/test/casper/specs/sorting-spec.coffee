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
    @click 'thead th:nth-child(2)'
  , ->
    @test.fail 'data should have loaded into the list page'

casper.then ->
  @waitForSelector 'thead th:nth-child(2).sorted', ->
    @test.assertDoesntExist 'thead th:nth-child(1).sorted', 'artist column should not have a sort indicator'

    titles = @getColumn(2)
    @test.assertEqual titles[i], title, "'#{title}' appears at position #{i+1} in the list" for title, i in ['Here', 'Master of My Make Believe', 'Sound Kapital', 'Synthetica', 'Zonoscope']

    @test.info 'clicking on the artist column sorts the list'
    @click 'thead th:nth-child(1)'
  , ->
    @test.fail 'table should be sorted by title'

casper.then ->
  @waitForSelector 'thead th:nth-child(1).sorted', ->
    @test.assertDoesntExist 'thead th:nth-child(2).sorted', 'title column should not have a sort indicator'

    titles = @getColumn(1)
    @test.assertEqual titles[i], title, "'#{title}' appears at position #{i+1} in the list" for title, i in ['Cut Copy', 'Edward Sharpe and the Magnetic Zeroes', 'Handsome Furs', 'Metric', 'Santigold']

    @test.info 'clicking on the artist column again reverses the order'
    @click 'thead th:nth-child(1)'
  , ->
    @test.fail 'table should be sorted by artist'

casper.then ->
  @waitForSelector 'thead th:nth-child(1).sorted.desc', ->
    titles = @getColumn(1)
    @test.assertEqual titles[i], title, "'#{title}' appears at position #{i+1} in the list" for title, i in ['Santigold', 'Metric', 'Handsome Furs', 'Edward Sharpe and the Magnetic Zeroes', 'Cut Copy']

    @test.info 'changing the sort property reverts to ascending order'
    @click 'thead th:nth-child(2)'
  , ->
    @test.fail 'table should be sorted by artist descending'

casper.then ->
  @waitForSelector 'thead th:nth-child(2).sorted', ->
    @test.assertDoesntExist 'thead th.desc', 'table should no longer be sorted descending'

    titles = @getColumn(2)
    @test.assertEqual titles[i], title, "'#{title}' appears at position #{i+1} in the list" for title, i in ['Here', 'Master of My Make Believe', 'Sound Kapital', 'Synthetica', 'Zonoscope']
  , ->
    @test.fail 'table should be sorted by artist ascending'

casper.run ->
  @test.done()