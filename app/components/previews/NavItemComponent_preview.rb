# frozen_string_literal: true

# Visual component
class NavItemComponentPreview < Lookbook::Preview
  def standard
    render NavItemComponent.new(text: 'text', link: '/home', id: 'id').call
  end
end

