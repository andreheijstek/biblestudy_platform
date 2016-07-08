require "rails_helper"

feature "Admins can create new bible sections" do
  scenario "for single bible books" do
    visit "/"
    click_link "New biblebook"
    fill_in "Name", with: "Handelingen"
    fill_in "Description", with: "De handelingen der apostelen"
    click_button "Create Biblebook"
    expect(page).to have_content "Biblebook has been created."
  end
end
