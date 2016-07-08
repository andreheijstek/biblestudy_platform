require "rails_helper"

feature "Users can delete biblebooks" do
  scenario "successfully" do
    FactoryGirl.create(:biblebook, name: "Handelingen")
    visit "/"
    click_link "Handelingen"

    click_link "Delete Biblebook"

    expect(page).to have_content "Biblebook has been deleted."
    expect(page.current_url).to eq biblebooks_url
    expect(page).to have_no_content "Handelingen"
  end
end
