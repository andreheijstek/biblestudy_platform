require "rails_helper"

feature "Users can view an overview of all biblebooks" do
  before do
    login_as(create(:user, :admin))
  end

  scenario "sorted by the given order" do
    biblebook1 = create(:biblebook, name: "Bijbelboek1", booksequence: 1)
    biblebook2 = create(:biblebook, name: "Bijbelboek2", booksequence: 2)
    visit admin_biblebooks_path

    expect(page).to have_content "Bijbelboek1"
    expect(page).to have_content "Bijbelboek2"

    expect("Bijbelboek1").to appear_before("Bijbelboek2")
  end
end
