# == Schema Information
#
# Table name: bible_verses
#
#  id           :integer          not null, primary key
#  biblebook_id :integer
#  chapter_nr   :integer
#  verse_nr     :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class BibleVerse < ApplicationRecord
  belongs_to :biblebook

  validates :chapter_nr, numericality: { greater_than: 0 }
  validate :less_than_number_of_chapters

  def less_than_number_of_chapters
    if chapter_nr > biblebook.nr_of_chapters
      errors.add(:chapter_nr,
                 "cannot be greater than the number of chapters in this book,
                 in this case: #{biblebook.nr_of_chapters}")
    end
  end
end
