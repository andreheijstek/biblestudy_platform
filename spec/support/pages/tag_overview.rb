# frozen_string_literal: true

# Page object for the tags/show page
class TagsOverviewPage < SitePrism::Page
  set_url "/"

  elements :tags_button, ".Tags"
end
