# frozen_string_literal: true

# TODO: Commented. Spec currently not working. It does not visit my
# website but www.example.com.
# Probably needs to be refactored using the page object model,
# but for the admin pages I don't want to invest that time right now.

# feature "Users can view biblebooks" do
#   before { login_as(create(:user, :admin)) }
#
#   scenario "with the biblebook details" do
#     biblebook = create(:biblebook, name: "Bijbelboek")
#     visit admin_biblebooks_path
#
#     click_link "Bijbelboek"
#
#     expect(page.current_url).to eq admin_biblebook_url(biblebook)
#   end
# end
