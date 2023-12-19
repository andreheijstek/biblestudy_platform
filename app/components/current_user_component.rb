# frozen_string_literal: true

# Component to render the current user in the nav-bar
class CurrentUserComponent < ViewComponent::Base
  def initialize(current_user:)
    super
    @current_user = current_user
  end

  def call
    tag.div(@current_user, class: %w[ml-auto navbar-text])
  end
end
