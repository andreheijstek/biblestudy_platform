# frozen_string_literal: true

#
# == Schema Information
#
# Table name: biblebooks
#
#  id           :integer          not null, primary key
#  name         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  booksequence :integer
#  testament    :string
#  abbreviation :string
#

# Models one Biblebook
# Has some utitlity methods to help validate biblebooks
class Biblebook < ActiveRecord::Base
  validates :name, presence: true

  has_many :chapters, dependent: :delete_all
  has_many :pericopes
  has_many :studynotes, through: :pericopes

  default_scope { order('booksequence ASC') }

  def nr_of_chapters
    Chapter.where(biblebook_id: id).count
  end

  alias size nr_of_chapters

  # A chapter is valid if it exists in the biblebook,
  # so it must be positive and less than the number of chapters
  def chapter_valid?(chapter)
    chapter <= nr_of_chapters
  end

  # Returns the name of a Biblebook if it can be found by any kind of name
  # - complete name, e.g. Genesis
  # - official abbreviation, e.g. gen
  # - fitting abbreviation, e.g. Gene

  # The method always returns an Array
  # - empty if not found
  # - one element if one found
  # - multiple elements if multiple found
  # :reek:DuplicateMethodCall - don't know how to solve that right now
  def self.possible_book_names(name)
    biblebook = find_by_full_name(name)
    if empty_biblebook?(biblebook)
      biblebook = find_by_abbreviation(name)
      if empty_biblebook?(biblebook)
        biblebook = find_names_by_like(name)
      end
    end

    biblebook.map(&:name).uniq
  end

  scope :find_by_full_name, -> (name) { where(name: name) }
  scope :find_by_abbreviation, -> (abbreviation) { where(abbreviation: abbreviation) }
  scope :find_names_by_like, -> (name) { where(Biblebook.arel_table[:name].matches("%#{name.slice(0, 5)}%")) }

  def self.empty_biblebook?(biblebook)
    biblebook.empty?
  end
end
