# have to override casper's fill method to emit the 'input' event required by angular so the model updates
casper.fill = (selector, values) ->
    @evaluate (selector, values) ->
        for key, value of values
            $("#{selector} [name='#{key}']").val(value).trigger('input')
    ,
        selector: selector
        values: values

json = null

casper.start 'http://localhost:8080/test-data/reset', ->
    @test.assertHttpStatus 200, 'test data is reset'
    json = JSON.parse(@fetchText('pre'))

casper.then ->
    @test.info 'when the edit page is opened'
    @open "http://localhost:8080/album#/edit/#{json[0].id}"

casper.then ->
    @test.info 'details are displayed correctly'
    @test.assertUrlMatch /#\/edit\/\d+$/, 'edit view is loaded'
    @test.assertEvalEquals ->
        $('input[name=artist]').val()
    , 'Edward Sharpe and the Magnetic Zeroes', 'artist field is correct'
    @test.assertEvalEquals ->
        $('input[name=title]').val()
    , 'Here', 'title field is correct'

casper.then ->
    @test.info 'when the form is updated'
    @fill 'form',
        artist: 'Edward Sharpe & the Magnetic Zeroes'
    @click 'button.btn-primary'

casper.then ->
    @test.info 'the show page is displayed'
    @waitFor ->
        /#\/show\/\d+$/.test(@getCurrentUrl()) && @fetchText('[data-ng-bind="item.artist"]') != ''
    , ->
        @test.assertEquals @fetchText('[data-ng-bind="item.artist"]'), 'Edward Sharpe & the Magnetic Zeroes', 'album artist is correct'
        @test.assertEquals @fetchText('[data-ng-bind="item.title"]'), 'Here', 'album title is correct'

casper.run ->
    @test.done()