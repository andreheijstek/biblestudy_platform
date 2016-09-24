require 'rails_helper'
RSpec.feature 'Users can delete chapters' do

  let(:biblebook) { create(:biblebook) }
  let(:chapter)   { create(:chapter, biblebook: biblebook) }

  before do
    visit biblebook_chapter_path(biblebook, chapter)
  end

  scenario 'successfully' do
    click_link t(:delete_chapter)
    expect(page).to have_content t(:chapter_deleted)
    expect(page.current_url).to eq biblebook_url(biblebook)
  end
end
