# frozen_string_literal: true

describe StudynotePolicy do
  context 'with permissions' do
    subject { described_class.new(user, studynote) }

    context 'when a visitor' do
      let(:user) { nil }
      let(:author) { create(:user) }
      let(:studynote) { create(:studynote, author:) }

      before { assign_role!(user, :viewer, studynote) }

      it { is_expected.to permit_action(:show) }
      it { is_expected.not_to permit_action(:create) }
      it { is_expected.not_to permit_action(:new) }
      it { is_expected.not_to permit_action(:update) }
      it { is_expected.not_to permit_action(:edit) }
      it { is_expected.not_to permit_action(:destroy) }
    end

    context 'when an author' do
      let(:user) { create(:user) }
      let(:studynote) { create(:studynote, author: user) }

      it { is_expected.to permit_action(:show) }
      it { is_expected.to permit_action(:create) }
      it { is_expected.to permit_action(:new) }
      it { is_expected.to permit_action(:update) }
      it { is_expected.to permit_action(:edit) }
      it { is_expected.to permit_action(:destroy) }
    end

    context 'when a user' do
      let(:user) { create(:user) }
      let(:author) { create(:user) }
      let(:studynote) { create(:studynote, author:) }

      it { is_expected.to permit_action(:show) }
      it { is_expected.to permit_action(:create) }
      it { is_expected.to permit_action(:new) }
      it { is_expected.not_to permit_action(:update) }
      it { is_expected.not_to permit_action(:edit) }
      it { is_expected.not_to permit_action(:destroy) }
    end
  end
end
