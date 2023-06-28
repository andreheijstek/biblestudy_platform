# frozen_string_literal: true

feature "Users can view biblebooks" do
  before { login_as(create(:user, :admin)) }

  scenario "with the biblebook details" do
    name = "Bijbelboek"
    biblebook = create(:biblebook, name: name)

    visit admin_biblebooks_path

    expect(page).to have_content name
  end
end
