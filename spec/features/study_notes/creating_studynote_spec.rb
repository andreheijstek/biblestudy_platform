require "rails_helper"

feature "Users can create new studynotes and associate them to pericopes" do
  let(:user) { create(:user) }

  before do
    create(:biblebook, name: "Jona")
    login_as(user)
    visit studynotes_path
    click_link t(:new_studynote)
  end

  scenario "to a single pericopes with valid attributes" do
    fill_in t('simple_form.labels.pericopes.name'), with: "Jona 1:1 - 1:10"
    fill_in t('simple_form.labels.studynote.title'), with: "Titel"
    fill_in t('simple_form.labels.studynote.note'), with: "Jona is bijzonder."

    submit_form

    expect(page).to have_content t(:studynote_created)
    within("#studynote") do
      expect(page).to have_content "#{t("author")}: #{user.email}"
    end
  end

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
=begin

  scenario "when providing an abbreviated biblebook" do
    create(:biblebook, name: "Genesis", abbreviation: "Gen")

    fill_in t('simple_form.labels.pericopes.name'), with: "Gen 1:1 - 1:10"
    fill_in t('simple_form.labels.studynote.title'), with: "Titel"
    fill_in t('simple_form.labels.studynote.note'), with: "Genesis in het kort"

    submit_form

    expect(page).to have_content t(:studynote_created)
    within("#studynote") do
      expect(page).to have_content "Gen 1:1 - 1:10"
    end

    visit pericopes_path
    expect(page).to have_content "Genesis in het kort"
  end
=end

  ## Ook Psalmen, Psalm, ps
  ## lowercase

  # scenario "to multiple pericopes" do
  # end
end
