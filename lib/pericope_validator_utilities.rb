module PericopeValidatorUtilities
  private

  def get_biblebook_from_tree(tree)
    tree[:biblebook].to_s.strip
  end

  def get_ending_verse_from_tree(tree)
    tree[:ending_verse].to_i
  end

  def get_ending_chapter_from_tree(tree)
    tree[:ending_chapter].to_i
  end

  def get_starting_verse_from_tree(tree)
    tree[:starting_verse].to_i
  end

  def get_starting_chapter_from_tree(tree)
    tree[:starting_chapter].to_i
  end

  def full_pericope_starting_with_full_chapter?
    start_verse.verse_nr == 1 &&
      record.end_verse.chapter_nr > start_verse.chapter_nr
  end

  def full_pericope_ending_with_full_chapter?
    end_verse.verse_nr == 1 &&
      end_verse.chapter_nr > record.start_verse.chapter_nr
  end

  def set_end_chap_to_start_chap(end_verse, start_verse)
    end_verse.chapter_nr = start_verse.chapter_nr
  end

  def last_chapter
    get_biblebook(record.biblebook_name).nr_of_chapters
  end

  def set_ending_to_starting
    end_verse.chapter_nr = start_verse.chapter_nr
    end_verse.verse_nr = start_verse.verse_nr
  end

  def single_verse?
    start_verse.verse_nr.positive? && end_verse.chapter_nr.zero? &&
    end_verse.verse_nr.zero?
  end

  def whole_biblebook?
    start_verse.chapter_nr.zero? && start_verse.verse_nr.zero? &&
    end_verse.chapter_nr.zero? && end_verse.verse_nr.zero?
  end

  def single_chapter?
    start_verse.chapter_nr.positive? && start_verse.verse_nr.zero? &&
    end_verse.chapter_nr.zero? && end_verse.verse_nr.zero?
  end

  def multiple_full_chapters?
    start_verse.verse_nr.zero? && end_verse.verse_nr.zero? &&
    end_verse.chapter_nr > start_verse.chapter_nr
  end

  def multiple_verses_one_chapter?
    end_chap = end_verse.chapter_nr

    (end_verse.verse_nr > start_verse.verse_nr) &&
    ((end_chap == start_verse.chapter_nr) || end_chap.zero?)
  end

  def full_pericope?
    start_verse.chapter_nr.positive? && start_verse.verse_nr.positive? &&
    end_verse.chapter_nr.positive? && end_verse.verse_nr.positive?
  end

end
