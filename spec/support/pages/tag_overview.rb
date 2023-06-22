# frozen_string_literal: true

# Page object for the tags/show page
class TagsOverviewPage < SitePrism::Page
  set_url "/"

  element :tab_list, "#myTabs li"
  element :tags_button, "#tags_tab"
  element :studynotes_button, "#studynotes_tab"
end
