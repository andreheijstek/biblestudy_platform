# frozen_string_literal: true

# Page object for the admin page
class AdminBiblebooksPage < SitePrism::Page
  set_url "/admin/biblebooks"

  element :new_biblebook_button, "#new_biblebook"
  elements :biblebooks, "Biblebooks"
end
