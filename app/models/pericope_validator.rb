# Validates a Pericope
#
# Checks on the order of the components
# - starting chapter < ending_chapter
# - starting_verse < ending_verse
# - contains existing biblebook
# - chapters withing valid range of biblebook
# - verses within valid range of chapter
#
class PericopeValidator < ActiveModel::Validator

  def validate(record)
    @record = record
    @name = record.name
    if empty_record?
      @record.errors.add :name, I18n.t('name_not_empty')
      return
    end

    validate_name
  end

  private

  # Validates a pericope record
  # To do that, a record is composed from the name
  # Check if
  # - name is a valid pericpe_string
  # - the biblebook in the name exists
  # - the order of chapters/verses
  def validate_name
    @parsed_pericope = parse_pericope(@name)

    return unless find_biblebook
    update_record
    validate_sequence
  end

  def parse_pericope(name)
    begin
      @parsed_pericope = PericopeString.new(name)
    rescue
      @record.errors.add :name, I18n.t('invalid_pericope')
    end
  end

  # Checks if the sequence of chapters and verses is correct
  # and sets the error message
  # TODO
  # - single responsibility: so valid_sequence? checkt alleen of de sequence klopt en geeft true/false
  # - eronder methods voor valid_chapter_sequence? en valid_verse_sequence?
  # - valid_order beter dan sequence?
  def validate_sequence
    if @record.starting_chapter_nr > @record.ending_chapter_nr
      @record.errors.add :name, I18n.t('starting_greater_than_ending')
      return false
    end

    if (@record.starting_chapter_nr == @record.ending_chapter_nr) &&
        (@record.starting_verse > @record.ending_verse)
      @record.errors.add :name, I18n.t('starting_verse_chapter_mismatch')
      return false
    end
    true
  end

  # Checks if the record is completely empty or contains an empty name string
  def empty_record?
    @name.nil? || @name.empty?
  end

  def find_biblebook
    @biblebook_name = @parsed_pericope.biblebook_name
    @biblebook = find_by_full_name
    if @biblebook.nil?
      @biblebook = find_by_abbreviation
      @biblebook = find_by_like if @biblebook.nil?
    end
    @parsed_pericope.biblebook_name = @biblebook.name unless @biblebook.nil?
    @biblebook
  end

  def find_by_full_name
    @biblebook = Biblebook.find_by(name: @biblebook_name)
  end

  def find_by_abbreviation
    @biblebook = Biblebook.find_by(abbreviation: @biblebook_name)
  end

  def find_by_like
    biblebooks = Biblebook.where('name LIKE (?)',
                                 "%#{@biblebook_name.slice(0, 5)}%")
    if biblebooks.empty?
      @record.errors.add :name, I18n.t('unknown_biblebook')
      @biblebook = nil
    elsif biblebooks.length > 1
      @record.errors.add :name, ambiguous_string(@biblebook_name, biblebooks)
      @biblebook = nil
    else
      @biblebook = biblebooks[0]
    end
  end

  def ambiguous_string(book_name, biblebooks)
    book_list = []
    biblebooks.each do |book|
      book_list << book.name
    end
    "#{I18n.t('ambiguous_abbreviation')}: '#{book_name}' kan #{book_list.join(', ')} zijn"
  end

  def update_record
    # TODO Can't I use a tap here?
    @record.biblebook_id = @biblebook.id
    @record.biblebook_name = @biblebook.name
    @record.name = @name

    @record.starting_chapter_nr = @parsed_pericope.starting_chapter
    @record.starting_verse = @parsed_pericope.starting_verse
    @record.ending_chapter_nr = @parsed_pericope.ending_chapter
    @record.ending_verse = @parsed_pericope.ending_verse

    @record.sequence = @record.starting_chapter_nr * 1000 + @record.starting_verse
  end
end
