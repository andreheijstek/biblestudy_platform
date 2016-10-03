require "rails_helper"

RSpec.feature "Users can view biblebooks" do
  before do
    login_as(FactoryGirl.create(:user, :admin))
  end

  scenario "with the biblebook details" do
    biblebook = create(:biblebook, name: "Bijbelboek")
    visit admin_biblebooks_path

    click_link "Bijbelboek"

    expect(page.current_url).to eq admin_biblebook_url(biblebook)
  end
end
