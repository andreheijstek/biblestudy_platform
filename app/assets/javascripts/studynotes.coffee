# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  console.log('DOM is ready - add section')
  $("#add_pericope").on "ajax:success", (event, data) ->
    $("#pericopes").append data
    $(this).data "params", { index: $("#pericopes div.string").length }
  $("#delete_pericope").on "ajax.success", (event, data) ->
    console.log('in delete')




# Bij de add gebeurt hier het volgende:
# - als er een ajax-event 'add_pericope' gezien wordt
# - dan wordt aan het element #pericopes
# - de data toegevoegd, met als index de lengte van dit element
# -   wat gelijk is aan het aantal pericopen

# Om de delete er in te krijgen moet het volgende gebeuren:
# - als er een ajax-event 'remove_pericope' gezien wordt
# - dan wordt van het element #pericopes
# - het huidige element verwijderd
# - het huidige element is herkenbaar aan de index die in de ajax data wordt meegegeven
