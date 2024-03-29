# frozen_string_literal: true

feature "Admins can change a user's details" do
  let(:admin_user) { create(:user, :admin) }
  let(:user) { create(:user) }

  before do
    login_as(admin_user)
    visit admin_user_path(user)
    click_link "Edit User"
  end

  scenario "with valid details" do
    email = "newguy@example.com"
    fill_in t("activerecord.attributes.user.email"), with: email
    fill_in t("activerecord.attributes.user.password"), with: "123456"
    submit_form

    expect(page).to have_content(
      t("activerecord.attributes.user.messages.updated")
    )
    expect(page).to have_content(email)
    expect(page).to_not have_content(user.email)
  end

  scenario "when toggling a user's admin ability" do
    check t("activerecord.attributes.user.is_admin")
    fill_in t("activerecord.attributes.user.password"), with: "123456"

    submit_form

    expect(page).to have_content(
      t("activerecord.attributes.user.messages.updated")
    )
    expect(page).to have_content("#{user.email} (Admin)")
  end
end
