require 'rails_helper'

RSpec.feature 'Users can view biblebooks' do
  scenario 'with the biblebook details' do
    biblebook = FactoryGirl.create(:biblebook, name: 'Bijbelboek')
    visit biblebooks_path

    click_link 'Bijbelboek'

    expect(page.current_url).to eq biblebook_url(biblebook)
  end
end
