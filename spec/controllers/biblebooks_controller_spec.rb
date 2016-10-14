require "rails_helper"

describe Admin::BiblebooksController, type: :controller do
  let(:user) { FactoryGirl.create(:user, :admin) }

  before do
    allow(controller).to receive(:authenticate_user!)
    allow(controller).to receive(:current_user).and_return(user)
  end

  it "handles a missing biblebook correctly" do
    get :show, id: "not-here"
    expect(response).to redirect_to(admin_biblebooks_path)
    message = t(:biblebook_not_found)
    expect(flash[:alert]).to eq message
  end
end
