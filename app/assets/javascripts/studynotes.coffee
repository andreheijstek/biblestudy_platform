# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$('#pericopes').on('cocoon:after-insert', (e, inserted_item) ->
  console.log('in js')
  num = $('.pericopes').length
  inserted_item.find('.nested-fields').html('Field #'+num)
)
