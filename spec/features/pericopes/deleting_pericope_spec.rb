# frozen_string_literal: true

feature "Users can delete pericopes", js: true do
  let(:user) { create(:user) }
  let!(:jona) { create(:biblebook, name: "Jona") }
  let(:studynote) { create :studynote }
  let(:nsp) { NewStudynotesPage.new }

  # TODO: Fix
  scenario "a second pericope" do
    login_as(user)
    nsp.load

    nsp.pericopes[0].set("Jona 1:1 - 1:10")
    nsp.add_pericope_button.click
    nsp.pericopes[1].set("Jona 2:20 - 3:3")
    nsp.title_field.set(".")
    nsp.studynote_field.set(".")

    delete_pericope(1)

    nsp.submit_button.click

    expect(page).to have_content("Jona 1:1 - 1:10")
    expect(page).to_not have_content("Jona 1:1 - 1:10 | Jona 2:20 - 3:3")
  end

  scenario "but not the first/only one" do
    login_as(user)
    nsp.load
    nsp.title_field.set(".")
    nsp.studynote_field.set(".")
    nsp.pericopes[0].set("Jona 1:1 - 1:10")

    accept_confirm { nsp.remove_pericope_button[0].click }
    nsp.submit_button.click

    expect(page).to have_content("Jona 1:1 - 1:10")
  end
end

def delete_pericope(nth)
  nsp.all(:css, ".delete")[nth].click
end
