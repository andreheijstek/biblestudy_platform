require "rails_helper"

RSpec.feature "Users can sign in" do

  let!(:user) { FactoryGirl.create(:user) }

  scenario "with valid credentials" do
    ensure_on "/"
    click_link t(:sign_in)

    fill_in t('activerecord.attributes.user.email'), with: user.email
    fill_in t('activerecord.attributes.user.password'), with: "password"
    click_button t(:sign_in)

    expect(page).to have_content t('devise.sessions.signed_in')
    expect(page).to have_content "Signed in as #{user.email}"

    # expect(page).to have_content "#{t(:devise.sessions.signed_in)} als #{user.email}"
  end
end
