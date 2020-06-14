# frozen_string_literal: true

RSpec.describe Chapter, type: :model do
  let(:early) { build(:chapter, chapter_number: 1) }
  let(:late) { build(:chapter, chapter_number: 2) }

  it 'compares different chapters' do
    expect(late > early).to be(true)
  end
end
