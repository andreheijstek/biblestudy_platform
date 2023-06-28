# frozen_string_literal: true

# Page object for the admin page
class AdminHomePage < SitePrism::Page
  set_url "/admin/"

  element :users_link, "Users"
  element :biblebook_link, "Biblebooks"
end
