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
end
