# frozen_string_literal: true

describe Admin::ApplicationController do
  let(:user) { create(:user) }

  before do
    allow(controller).to receive(:authenticate_user!)
    allow(controller).to receive(:current_user).and_return(user)
  end

  context "when non-admin users" do
    before { get :index, params: {} }

    it "access the index action they are redirected" do
      expect(response).to redirect_to "/"
    end

    it "access the index action they get an error message" do
      expect(flash[:alert]).to eq "You must be an admin to do that."
    end
  end
end
