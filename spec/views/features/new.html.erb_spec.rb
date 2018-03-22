require 'rails_helper'

RSpec.describe "features/new", type: :view do
  before(:each) do
    assign(:feature, Feature.new())
  end

  it "renders new feature form" do
    render

    assert_select "form[action=?][method=?]", features_path, "post" do
    end
  end
end
