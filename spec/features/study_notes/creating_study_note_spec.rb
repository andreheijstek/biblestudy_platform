require "rails_helper"

RSpec.feature "Users can create new study-notes and associate them to pericopes" do

  scenario "to a single pericope with valid attributes" do
    ensure_on("/")
    click_link t(:new_study_note)
    fill_in t('simple_form.labels.pericope.starting_verse'), with: "Jona 1:1"
    fill_in t('simple_form.labels.pericope.ending_verse'), with: "Jona 1:10"
    fill_in t('simple_form.labels.study_note.note'), with: 'Jona is bijzonder.'

    submit_form

    expect(page).to have_content t(:study_note_created)
  end
  #
  # scenario "when providing invalid attributes" do
  #   click_link t(:new_study_note)
  #   submit_form
  #   expect(page).to have_content t(:study_note_not_created)
  #   expect(page).to have_content t('activerecord.models.messages.blank')
  #
  #   click_link t(:new_study_note)
  #   fill_in t(:starting_verse), with: "Jona 1:1"
  #   submit_form
  #   expect(page).to have_content t(:study_note_not_created)
  #   expect(page).to have_content t('activerecord.models.messages.blank')
  #
  #   click_link t(:new_study_note)
  #   fill_in t(:ending_verse), with: "Jona 1:1"
  #   submit_form
  #   expect(page).to have_content t(:study_note_not_created)
  #   expect(page).to have_content t('activerecord.models.messages.blank')
  #
  #   click_link t(:new_study_note)
  #   fill_in t(:starting_verse), with: "Jona 1:1"
  #   fill_in t(:ending_verse), with: "Jona 1:2"
  #   submit_form
  #   expect(page).to have_content t(:study_note_not_created)
  #   expect(page).to have_content t('activerecord.models.messages.blank')

    # TODO Starting verse must be < ending verse
  # end


  # scenario "to multiple pericopes" do
  # end
end
