# frozen_string_literal: true

feature 'Users can delete studynotes', js: true do
  let(:user)      { create(:user) }
  let(:otheruser) { create(:user) }

  before do
    create(:studynote, title: 'Jona', author: user)
  end

  scenario 'successfully' do
    login_as(user)

    visit studynotes_path
    click_link 'Jona'

    # I would like to use the pageobject here,
    # but can't get the URL expansion to work
    # ssp = StudynoteShowPage.new
    # ssp.load(studynote: @s1)

    accept_confirm do
      click_link t(:delete_item, item: Studynote.model_name.human)
    end

    should_see t('activerecord.messages.deleted', model: 'bijbelstudie')
    expect(page).to have_current_path pericopes_path
    expect(page).to have_no_content 'Jona'
  end

  scenario 'unless they do not have permission' do
    login_as(otheruser)

    visit studynotes_path
    click_link 'Jona'

    ssp = ShowStudynotePage.new
    expect(ssp).not_to have_remove_button
  end
end
