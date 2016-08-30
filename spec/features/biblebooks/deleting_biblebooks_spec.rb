require "rails_helper"

RSpec.feature "Users can delete biblebooks" do
  scenario "successfully" do
    FactoryGirl.create(:biblebook, name: "Handelingen")
    visit biblebooks_path
    click_link "Handelingen"

    click_link t(:delete_biblebook)

    expect(page).to have_content t(:biblebook_deleted)
    expect(page.current_url).to eq biblebooks_url
    expect(page).to have_no_content "Handelingen"
  end
end
