# frozen_string_literal: true

# Page object for the admin page
class AdminBiblebooksNewPage < SitePrism::Page
  set_url "/admin/biblebooks/new"
  element :name_field, "#biblebook_name"
  element :order_field, "#biblebook_booksequence"
  element :testament_field, "#biblebook_testament"
  element :submit_button, "#submit_biblebook"
end
