# == Schema Information
#
# Table name: studynotes
#
#  id         :integer          not null, primary key
#  note       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  title      :string
#  author_id  :integer
#

FactoryGirl.define do
  factory :studynote do
    title "titel"
    note "text"
  end
end
