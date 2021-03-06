# frozen_string_literal: true

feature "Users can edit existing studynotes", js: true do
  let(:user) { create(:user) }
  let(:otheruser) { create(:user) }
  let(:nsp) { NewStudynotesPage.new }

  before do
    create(:studynote, title: "Jona", note: "Jona is bijzonder.", author: user)
    login_as(user)

    visit studynotes_path
    click_link "Jona"
    click_link t(:edit_item, item: Studynote.model_name.human)
  end

  scenario "with valid attributes" do
    new_text = "Jona is heel bijzonder."
    nsp.studynote_field.set(new_text)
    nsp.submit_button.click

    should_see t(:item_updated, item: Studynote.model_name.human)
    should_see new_text
  end

  scenario "except when providing invalid attributes" do
    nsp.studynote_field.native.clear # enter an empty string into the field
    nsp.submit_button.click

    should_see t(:item_not_updated, item: Studynote.model_name.human)
  end

  scenario "unless they do not have permission" do
    login_as(otheruser)
    ssp = ShowStudynotePage.new

    expect(ssp).not_to have_remove_button
  end
end
