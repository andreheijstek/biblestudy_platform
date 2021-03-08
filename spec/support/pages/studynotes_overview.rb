# frozen_string_literal: true

# Page object for the studynotes/show page
class StudynotesOverviewPage < SitePrism::Page
  set_url '/'

  elements :biblebooks, 'h4.panel-title'
  elements :studynotes, 'tr.studynote'
end
