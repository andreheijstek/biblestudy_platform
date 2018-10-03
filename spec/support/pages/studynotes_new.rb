# frozen_string_literal: true
# Page object for the pericopes within the studynotes/new page
class PericopeSection < SitePrism::Section
  element :pericope_field, '.form-control'
  element :delete_pericope_button, 'iets'
  element :add_pericope_button, '#add_pericope'
end

# Page object for the studynotes/new page
class NewStudynotesPage < SitePrism::Page
  set_url '/studynotes/new'

  sections :pericopes, PericopeSection, 'div#pericopes'

  element :title_field, '#studynote_title'
  element :studynote_field, 'trix-editor'
  element :submit_button, '#submit_form'
end
