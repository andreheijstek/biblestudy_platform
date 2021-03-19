# frozen_string_literal: true

# == Schema Information
#
# Table name: biblebooks
#
#  id             :integer          not null, primary key
#  name           :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  booksequence   :integer
#  testament      :string
#  abbreviation   :string
#  bible_verse_id :integer
#

describe Admin::BiblebooksController do
  let(:user) { create(:user, :admin) }

  before do
    allow(controller).to receive(:authenticate_user!)
    allow(controller).to receive(:current_user).and_return(user)
  end

  it 'redirects on a missing biblebook' do
    get :show, params: { id: 'not-here' }
    expect(response).to redirect_to(admin_biblebooks_path)
  end

  it 'presents an error message on a missing biblebook' do
    get :show, params: { id: 'not-here' }
    message = t('errors.messages.biblebook_not_found')
    expect(flash[:alert]).to eq message
  end
end
