# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $("#pericopes").on "cocoon:after-insert", (event, added_item) ->
    console.log("in cocoon:after-insert")
    num = $("#pericopes div.nested-fields").length
    console.log(num )
    added_item.find('.control-label').html('perikoop '+ num)
