# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $("#pericopes").on "cocoon:after-insert", (event, added_item) ->
    num = $("#pericopes div.nested-fields:visible").length
    added_item.find('.control-label').html('bijbelgedeelte ' + num)
    console.log(num)
  $("#pericopes").on "cocoon:before-remove", (event, added_item) ->
    num = $("#pericopes div.nested-fields:visible").length
    if (num == 1)
#      alert(I18n.t(errors.message.at_least_one_pericope))
      alert("Je moet minimaal 1 pericope overhouden")
      event.preventDefault()

