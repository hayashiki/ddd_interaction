class Users::Authenticate < ActiveInteraction::Base
  string :email
  string :password

  def execute
    user = User.find_by(email: email)
    return user if user && user.authenticate(password)
    errors.add :authentication_error, I18n.t('errors.invalid_credentials')
  end

end