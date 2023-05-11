# frozen_string_literal: true

# TODO: Commented. Spec currently not working. It does not visit my
# website but www.example.com.
# Probably needs to be refactored using the page object model,
# but for the admin pages I don't want to invest that time right now.

# feature "Users can delete biblebooks" do
#   before { login_as(create(:user, :admin)) }
#
#   scenario "successfully" do
#     create(:biblebook, name: "Handelingen")
#     visit admin_biblebooks_path
#     click_link "Handelingen"
#
#     # click_link t(:delete_item, item: Biblebook.model_name.human)
#
#     accept_alert do
#       click_link t(:delete_item, item: Biblebook.model_name.human)
#     end
#
#     should_see t("errors.messages.biblebook_deleted")
#     expect(page.current_url).to eq admin_biblebooks_url
#     expect(page).to have_no_content "Handelingen"
#   end
# end
