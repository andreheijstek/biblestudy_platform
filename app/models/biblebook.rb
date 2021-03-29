# frozen_string_literal: true

#
# == Schema Information
#
# Table name: biblebooks
#
#  id                    :integer          not null, primary key
#  abbreviation          :string
#  booksequence          :integer
#  name                  :string
#  testament             :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  bible_verse_id        :bigint
#  biblebook_category_id :bigint
#
# Indexes
#
#  index_biblebooks_on_biblebook_category_id  (biblebook_category_id)
#
# TODO: bible_verse_id en biblebook_category_id verwijderen
#
# Models one Biblebook
# Has utitlity methods to help validate biblebooks
class Biblebook < ActiveRecord::Base
  validates :name, presence: true

  has_many :chapters, dependent: :delete_all
  has_many :pericopes
  has_many :studynotes, through: :pericopes
  has_one :biblebook_category

  default_scope { order('booksequence ASC') }
  scope :find_by_full_name, lambda { |name| where(name: name) }
  scope :find_by_abbreviation,
        lambda { |abbreviation|
          where(Biblebook.arel_table[:abbreviation].matches(abbreviation))
        }
  scope :find_names_by_like,
        lambda { |name|
          where(Biblebook.arel_table[:name].matches("%#{name.slice(0, 5)}%"))
        }

  # Returns the number of chapters in this biblebook
  # #return [Integer]
  def nr_of_chapters
    Chapter.where(biblebook_id: id).count
  end

  alias size nr_of_chapters

  # A chapter is valid if it exists in the biblebook,
  # so it must be positive and less than the number of chapters
  # @param [Integer] chapter number
  # @return [Boolean]
  # :reek:FeatureEnvy - seen from a caller, this is the place
  # where the method belongs
  def chapter_valid?(chapter)
    chapter.positive? && chapter <= nr_of_chapters
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
      biblebook = find_names_by_like(name) unless exists?(biblebook)
    end

    biblebook.map(&:name).uniq
  end

  # Tells if this biblebook exists
  # @param biblebook [Biblebook]
  # @return [Boolean]
  def self.exists?(biblebook)
    !biblebook.empty?
  end

  # :reek:TooManyStatements - to be refactored
  # rubocop:disable Metrics/MethodLength
  def self.validate_name(given_name, errors)
    names = possible_book_names(given_name)
    name = ''
    nr_of_biblebooks = names.size

    if nr_of_biblebooks.zero?
      errors.add :biblebook_name, :unknown_biblebook
    elsif nr_of_biblebooks == 1
      name = names[0]
    elsif nr_of_biblebooks > 1
      errors.add :biblebook_name,
                 :ambiguous_abbreviation,
                 given_name: given_name,
                 biblebooks: names.to_sentence
    end
    [name, errors]
  end
  # rubocop:enable Metrics/MethodLength
end
