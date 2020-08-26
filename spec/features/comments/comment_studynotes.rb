# frozen_string_literal: true

describe 'Users can comment studynotes', js: true do
  let(:author) { create(:user) }
  let(:commenter) { create(:user) }
  let(:ssp) { ShowStudynotePage.new }

  before do
    create(:biblebook, name: 'Jona')
    login_as(author)
    note = create(:studynote, title: 'Jona', note: 'Jona is bijzonder.', author: author)
    login_as(commenter)

    ssp.load
    # save_and_open_page
  end

  it 'when logged in' do
    ssp.comment_field.set 'commentaar'
    ssp.comment_button.click

    expect(ssp.comment_field).to eq('commentaar')
  end

  # it 'except when logged out' do
  #
  # end
end
