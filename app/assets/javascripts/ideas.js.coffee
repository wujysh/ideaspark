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
    
  $('.idea-form')
    .submit ->
      tags = $('#tag-input').val() || ''
      $('.idea-form').append "<input type=\"hidden\" name='\idea[tags]'\" value=\"#{tags}\">"
      valuesToSubmit = @serialize()
      $.ajax
        url: @attr('action')
        data: valuesToSubmit
        dataType: "JSON"
        .success (json)->
          console.log json
      return false