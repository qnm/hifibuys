# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include ExceptionNotifiable

  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  after_filter :set_content_type

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
#  protect_from_forgery :secret => 'a6a9e417376364b61645d469f04ac8cf'

  protected

  def set_content_type
    headers['Content-Type'] ||= 'application/xhtml+xml; charset=utf-8'
  end

  def config
    @@config = OpenShopper::Config.default
  end

  def require_login
    return redirect_to(admin_session_path) unless session[:logged_in]
  end

  helper_method :config

end
