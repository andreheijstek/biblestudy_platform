# frozen_string_literal: true

feature "Signed-in users can sign out" do
  let!(:user) { create(:user) }

  scenario do
    login_as(user)
    visit "/"
    page.find("button.navbar-toggler").click

    click_link t(:sign_out)

    expect(page).to have_content (t("devise.sessions.signed_out"))
  end
end
