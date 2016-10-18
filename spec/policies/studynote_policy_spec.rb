require 'rails_helper'

describe StudynotePolicy do

  context "permissions" do
    subject { StudynotePolicy.new(user, studynote) }

    context "for a visitor" do
      let(:user)      { nil }
      let(:author)    { FactoryGirl.create(:user) }
      let(:studynote) { FactoryGirl.create(:studynote, author: author) }

      it { should     permit_action(:show)    }
      it { should_not permit_action(:create)  }
      it { should_not permit_action(:new)     }
      it { should_not permit_action(:update)  }
      it { should_not permit_action(:edit)    }
      it { should_not permit_action(:destroy) }
    end

    context "for an author" do
      let(:user)      { FactoryGirl.create(:user) }
      let(:studynote) { FactoryGirl.create(:studynote, author: user) }

      it { should permit_action(:show)    }
      it { should permit_action(:create)  }
      it { should permit_action(:new)     }
      it { should permit_action(:update)  }
      it { should permit_action(:edit)    }
      it { should permit_action(:destroy) }
    end

    context "for a user" do
      let(:user)      { FactoryGirl.create(:user) }
      let(:author)    { FactoryGirl.create(:user) }
      let(:studynote) { FactoryGirl.create(:studynote, author: author) }

      it { should     permit_action(:show)    }
      it { should     permit_action(:create)  }
      it { should     permit_action(:new)     }
      it { should_not permit_action(:update)  }
      it { should_not permit_action(:edit)    }
      it { should_not permit_action(:destroy) }
    end
  end
end
