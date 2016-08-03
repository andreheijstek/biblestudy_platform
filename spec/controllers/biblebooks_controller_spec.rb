require 'rails_helper'

describe BiblebooksController, type: :controller do
  it "handles a missing biblebook correctly" do
    get :show, id: "not-here"
    expect(response).to redirect_to(biblebooks_path)
    message = t(:biblebook_not_found)
    expect(flash[:alert]).to eq message
  end
end
