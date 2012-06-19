# have to override casper's fill method to emit the 'input' event required by angular so the model updates
casper.fill = (selector, values, submit = false) ->
    @evaluate (selector, values) ->
        $("#{selector} [name='#{name}']").val(value).trigger('input') for name, value of values
    ,
        selector: selector
        values: values
