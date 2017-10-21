# Validates a Pericope
#
# Checks on the order of the components
# - starting chapter < ending_chapter
# - starting_verse < ending_verse
# - contains existing biblebook
# - chapters withing valid range of biblebook
# - verses within valid range of chapter
# And it writes a correctly formatted string for biblebook into the Pericope record
#
class PericopeValidator < ActiveModel::Validator

  def validate(record)
    @record = record
    return if empty_record?

    pericope
    return if @pericope_to_publish.nil?

    find_biblebook
    return if @biblebook.nil?

    update_record
    return if incorrect_sequence?

    # TODO: dit hoort hier niet, single responsibility principle
    # kan evt. naar een after_validation hook?
    @record.name = reformat_name
  end

  private

  # Turns a String into a PericopeString, so the scan method can be used
  def pericope
    begin
      @pericope_to_publish = PericopeString.new(@record.name)
    rescue
      @record.errors[:name] << I18n.t('invalid_pericope')
    end
  end

  # Checks of the record is completely empty or contains an empty name string
  def empty_record?
    if @record.name.nil? || @record.name.empty?
      @record.errors[:name] << I18n.t('name_not_empty')
      return true
    end
    false
  end

  # Checks if the sequence of chapters and verses is correct
  def incorrect_sequence?
    if @record.starting_chapter_nr > @record.ending_chapter_nr
      @record.errors[:name] << I18n.t('starting_greater_than_ending')
      return true
    end

    if (@record.starting_chapter_nr == @record.ending_chapter_nr) &&
        (@record.starting_verse > @record.ending_verse)
      @record.errors[:name] << I18n.t('starting_verse_chapter_mismatch')
      return true
    end
    false
  end

  # Finds the complete biblebook from the Pericope
  # The incoming biblebook may be abbreviated
  # The output biblebook is the full, official name
  def find_biblebook
    @biblebook_name = @pericope_to_publish.biblebook_name
    @biblebook = find_by_full_name
    if @biblebook.nil?
      @biblebook = find_by_abbreviation
      @biblebook = find_by_like if @biblebook.nil?
    end
    @pericope_to_publish.biblebook_name = @biblebook.name unless @biblebook.nil?
    # Replace the abbreviation with the full name
    @biblebook_name = @pericope_to_publish.biblebook_name
  end

  # TODO: Refactor into find_by(:type) met type = :fullname, :abbreviation, etc.
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
      @record.errors[:name] << I18n.t('unknown_biblebook')
      @biblebook = nil
    elsif biblebooks.length > 1
      @record.errors[:name] << ambiguous_string(@biblebook_name, biblebooks)
      @biblebook = nil
    else
      @biblebook = biblebooks[0]
    end
  end

  # Puts all possible biblebooks that match an abbreviation into an error message
  def ambiguous_string(book_name, biblebooks)
    book_list = []
    biblebooks.each do |book|
      book_list << book.name
    end
    "#{I18n.t('ambiguous_abbreviation')}: '#{book_name}' kan #{book_list.join(', ')} zijn"
  end

  # Updates the Pericope record with all the elements that consistute a Pericope
  def update_record
    @record.biblebook_id = @biblebook.id
    @record.biblebook_name = @biblebook_name

    @record.starting_chapter_nr = @pericope_to_publish.starting_chapter
    @record.starting_verse = @pericope_to_publish.starting_verse
    @record.ending_chapter_nr = @pericope_to_publish.ending_chapter
    @record.ending_verse = @pericope_to_publish.ending_verse

    @record.sequence = @record.starting_chapter_nr * 1000 + @record.starting_verse
  end

  # Reformats the name of a Pericope into a standardized format
  # @return [String] name of the Pericope, like: 'Genesis 1:1 - 3:5'
  def reformat_name
    name = ''
    name << @biblebook_name
    if @pericope_to_publish.starting_chapter != 0
      # Chapter filled, so this is not just a complete biblebook
      name << ' '
      name << @pericope_to_publish.starting_chapter.to_s
      if @pericope_to_publish.starting_verse != 0
        # there are verses, so this is not a whole chapter
        if @pericope_to_publish.ending_chapter > @pericope_to_publish.starting_chapter
          # multiple chapters, so publish a full 4 element string (1:2-3:4)
          name << ':'
          name << @pericope_to_publish.starting_verse.to_s
          name << ' - '
          name << @pericope_to_publish.ending_chapter.to_s
          name << ':'
          name << @pericope_to_publish.ending_verse.to_s
        elsif @pericope_to_publish.ending_verse > @pericope_to_publish.starting_verse
          # whole pericope, but within the same chapter (1:2-1:8)
          name << ':'
          name << @pericope_to_publish.starting_verse.to_s
          name << ' - '
          name << @pericope_to_publish.ending_verse.to_s
        elsif @pericope_to_publish.ending_verse == @pericope_to_publish.starting_verse
          # pericope consisting of just one verse
          name << ':'
          name << @pericope_to_publish.starting_verse.to_s
        end
      end
    end
    name
  end
end
