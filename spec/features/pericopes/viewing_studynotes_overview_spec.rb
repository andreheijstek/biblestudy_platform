=begin
require "rails_helper"

RSpec.feature "Users can view an overview of all studynotes" do
  b1 = FactoryGirl.create(:biblebook, name: "Jona")
  s1 = StudyNote.create(title: "Jona", note: "Jona is bijzonder.")
  p1 = Pericope.create(name: 'Jona 1:1 - 1:10', biblebook_id: b1.id, study_note_id: s1.id)

  b2 = FactoryGirl.create(:biblebook, name: "Handelingen")
  s2 = StudyNote.create(title: "Handelingen", note: "Handelingen ook.")
  p2 = Pericope.create(name: 'Handelingen 1:1 - 1:10', biblebook_id: b2.id, study_note_id: s2.id)

  # let (:studynote1) { FactoryGirl.create(:study_note, title: "Jona", note: "Jona is bijzonder.", pericope: 'Jona 1:1 - 1:10') }
  # let (:studynote2) { FactoryGirl.create(:study_note, title: "Handelingen", note: "Handelingen ook.", pericope: 'Handelingen 1:1 - 1:10') }

  scenario "sorted by pericopes name" do
=begin

    visit study_notes_path
    click_link t(:new_study_note)


    fill_in t('simple_form.labels.pericopes.name'), with: "Jona 1:1 - 1:10"
    fill_in t('simple_form.labels.study_note.title'), with: "Jona"
    fill_in t('simple_form.labels.study_note.note'), with: "Jona is bijzonder."
    submit_form

    visit study_notes_path
    click_link t(:new_study_note)
    fill_in t('simple_form.labels.pericopes.name'), with: "Handelingen 1:1 - 1:10"
    fill_in t('simple_form.labels.study_note.title'), with: "Handelingen"
    fill_in t('simple_form.labels.study_note.note'), with: "Handelingen ook."
    submit_form


    binding.pry
    visit pericopes_path
    # visit study_notes_path
    save_and_open_page

    expect(page).to have_content "Jona"
    expect(page).to have_content "Handelingen"

    expect("Jona").to appear_before("Handelingen")
  end

end
=end
