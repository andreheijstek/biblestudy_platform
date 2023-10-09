# frozen_string_literal: true

# == Schema Information
#
# Table name: bible_verses
#
#  id         :bigint           not null, primary key
#  chapter_nr :integer
#  verse_nr   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class BibleVerse < ApplicationRecord
  include Comparable
  belongs_to :biblebook

  # Spaceship to compare Verses
  def <=>(other)
    [chapter_nr, verse_nr] <=> [other.chapter_nr, other.verse_nr]
  end
end
