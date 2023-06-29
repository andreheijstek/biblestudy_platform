# frozen_string_literal: true

feature "Users can create new studynotes with pericopes", js: true do
  let(:user) { create(:user) }

  before do
    create(:biblebook, name: "Jona", testament: "oud")
    login_as(user)
  end

  scenario "to multiple pericopes with valid attributes" do
    NewStudynotesPage.new.tap do |n|
      n.load
      n.pericopes[0].set "Jona 1:1 - 1:10"
      n.add_pericope_button.click
      n.title_field.set "Titel"
      n.pericopes[1].set "Jona 2:20 - 3:3"
      n.studynote_field.set "Jona is bijzonder."
      n.st_tag_field.set "mijn_tag"
      n.submit_button.click
    end

    expect(page).to have_content "mijn_tag"

    visit root_path
    should_see "Jona 1:1 - 1:10"
    should_see "Jona 2:20 - 3:3"
  end
end
