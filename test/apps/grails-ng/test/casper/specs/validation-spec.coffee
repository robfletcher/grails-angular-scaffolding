# have to override casper's fill method to emit the 'input' event required by angular so the model updates
casper.fill = (selector, values) ->
    @evaluate (selector, values) ->
        $("#{selector} [name='#{key}']").val(value).trigger('input') for key, value of values
    ,
        selector: selector
        values: values

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

casper.run ->
    @test.done()