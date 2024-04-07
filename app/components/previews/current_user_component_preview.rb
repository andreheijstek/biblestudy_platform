# frozen_string_literal: true

# Visual component
# @label Current User
# @display bg_color "#fff"
class CurrentUserComponentPreview < ViewComponent::Preview
  def standard
    render CurrentUserComponent.new(current_user: 'andre.heijstek@hey.com').call
  end
end
