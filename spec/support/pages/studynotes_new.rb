# frozen_string_literal: true
# Page object for the pericopes within the studynotes/new page
class PericopeSection < SitePrism::Section
  element :delete_pericope_button, 'iets'
end

# Page object for the studynotes/new page
class NewStudynotesPage < SitePrism::Page
  set_url '/studynotes/new'

  elements :pericopes, '.form-control'
  # sections :pericopesection, PericopeSection, 'div#pericopes'
  element :add_pericope_button, '#add_pericope'

  element :title_field, '#studynote_title'
  element :studynote_field, 'trix-editor'
  element :submit_button, '#submit_form'
end
