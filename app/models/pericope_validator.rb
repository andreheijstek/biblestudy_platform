class PericopeValidator < ActiveModel::Validator
  def validate(record)
    @record = record
    return if emptyRecord?

    getPericope
    return if @pericope_to_publish.nil?

    findBiblebook
    return if @biblebook.nil?

    updateRecord
    return if incorrectSequence?

    # Todo: dit hoort hier niet, single responsibility principle
    # kan evt. naar een after_validation hook?
    @record.name = reformat_name
  end

  private

  def getPericope
    begin
      @pericope_to_publish = PericopeString.new(@record.name)
    rescue
      @record.errors[:name] << I18n.t('invalid_pericope')
    end
  end

  def emptyRecord?
    if @record.name.nil? || @record.name.empty?
      @record.errors[:name] << I18n.t('name_not_empty')
      return true
    end
    false
  end

  def incorrectSequence?
    if @record.starting_chapter_nr > @record.ending_chapter_nr
      @record.errors[:name] << I18n.t('starting_greater_than_ending')
      return true
    end

    if (@record.starting_chapter_nr == @record.ending_chapter_nr) && (@record.starting_verse > @record.ending_verse)
      @record.errors[:name] << I18n.t('starting_verse_chapter_mismatch')
      return true
    end
    false
  end

  def findBiblebook
    @biblebook_name = @pericope_to_publish.biblebook_name
    @biblebook = findByFullName
    if @biblebook.nil?
      @biblebook = findByAbbreviation
      if @biblebook.nil?
        @biblebook = findByLike
      end
    end
    @pericope_to_publish.biblebook_name = @biblebook.name unless @biblebook.nil?
    # Replace the abbreviation with the full name
    @biblebook_name = @pericope_to_publish.biblebook_name
  end

  def findByFullName
    @biblebook = Biblebook.find_by(name: @biblebook_name)
  end

  def findByAbbreviation
    @biblebook = Biblebook.find_by(abbreviation: @biblebook_name)
  end

  def findByLike
    biblebooks = Biblebook.where('name LIKE (?)',
                                 "%#{@biblebook_name.slice(0, 5)}%")
    if biblebooks.length == 0
      @record.errors[:name] << I18n.t('unknown_biblebook')
      @biblebook = nil
    elsif biblebooks.length > 1
      @record.errors[:name] << ambiguous_string(@biblebook_name, biblebooks)
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

  def updateRecord
    @record.biblebook_id = @biblebook.id
    @record.biblebook_name = @biblebook_name

    @record.starting_chapter_nr = @pericope_to_publish.starting_chapter
    @record.starting_verse = @pericope_to_publish.starting_verse
    @record.ending_chapter_nr = @pericope_to_publish.ending_chapter
    @record.ending_verse = @pericope_to_publish.ending_verse

    @record.sequence = @record.starting_chapter_nr * 1000 + @record.starting_verse
  end

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
