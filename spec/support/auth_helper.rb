class AuthHelper
  def http_login
    user = Rails.application.credentials.github[:username]
    pw = Rails.application.credentials.github[:password]
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,pw)
  end  
end