require 'omnisocial'
class IngestorAccount < Omnisocial::LoginAccount
  def assign_account_info(user)
    self.login        = user[:login]
    self.picture_url  = user[:picture_url]
    self.name         = user[:name]
  end

  def account_url
    "/#{self.login}"
  end
end
