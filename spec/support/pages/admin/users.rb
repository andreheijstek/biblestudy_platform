# frozen_string_literal: true

# Page object for the admin page
class AdminUserPage < SitePrism::Page
  set_url "/admin/users"

  element :new_user_button, ".btn"
  elements :user_field, "#users"
end
