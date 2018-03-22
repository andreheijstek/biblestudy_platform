require 'rails_helper'

RSpec.describe "features/index", type: :view do
  before(:each) do
    assign(:features, [
      Feature.create!(),
      Feature.create!()
    ])
  end

  it "renders a list of features" do
    render
  end
end
