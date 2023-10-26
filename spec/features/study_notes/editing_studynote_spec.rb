# frozen_string_literal: true

# TODO: Edit more than just the title?
feature "Users can edit existing studynotes", js: true do
  let(:user) { create(:user) }
  let(:otheruser) { create(:user) }
  let(:nsp) { NewStudynotesPage.new }

  before do
    create(:studynote, title: "Jona", note: "Jona is bijzonder.", author: user)
    login_as(user)

    visit studynotes_path
    click_link "Jona"
    click_link "edit_studynote"
  end

  scenario "with valid attributes" do
    new_text = "Jona is heel bijzonder."
    nsp.studynote_field.set(new_text)
    nsp.submit_button.click

    expect(page).to have_content (
                   t(:item_updated, item: Studynote.model_name.human)
                 )
    expect(page).to have_content (new_text)
  end

  scenario "except when providing invalid attributes" do
    nsp.studynote_field.native.clear # enter an empty string into the field
    nsp.submit_button.click

    expect(page).to have_content (
                   t(:item_not_updated, item: Studynote.model_name.human)
                 )
  end

  scenario "unless they do not have permission" do
    login_as(otheruser)
    ssp = ShowStudynotePage.new

    expect(ssp).not_to have_remove_button
  end
end
