fixture = null
casper.start 'http://localhost:8080/test-data/reset', ->
  @test.assertHttpStatus 200, 'test data is reset'
  fixture = JSON.parse(@fetchText('pre'))

casper.thenOpen 'http://localhost:8080/album#/list?max=2', ->
  @test.info 'scaffolded page opens list view by default'
  @test.assertHttpStatus 200, 'page loads successfully'

  @test.info 'clicking on the title column sorts the list'
  @click 'thead th:nth-child(2)'

casper.then ->
  @waitForSelector 'tbody tr', ->
    @test.info 'first page of results are sorted by title'
    @test.assertExists 'tbody tr:nth-child(2)', 'there are 2 rows in the list'
    @test.assertDoesntExist 'tbody tr:nth-child(3)', 'there is not a 3rd row in the list'
    titles = @getColumn(2)
    @test.assertEqual titles[i], title, "'#{title}' appears at position #{i+1} in the list" for title, i in ['Here', 'Master of My Make Believe']

    @test.info 'clicking the next page button goes to page 2'
    @click '.pagination li:last-child a'
  , ->
    @test.fail 'data should have loaded into the list page'

casper.then ->
  @waitForSelector 'tbody tr', ->
    @test.info 'second page of results are sorted by title'
    titles = @getColumn(2)
    @test.assertEqual titles[i], title, "'#{title}' appears at position #{i+1} in the list" for title, i in ['Sound Kapital', 'Synthetica']
  , ->
    @test.fail 'data should have loaded into the list page'


casper.run ->
  @test.done()
