class PericopeValidator < ActiveModel::Validator
  def validate(record)
    if record.name.nil? || record.name.empty?
      record.errors[:name] << I18n.t("name_not_empty")
      return
    end

    begin
      pericope = PericopeString.new(record.name)
    rescue
      record.errors[:name] << t("invalid_pericope")
      return
    end

    biblebook_name = pericope.biblebook_name
    biblebook      = Biblebook.find_by(name: biblebook_name)
    if biblebook.nil?
      biblebook = Biblebook.find_by(abbreviation: biblebook_name)
      if biblebook.nil?
        record.errors[:name] << I18n.t("unknown_biblebook")
        return
      else
        record.name = biblebook.name # Replace the abbreviation with the full name
      end
    end
    record.biblebook_id = biblebook.id

    record.starting_chapter_nr = pericope.starting_chapter
    record.starting_verse      = pericope.starting_verse
    record.ending_chapter_nr   = pericope.ending_chapter
    record.ending_verse        = pericope.ending_verse

    if record.starting_chapter_nr > record.ending_chapter_nr
      record.errors[:name] << t("starting_greater_than_ending")
      return
    end

    if (record.starting_chapter_nr == record.ending_chapter_nr) && (record.starting_verse > record.ending_verse)
      record.errors[:name] << t("starting_verse_chapter_mismatch")
      return
    end
  end
end
