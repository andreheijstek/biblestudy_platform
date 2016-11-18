class PericopeValidator < ActiveModel::Validator
  def validate(record)
    return if emptyRecord?(record)

    begin
      pericope = PericopeString.new(record.name)
    rescue
      record.errors[:name] << t("invalid_pericope")
      return
    end

    biblebook = findBook(pericope)

    record = updateRecord(biblebook, pericope, record)
    return if incorrectSequence?(record)
  end

  private

  def emptyRecord?(record)
    if record.name.nil? || record.name.empty?
      record.errors[:name] << I18n.t("name_not_empty")
      return
    end
  end

  def incorrectSequence?(record)
    if record.starting_chapter_nr > record.ending_chapter_nr
      record.errors[:name] << t("starting_greater_than_ending")
      return
    end

    if (record.starting_chapter_nr == record.ending_chapter_nr) && (record.starting_verse > record.ending_verse)
      record.errors[:name] << t("starting_verse_chapter_mismatch")
      return
    end
  end

  def reformatName(biblebook, pericope)
    "#{biblebook.name} #{pericope.starting_chapter}:#{pericope.starting_verse} - #{pericope.ending_chapter}:#{pericope.ending_verse}"
  end

  def findBook(pericope)
    # first seach by whole name
    biblebook_name = pericope.biblebook_name
    biblebook      = Biblebook.find_by(name: biblebook_name)
    if biblebook.nil?
      # then search by the standard abbreviation (my standard)
      biblebook      = Biblebook.find_by(abbreviation: biblebook_name)
      if biblebook.nil?
        # then do a LIKE search
        biblebooks = Biblebook.where("name LIKE (?)", "%#{biblebook_name.slice(0, 5)}%")
        if biblebooks.length == 0
          record.errors[:name] << I18n.t("unknown_biblebook")
        elsif biblebooks.length > 1
          record.errors[:name] << I18n.t("ambiguous_abbreviation")
        else
          biblebook = biblebooks[0]
        end

        if biblebook.nil?
          record.errors[:name] << I18n.t("unknown_biblebook")
          return nil
        else
          pericope.biblebook_name = biblebook.name # Replace the abbreviation with the full name
        end
      end
    end
    biblebook
  end

  def updateRecord(biblebook, pericope, record)
    record.biblebook_id = biblebook.id
    record.name = reformatName(biblebook, pericope)

    record.starting_chapter_nr = pericope.starting_chapter
    record.starting_verse = pericope.starting_verse
    record.ending_chapter_nr = pericope.ending_chapter
    record.ending_verse = pericope.ending_verse

    record
  end
end
