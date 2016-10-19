=begin
require "rails_helper"

feature "Users can view their data" do
  let!(:user) { create(:user) }

  before do
    login_as(user)
  end

  scenario "with valid credentials" do
    ensure_on "/"
    click_link t(:sign_in)

    fill_in t("activerecord.attributes.user.email"), with: user.email
    fill_in t("activerecord.attributes.user.password"), with: "password"
    click_button t(:sign_in)

    expect(page).to have_content t("devise.sessions.signed_in")
    expect(page).to have_content "#{t('signed_in_as')} #{user.email}"
  end
end
=end
