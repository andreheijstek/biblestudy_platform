# frozen_string_literal: true

describe 'Users can comment studynotes', js: true do
  let(:author) { create(:user) }
  let(:commenter) { create(:user) }
  let(:ssp) { ShowStudynotePage.new }
  let(:ncp) { NewCommentPage.new }

  before do
    create(:biblebook, name: 'Jona')
    login_as(author)
    note =
      create(
        :studynote,
        title: 'Jona',
        note: 'Jona is bijzonder.',
        author: author
      )

    login_as(commenter)
    ssp.load
    click_link 'Jona'
  end

  it 'when logged in' do
    ssp.add_comment_button.click
    ncp.load
    save_and_open_page
    ncp.comment_field[0].set 'commentaar hupsefluts'
    ncp.comment_button.click

    # expect(ssp.comment_field[0]).to eq('commentaar hupsefluts')

    ssp.load
    click_link 'Jona'
    save_and_open_page
    should_see 'commentaar hupsefluts'
    # expect(ssp).to have_comments(count: 1)
  end

  # it 'except when logged out' do
  #
  # end
  #
  # Add failing cases for missing attributes
  # Later: comments on comments
  #
  # Auteur/datum bij de comment tonen
  # Lijst van alle commentaar bij de studynote zelf
end
