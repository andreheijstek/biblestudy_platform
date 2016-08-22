require "rails_helper"

RSpec.feature "Users can sign up" do
  scenario "when providing valid details" do
    ensure_on "/"

    click_link t(:sign_up)
    fill_in t('activerecord.attributes.user.email'), with: "test@example.com"
    fill_in "user_password", with: "password"
    fill_in t('activerecord.attributes.user.password_confirmation'), with: "password"
    click_button t(:sign_up)

    expect(page).to have_content(t('devise.registrations.signed_up'))
  end
end
