# == Schema Information
#
# Table name: pericopes
#
#  id                  :integer          not null, primary key
#  studynote_id        :integer
#  starting_verse      :integer
#  ending_verse        :integer
#  biblebook_id        :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  name                :string
#  ending_chapter_nr   :integer
#  starting_chapter_nr :integer
#  biblebook_name      :string
#  sequence            :integer
#

# The caller should create the correct biblebook before calling Pericope_xxx_Factory

FactoryGirl.define do
  factory :pericope, class: Pericope do
    name 'Jona 1:1 - 1:10'
    trait :jona do
      biblebook do
        Biblebook.find_by(name: 'Jona') || FactoryGirl.create(:biblebook, name: 'Jona')
      end
    end
  end
end
