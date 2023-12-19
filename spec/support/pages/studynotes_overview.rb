# frozen_string_literal: true

# Page object for the studynotes/show page
class StudynotesOverviewPage < SitePrism::Page
  set_url "/"

  elements :biblebooks, "button.biblebook"
  elements :studynotes, "tr.studynote"
end
