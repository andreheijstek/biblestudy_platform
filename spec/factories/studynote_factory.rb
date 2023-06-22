# frozen_string_literal: true

# == Schema Information
#
# Table name: studynotes
#
#  id         :integer          not null, primary key
#  note       :text
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  author_id  :integer
#
# Indexes
#
#  index_studynotes_on_author_id  (author_id)
#
# Foreign Keys
#
#  fk_rails_...  (author_id => users.id)
#

FactoryBot.define do
  factory :studynote do
    title { "titel" }
    note { "text" }
    tag_list { "tag" }
    trait :pericope do
      FactoryBot.create :pericope
    end
  end
end
