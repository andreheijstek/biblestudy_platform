require "rails_helper"

RSpec.feature "Admins can create new verses within chapters" do

  let(:biblebook) { FactoryGirl.create(:biblebook) }
  let(:chapter)   { FactoryGirl.create(:chapter, biblebook: biblebook) }

  before do
    visit biblebook_chapter_path(biblebook, chapter)
  end

  scenario "with valid attributes" do
    click_link t(:new_verse)
    fill_in t('simple_form.labels.verse.verse_number'), with: '1'

    submit_form

    expect(page).to have_content t(:verse_created)
  end

  scenario "when providing invalid attributes" do
    click_link t(:new_verse)
    submit_form
    expect(page).to have_content t(:verse_not_created)
    expect(page).to have_content t('activerecord.models.messages.blank')
  end
end
