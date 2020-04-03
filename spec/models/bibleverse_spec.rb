# frozen_string_literal: true

# == Schema Information
#
# Table name: bibleverses
#
#  id         :bigint           not null, primary key
#  chapter    :integer
#  verse      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
RSpec.describe Bibleverse, type: :model do
  let(:starting) { build(:bibleverse, chapter: 1, verse: 1) }
  let(:ending) { build(:bibleverse, chapter: 2, verse: 2) }

  it 'compares verses' do
    expect(ending > starting).to be(true)
  end
end
