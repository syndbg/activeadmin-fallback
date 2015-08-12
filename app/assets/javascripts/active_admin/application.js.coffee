# Initializers
$(document).on 'ready page:load', ->
  # jQuery datepickers (also evaluates dynamically added HTML)
  $(document).on 'focus', 'input.datepicker:not(.hasDatepicker)', ->
    $input = $(@)

    # Only applying datepicker to compatible browsers
    return if $input[0].type is 'date'

    defaults = dateFormat: 'yy-mm-dd'
    options = $input.data 'datepicker-options'
    $input.datepicker $.extend(defaults, options)

  # Clear Filters button
  $('.js-clear-filters-button').click ->
    params = window.location.search.split('&')
    regex = /^(q\[|q%5B|q%5b|page|commit)/
    window.location.search = (param for param in params when not param.match(regex)).join('&')

  # Filter form: don't send any inputs that are empty
  $('.filter_form').submit ->
    $(@).find(':input').filter(-> @value is '').prop 'disabled', true

  # Filter form: for filters that let you choose the query method from
  # a dropdown, apply that choice to the filter input field.
  $('.filter_form_field.select_and_search select').change ->
    $(@).siblings('input').prop name: "q[#{@value}]"

  # Tab navigation
  $('#active_admin_content .tabs').tabs()
