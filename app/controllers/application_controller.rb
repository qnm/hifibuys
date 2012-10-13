class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_search

  has_widgets do |root|
    root << widget(:search)
  end

  def contact_us
    render 'misc/contact_us'
  end

  def set_search
    @q = Item.search(params[:q])
  end
end
