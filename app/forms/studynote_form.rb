# frozen_string_literal: true

# Form to handle new and updated Studynotes.
# Making use of Studynote and Pericope classes
class StudynoteForm
  include ActiveModel::Model

  def persisted?
    false
  end
end
