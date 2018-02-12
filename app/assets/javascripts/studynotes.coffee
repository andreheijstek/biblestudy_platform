# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $("#pericopes").on "cocoon:after-insert", (event, added_item) ->
    num = $("#pericopes div.nested-fields").length
    added_item.find('.control-label').html('pericoop '+ num)
