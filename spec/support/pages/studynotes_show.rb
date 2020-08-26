# frozen_string_literal: true
# Page object for the studynotes/show page

class ShowStudynotePage < SitePrism::Page
  set_url "/studynotes{/studynote}"

  element :title_field, '#title'
  element :pericope_field, '#pericope'
  element :studynote_field, '#studynote_note'
  element :author_field, '#author'
  element :datetime_field, '#created_at'

  element :comment_field, '#comment'
  element :comment_button, '.comment'

  element :update_button, '.edit'
  element :remove_button, '.delete'
  element :new_button, '.new'
end
