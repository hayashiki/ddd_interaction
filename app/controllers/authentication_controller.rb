class AuthenticationController < ApplicationController
  def authenticate
    outcome = Users::Authenticate.run(auth_params)
    if outcome.valid?
      render json: { access_token: "SecureRandom" }
    else 
      render status: :unauthorized
    end
  end

  private 
  def auth_params
    restify_param(:auth).require(:auth).permit(:email, :password)
  end
end
