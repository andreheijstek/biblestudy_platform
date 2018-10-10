# frozen_string_literal: true
# Page object for the studynotes/new page
class NewStudynotesPage < SitePrism::Page
  set_url '/studynotes/new'

  elements :pericopes, '.form-control'
  elements :remove_pericope_button, '.remove_fields'
  element :add_pericope_button, '#add_pericope'

  element :title_field, '#studynote_title'
  element :studynote_field, 'trix-editor'
  element :submit_button, '#submit_form'
end
