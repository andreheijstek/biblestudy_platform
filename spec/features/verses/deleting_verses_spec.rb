require "rails_helper"
RSpec.feature "Users can delete chapters" do

  let(:biblebook) { FactoryGirl.create(:biblebook) }
  let(:chapter)   { FactoryGirl.create(:chapter, biblebook: biblebook) }
  let(:verse)     { FactoryGirl.create(:verse, chapter: chapter) }

  before do
    visit biblebook_chapter_verse_path(biblebook, chapter, verse)
  end

  scenario "successfully" do
    click_link t(:delete_verse)
    expect(page).to have_content t(:verse_deleted)
    expect(page.current_url).to eq biblebook_chapter_url(biblebook, chapter)
  end
end
