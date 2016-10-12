require "rails_helper"

RSpec.feature "Users can create new studynotes and associate them to pericopes" do

  let(:user) { FactoryGirl.create(:user) }
  let!(:b1) { create(:biblebook, name: "Jona", booksequence: 34) }
  let!(:s1) { create(:studynote, title: "Jona", note: "Jona is bijzonder.") }
  # let!(:p1) { create(:pericope_by_name, name: "Jona 1:1 - 1:10", biblebook_id: b1.id, studynote_id: s1.id) }


  before do
    login_as(user)
    # assign_role!(user, :study_reader, s1)
    # create(:pericope_by_name, name: "Jona 1:1 - 1:10", biblebook_id: b1.id, studynote_id: s1.id, user: user)

    visit studynotes_path
    click_link t(:new_studynote)
  end

  scenario "to a single pericopes with valid attributes" do
    create(:biblebook, name: "Jona")
    fill_in t('simple_form.labels.pericopes.name'), with: "Jona 1:1 - 1:10"
    fill_in t('simple_form.labels.studynote.title'), with: "Titel"
    fill_in t('simple_form.labels.studynote.note'), with: "Jona is bijzonder."

    submit_form

    expect(page).to have_content t(:studynote_created)
    within("#studynote") do
      expect(page).to have_content "#{t("author")}: #{user.email}"
    end
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
