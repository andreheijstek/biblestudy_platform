require "rails_helper"

RSpec.feature "Admins can add the number of verses to a chapter" do

  before do
    booktitle = "Handelingen"
    book = FactoryGirl.create(:biblebook, name: booktitle)
    chapter = FactoryGirl.create(:chapter, biblebook: book, chapter_number: '1')
    ensure_on ("/")
    visit biblebook_chapter_path(book, chapter)
  end

  scenario "with valid attributes" do
    click_link t(:edit_chapter)
    fill_in t('simple_form.labels.chapter.nrofverses'), with: '31'

    submit_form

    expect(page).to have_content t(:chapter_updated)
  end

end
