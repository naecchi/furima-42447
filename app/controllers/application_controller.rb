class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :basic_auth, if: :production?

  protected

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['admin'] && password == ENV['2222']
    end
  end

  def production?
    Rails.env.production?
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [
                                        :nickname, :email, :last_name,
                                        :first_name, :last_name_kana, :first_name_kana, :birthday_date
                                      ])
  end
end
