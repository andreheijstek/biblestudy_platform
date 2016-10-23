require "rails_helper"

feature "Users can view their data" do
  let!(:user) { create(:user) }

  before do
    login_as(user)
    visit root_path
  end

  scenario "with valid credentials" do
    click_link t(:user_profile)

    fill_in t("activerecord.attributes.user.email"), with: user.email
    fill_in t("activerecord.attributes.user.password"), with: "password"
    click_button t(:sign_in)

    expect(page).to have_content t("activerecord.attributes.user.username")
    expect(page).to have_content t("activerecord.attributes.user.email")
    expect(page).to have_content t("activerecord.attributes.user.password")
  end
end
