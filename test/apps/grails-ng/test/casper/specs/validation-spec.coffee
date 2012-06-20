casper.start 'http://localhost:8080/album#/create', ->
    @test.assertEval ->
        $('button.btn-primary').prop('disabled')
    , 'save button is initially disabled'

    @fill 'form',
        artist: 'Yeasayer'
        title: 'Fragrant World'
    @test.assertEval ->
        !$('button.btn-primary').prop('disabled')
    , 'save button is enabled when valid data is entered'

    @fill 'form',
        artist: ''
    @test.assertEval ->
        $('button.btn-primary').prop('disabled')
    , 'save button is disabled when invalid data is entered'

casper.run ->
    @test.done()