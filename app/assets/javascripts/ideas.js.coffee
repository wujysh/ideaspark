$(document).on 'ready page:change', ->
  $('#tag-input')
    .tagsinput 'input'
    .typeahead
      prefetch: 'citynames.json'
    .bind 'typeahead:selected', $.proxy((obj, datum) ->
      @tagsinput 'add', datum.value
      @tagsinput 'input'
        .typeahead 'setQuery', '';
        ), $('#tag-input')