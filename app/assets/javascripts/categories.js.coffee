add = ->
  $('form').on 'click', '#remove_fields', (event) ->
    $(this).closest('.field').remove()
    event.preventDefault()
  $('form').on 'click', '.add_fields', (event) ->
    regexp = undefined
    time = undefined
    time = (new Date).getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before $(this).data('fields').replace(regexp, time)
    event.preventDefault()
  return
$(document).on 'page:change', add
