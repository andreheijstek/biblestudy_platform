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
  # @param [Integer] chapter number
  # @return [Boolean]
  def chapter_valid?(chapter)
    chapter <= nr_of_chapters
  end

  # Returns the name of a Biblebook if it can be found by any kind of name
  # @param [String]
  # - complete name, e.g. Genesis
  # - official abbreviation, e.g. gen
  # - fitting abbreviation, e.g. Gene

  # @return [Array]
  # - empty if not found
  # - one element if one found
  # - multiple elements if multiple found
  # :reek:DuplicateMethodCall - don't know how to solve that right now
  def self.possible_book_names(name)
    biblebook = find_by_full_name(name)
    unless exists?(biblebook)
      biblebook = find_by_abbreviation(name)
      unless exists?(biblebook)
        biblebook = find_names_by_like(name)
      end
    end

    biblebook.map(&:name).uniq
  end

  scope :find_by_full_name, -> (name) { where(name: name) }
  scope :find_by_abbreviation, -> (abbreviation) { where(Biblebook.arel_table[:abbreviation].matches(abbreviation)) }
  scope :find_names_by_like, -> (name) { where(Biblebook.arel_table[:name].matches("%#{name.slice(0, 5)}%")) }

  # Tells if a biblebook exists with this name
  # @param [String] biblebook name
  # @return [Boolean]
  def self.exists?(biblebook)
    !biblebook.empty?
  end
end
