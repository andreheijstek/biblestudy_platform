# frozen_string_literal: true

feature 'Users can edit existing biblebooks' do
  before do
    login_as(create(:user, :admin))
    create(:biblebook, name: 'Voorbeeld bijbelboek')
    visit admin_biblebooks_path

    click_link 'Voorbeeld bijbelboek'
    click_link t(:edit_item, item: Biblebook.model_name.human)
  end

  scenario 'with valid attributes' do
    fill_in t('simple_form.labels.biblebook.name'), with: 'Acts'

    submit_form

    should_see t(:item_updated, item: Biblebook.model_name.human)
    should_see 'Acts'
  end

  scenario 'when providing invalid attributes' do
    fill_in t('simple_form.labels.biblebook.name'), with: ''
    submit_form
    should_see t(:item_not_updated, item: Biblebook.model_name.human)
  end
end
