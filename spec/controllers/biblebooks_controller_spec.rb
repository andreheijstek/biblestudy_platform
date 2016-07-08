require 'rails_helper'

describe BiblebooksController, type: :controller do
  it "handles a missing biblebook correctly" do
    get :show, id: "not-here"
    expect(response).to redirect_to(biblebooks_path)
    message = "The biblebook you were looking for could not be found."
    expect(flash[:alert]).to eq message
  end
end
