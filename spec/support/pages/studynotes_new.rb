# Page object for the studynotes/new page

class NewStudynotesPage < SitePrism::Page
  set_url '/studynotes/new'
  # set_url_matcher /google.com\/?/

  element :pericope1_field, 'input[name="studynote[pericopes_attributes][0][name]"]'
  element :title_field, 'input[name="studynote[title]"]'
  element :studynote_field, 'trix-editor'
  element :commit_button, 'input[name="commit"]'
end
