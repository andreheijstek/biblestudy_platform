# frozen_string_literal: true

# PORO class to handle pericopes
class PericopeString
  def initialize(pericope)
    @pericope = pericope
  end

  def to_s
    @pericope.to_s
  end
end
