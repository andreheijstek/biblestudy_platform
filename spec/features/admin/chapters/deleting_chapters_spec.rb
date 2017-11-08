# frozen_string_literal: true

require 'rails_helper'

feature 'Users can delete chapters' do
  let(:biblebook) { create(:biblebook) }
  let(:chapter)   { create(:chapter, biblebook: biblebook) }

  before do
    login_as(create(:user, :admin))
    visit admin_biblebook_chapter_path(biblebook, chapter)
  end

  scenario 'successfully' do
    click_link t(:delete_item, item: Chapter.model_name.human)
    should_see t(:item_deleted, item: Chapter.model_name.human)
    expect(page.current_url).to eq admin_biblebook_url(biblebook)
  end
end
