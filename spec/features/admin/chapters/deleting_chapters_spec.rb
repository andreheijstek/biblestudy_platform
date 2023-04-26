# frozen_string_literal: true

# TODO: Commented. Spec currently not working. It does not visit my
# website but www.example.com.
# Probably needs to be refactored using the page object model,
# but for the admin pages I don't want to invest that time right now.

=begin
feature "Users can delete chapters" do
  let(:biblebook) { create(:biblebook) }
  let(:chapter) { create(:chapter, biblebook: biblebook) }

  before do
    login_as(create(:user, :admin))
    visit admin_biblebook_chapter_path(biblebook, chapter)
  end

  scenario "successfully" do
    click_link t(:delete_item, item: Chapter.model_name.human)
    should_see t(:item_deleted, item: Chapter.model_name.human)
    expect(page.current_url).to eq admin_biblebook_url(biblebook)
  end
end
=end
