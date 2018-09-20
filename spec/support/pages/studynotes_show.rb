# frozen_string_literal: true
# Page object for the studynotes/show page

class StudynoteShowPage < SitePrism::Page
  set_url '/studynotes/show{/studynote}'

  element :title_field, '#title'
  element :pericope_field, '#pericope'
  element :studynote_field, '#studynote'
  element :author_field, '#author'
  element :datetime_field, '#created_at'
end
