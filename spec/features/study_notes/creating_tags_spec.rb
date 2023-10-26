# frozen_string_literal: true

feature "Users can add tags to studynotes", js: true do
  let(:user) { create(:user) }

  before do
    create(:biblebook, name: "Jona")
    login_as(user)
  end

  scenario "single tag" do
    NewStudynotesPage.new.tap do |n|
      n.load
      n.pericopes[0].set("Jona 1:1 - 1:10")
      n.add_pericope_button.click
      n.title_field.set("Titel")
      n.pericopes[1].set("Jona 2:20 - 3:3")
      n.studynote_field.set("Jona is bijzonder.")

      n.st_tag_field.set("tag")
      n.submit_button.click
    end

    expect(page).to have_content("tag")
  end
end
