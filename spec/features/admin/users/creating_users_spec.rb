# frozen_string_literal: true

feature "Admins can create new users" do
  let(:admin) { create(:user, :admin) }

  before do
    login_as(admin)
    visit "/"
    click_link "Admin"
    click_link "New User"
  end

  scenario "with valid credentials" do
    fill_in t("activerecord.attributes.user.username"), with: "gebruikert"
    fill_in t("activerecord.attributes.user.email"), with: "newbie@example.com"
    fill_in t("activerecord.attributes.user.password"), with: "password"

    submit_form

    expect(page).to have_content(t("activerecord.messages.created"))
  end

  scenario "when the new user is an admin" do
    fill_in t("activerecord.attributes.user.username"), with: "gebruikert"
    fill_in t("activerecord.attributes.user.email"), with: "admin@example.com"
    fill_in t("activerecord.attributes.user.password"), with: "password"
    check t("activerecord.attributes.user.is_admin")

    submit_form

    expect(page).to have_content(t("activerecord.messages.created"))
    expect(page).to have_content("admin@example.com (Admin)")
  end
end
