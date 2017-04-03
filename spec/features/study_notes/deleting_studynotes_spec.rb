require "rails_helper"

feature "Users can delete studynotes" do
  let(:user)      { create(:user) }
  let(:otheruser) { create(:user) }

  let!(:b1)       { create(:biblebook, name: "Jona") }
  let!(:s1)       { create(:studynote, title: "Jona", note: "Jona is bijzonder.", author: user) }
  let!(:p1)       { create(:pericope_by_name, name: "Jona 1:1 - 1:10", biblebook_id: b1.id, studynote_id: s1.id) }

  scenario "successfully" do
    login_as(user)
    visit studynotes_path

    click_link "Jona"
    click_link t(:delete_studynote)

    should_see t('activerecord.messages.deleted', model: 'bijbelstudie')
    expect(page.current_url).to eq pericopes_url
    expect(page).to have_no_content "Jona"
  end

  scenario "unless they do not have permission" do
    login_as(otheruser)
    visit studynotes_path

    click_link "Jona"
    expect(page).not_to have_link t(:delete_studynote)
  end
end
