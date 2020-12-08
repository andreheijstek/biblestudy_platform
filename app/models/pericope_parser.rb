# frozen_string_literal: true

require 'parslet'

# Class is used to parse a pericope-string like 'Genesis 1:2-3:4'
# into a parse-tree, like
# tree = { biblebook: 'Genesis', starting_chapter: 1, starting_verse: 2,
# ending_chapter: 3, ending_verse: 4 }
#
# It is able to handle partial pericopes like 'Genesis', 'Genesis 1', etc.
class PericopeParser < Parslet::Parser
  rule(:string) { match(/[[:word:]]/).repeat(1) >> space? }

  rule(:space) { match('\s').repeat(1) }
  rule(:space?) { space.maybe }

  rule(:integer) { match(/[0-9]/).repeat(1) >> space? }
  rule(:integer?) { integer.maybe }

  rule(:colon) { match(':') >> space? }
  rule(:colon?) { colon.maybe }

  rule(:dash) { match('-') >> space? }
  rule(:dash?) { dash.maybe }

  rule(:biblebook) { integer? >> string }
  rule(:chapter) { integer }
  rule(:verse) { integer }

  rule(:whole_book) { biblebook.as(:biblebook) }
  rule(:whole_chapter) do
    biblebook.as(:biblebook) >> \
      chapter.as(:starting_chapter)
  end
  rule(:single_verse) do
    biblebook.as(:biblebook) >> \
      chapter.as(:starting_chapter) >> \
      colon >> \
      verse.as(:starting_verse_nr)
  end
  rule(:full_pericope) do
    biblebook.as(:biblebook) \
      >> chapter.as(:starting_chapter) >> colon \
      >> verse.as(:starting_verse_nr) >> dash \
      >> chapter.as(:ending_chapter) >> colon \
      >> verse.as(:ending_verse_nr)
  end
  rule(:multiple_chapters) do
    biblebook.as(:biblebook) \
      >> chapter.as(:starting_chapter) >> dash \
      >> chapter.as(:ending_chapter)
  end
  rule(:multiple_verses_in_single_chapter) do
    biblebook.as(:biblebook) \
      >> chapter.as(:starting_chapter) >> colon \
      >> verse.as(:starting_verse_nr) >> dash \
      >> verse.as(:ending_verse_nr)
  end

  rule(:pericope) do
    full_pericope |
      multiple_verses_in_single_chapter |
      single_verse |
      whole_chapter |
      whole_book |
      multiple_chapters
  end

  root(:pericope)
end
