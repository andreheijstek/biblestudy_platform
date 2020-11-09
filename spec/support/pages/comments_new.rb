# frozen_string_literal: true
# Page object for the studynotes/new page
class NewCommentPage < SitePrism::Page
  set_url '/studynotes/{/studynote}/comments/new'

  elements :comment_field, '#comment_description'
  element :comment_button, '.btn'
end
