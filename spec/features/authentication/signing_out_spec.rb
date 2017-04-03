require "rails_helper"

feature "Signed-in users can sign out" do
  let!(:user) { create(:user) }

  scenario do
    login_as(user)
    visit "/"

    click_link t(:sign_out)

    should_see t("devise.sessions.signed_out")
  end
end
