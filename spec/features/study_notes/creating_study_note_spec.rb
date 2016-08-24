require "rails_helper"

RSpec.feature "Users can create new study-notes and associate them to pericopes" do

  scenario "with valid attributes" do
    ensure_on("/")
    click_link t(:new_study_note)
    fill_in t(:starting_verse), with: "Jona 1:1"
    fill_in t(:ending_verse), with: "Jona 1:10"
    fill_in t(:study_note), with: 'Jona is bijzonder.'

    submit_form

    expect(page).to have_content t(:study_note_created)
  end

  scenario "when providing invalid attributes" do
    click_link t(:new_verse)
    submit_form
    expect(page).to have_content t(:verse_not_created)
    expect(page).to have_content t('activerecord.models.messages.blank')
  end
end
