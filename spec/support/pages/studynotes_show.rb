# Page object for the studynotes/show page

class ShowStudynotesPage < SitePrism::Page
  set_url '/studynotes/show{/studynote}'

  element :title_field, 'h1'
  element :pericope1_field, 'pericope'
  element :studynote_field, 'div'
  element :author_field, 'trix-editor' # table met id attributes, eerste row
  element :datetime_field, 'trix-editor' # table met id attributes, eerste row
end
