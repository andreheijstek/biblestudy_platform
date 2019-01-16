# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# TODO: Hardcoded string without i18n. But if I change it simply to
# t(pericope) the counting of pericopes fail
$ ->
  $("#pericopes").on "cocoon:after-insert", (event, added_item) ->
    console.log("in cocoon:after-insert")
    num = $("#pericopes div.nested-fields").length
    added_item.find('.control-label').html('bijbelgedeelte '+ num)
