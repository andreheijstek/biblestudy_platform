require "rails_helper"

feature "Users can edit existing studynotes" do
  let(:user)      { create(:user) }
  let(:otheruser) { create(:user) }


  before do
    b1 = create(:biblebook, name: "Jona")
    s1 = create(:studynote, title: "Jona", note: "Jona is bijzonder.", author: user)
    create(:pericope_by_name, name: "Jona 1:1 - 1:10", biblebook_id: b1.id, studynote_id: s1.id)

    login_as(user)

    visit studynotes_path
    click_link "Jona"
    click_link t(:edit_studynote)
  end

  scenario "with valid attributes" do
    fill_in t("simple_form.labels.studynote.note"), with: "Jona is heel bijzonder."

    submit_form

    should_see t(:studynote_updated)
    should_see "Jona is heel bijzonder."
  end

  scenario "when providing invalid attributes" do
    fill_in t("simple_form.labels.studynote.note"), with: ""
    submit_form
    should_see t(:studynote_not_updated)
  end

  scenario "unless they do not have permission" do
    login_as(otheruser)
    visit studynotes_path

    click_link "Jona"
    expect(page).not_to have_link t(:delete_studynote)
  end
end
