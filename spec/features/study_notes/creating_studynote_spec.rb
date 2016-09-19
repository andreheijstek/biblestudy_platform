require "rails_helper"

RSpec.feature "Users can create new studynotes and associate them to pericopes" do

  before do
    visit studynotes_path
    click_link t(:new_studynote)
  end

  scenario "to a single pericopes with valid attributes" do
    FactoryGirl.create(:biblebook, name: "Jona")
    fill_in t('simple_form.labels.pericopes.name'), with: "Jona 1:1 - 1:10"
    fill_in t('simple_form.labels.studynote.title'), with: "Titel"
    fill_in t('simple_form.labels.studynote.note'), with: "Jona is bijzonder."

    submit_form

    expect(page).to have_content t(:studynote_created)
  end

=begin
  scenario "when providing no attributes" do
    submit_form
    expect(page).to have_content t(:studynote_not_created)
    expect(page).to have_content t('activerecord.models.messages.blank')
  end

  scenario "when providing just the title" do
    fill_in t('simple_form.labels.studynote.title'), with: "Titel"
    submit_form
    expect(page).to have_content t(:studynote_not_created)
    expect(page).to have_content t('activerecord.models.messages.blank')
  end
=end

  # scenario "to multiple pericopes" do
  # end
end
