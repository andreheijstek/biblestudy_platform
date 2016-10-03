require "rails_helper"

RSpec.feature "Users can delete biblebooks" do
  before do
    login_as(FactoryGirl.create(:user, :admin))
  end

  scenario "successfully" do
    create(:biblebook, name: "Handelingen")
    visit admin_biblebooks_path
    click_link "Handelingen"

    click_link t(:delete_biblebook)

    expect(page).to have_content t(:biblebook_deleted)
    expect(page.current_url).to eq admin_biblebooks_url
    expect(page).to have_no_content "Handelingen"
  end
end
