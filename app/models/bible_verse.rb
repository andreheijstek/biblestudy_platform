# == Schema Information
#
# Table name: bible_verses
#
#  id         :bigint           not null, primary key
#  chapter    :integer
#  verse      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class BibleVerse < ApplicationRecord
  belongs_to :biblebook

  # Spaceship to compare Verses
  def <=>(other)
    [chapter, verse] <=> [other.chapter, other.verse]
  end
end
