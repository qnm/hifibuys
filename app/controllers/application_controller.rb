class ApplicationController < ActionController::Base
  protect_from_forgery

  def contact_us
    render 'misc/contact_us'
  end
end
