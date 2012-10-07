# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def index?
    controller.action_name == 'index'
  end
end
