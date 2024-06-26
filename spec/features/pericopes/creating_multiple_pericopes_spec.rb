# frozen_string_literal: true
#
feature "Users can add multiple pericopes to a studynote", js: true do
  let(:user) { create(:user) }

  scenario "with valid attributes" do
    create(:biblebook, name: "Jona")
    login_as(user)

    nsp = NewStudynotesPage.new
    nsp.load
    nsp.title_field.set(".")
    nsp.studynote_field.set(".")
    nsp.add_pericope_button.click
    nsp.pericopes[0].set("Jona 1:1 - 1:10")
    nsp.add_pericope_button.click

    nsp.pericopes[1].set("Jona 2:20 - 3:3")
    nsp.submit_button.click

    expect(page).to have_content("Jona 1:1 - 1:10 | Jona 2:20 - 3:3")
  end
end
