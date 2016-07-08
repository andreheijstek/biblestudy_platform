require "rails_helper"

feature "Users can edit existing biblebooks" do
  before do
    FactoryGirl.create(:biblebook, name: "Voorbeeld bijbelboek")
    visit "/"

    click_link "Voorbeeld bijbelboek"
    click_link "Edit Biblebook"
  end

  scenario "with valid attributes" do
    fill_in "Name", with: "Acts"
    click_button "Update Biblebook"

    expect(page).to have_content "Biblebook has been updated."
    expect(page).to have_content "Acts"
  end

  scenario "when providing invalid attributes" do
    fill_in "Name", with: ""
    click_button "Update Biblebook"
    expect(page).to have_content "Biblebook has not been updated."
  end
end
