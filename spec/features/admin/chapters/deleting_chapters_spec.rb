require "rails_helper"

feature "Users can delete chapters" do
  let(:biblebook) { create(:biblebook) }
  let(:chapter)   { create(:chapter, biblebook: biblebook) }

  before do
    login_as(create(:user, :admin))
    visit admin_biblebook_chapter_path(biblebook, chapter)
  end

  scenario "successfully" do
    click_link t(:delete_chapter)
    should_see t(:chapter_deleted)
    expect(page.current_url).to eq admin_biblebook_url(biblebook)
  end
end
