require "rails_helper"

feature "Admins can change a user's details" do
  let(:admin_user) { FactoryGirl.create(:user, :admin) }
  let(:user) { FactoryGirl.create(:user) }

  before do
    login_as(admin_user)
    visit admin_user_path(user)
    click_link "Edit User"
  end

  scenario "with valid details" do
    fill_in t("activerecord.attributes.user.email"), with: "newguy@example.com"

    submit_form

    expect(page).to have_content t("activerecord.attributes.user.messages.updated")
    expect(page).to have_content "newguy@example.com"
    expect(page).to_not have_content user.email
  end

  scenario "when toggling a user's admin ability" do
    check t("activerecord.attributes.user.is_admin")

    submit_form

    expect(page).to have_content t("activerecord.attributes.user.messages.updated")
    expect(page).to have_content "#{user.email} (Admin)"
  end
end
