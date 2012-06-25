# have to override casper's fill method to emit the 'input' event required by angular so the model updates
casper.fill = (selector, values, submit = false) ->
    @evaluate (selector, values) ->
        $("#{selector} [name='#{name}']").val(value).trigger('input') for name, value of values
    ,
        selector: selector
        values: values

# fetches the text in a table column as an array
casper.getColumn = (index) ->
    @evaluate (index) ->
        cells = $("tbody td:nth-child(#{index})")
        Array:: map.call cells, (e) -> $(e).text()
    ,
        index: index

# disables in-browser form validation so that tests can verify server-side validation
casper.disableFormValidation = (selector = 'form') ->
    @evaluate (selector) ->
        $(selector).attr('novalidate', '').find('button').prop('disabled', false)
    ,
        selector: selector

# asserts a selector is visible
casper.test.assertVisible = (selector, message = null) ->
    @assert casper.visible(selector), message

# asserts a selector is not visible
casper.test.assertNotVisible = (selector, message = null) ->
    @assertNot casper.visible(selector), message
