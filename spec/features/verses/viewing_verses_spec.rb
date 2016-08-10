require "rails_helper"

RSpec.feature "Users can view verses" do

  before do
    book    = FactoryGirl.create(:biblebook, name: "testboek")
    chapter = FactoryGirl.create(:chapter, biblebook: book, chapter_number: '1')
    verse   = FactoryGirl.create(:verse, chapter: chapter, verse_number: '1', verse_text: "test vers")
    ensure_on('/')
  end

  scenario "for a given chapter" do
    click_link "testboek"
    expect(page).to have_content "testboek"
    click_link "1"
    within("#verses") do
      expect(page).to have_content "test vers"
    end
  end
end
