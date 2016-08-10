require "rails_helper"

RSpec.feature "Users can edit existing verses" do

  let(:biblebook) { FactoryGirl.create(:biblebook) }
  let(:chapter)   { FactoryGirl.create(:chapter, biblebook: biblebook) }
  let(:verse)     { FactoryGirl.create(:verse, chapter: chapter) }

  before do
    visit biblebook_chapter_verse_path(biblebook, chapter, verse)
    click_link t(:edit_verse)
  end

  scenario "with valid attributes" do
    # fill_in t(:simple_form.labels.verse.verse_number), with: "1"
    fill_in "vers nummer", with: "1"
    # fill_in t(:simple_form.labels.verse.verse_text), with: "Een stukje bijbeltekst"
    fill_in "bijbeltekst", with: "Een stukje bijbeltekst"

    submit_form

    expect(page).to have_content t(:verse_updated)
    within("#verse") do
      expect(page).to have_content "1"
      expect(page).not_to have_content verse.verse_text
    end
  end
end
