class ApplicationController < ActionController::Base
  before_action :basic_auth, if: :production?

  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["admin"] && password == ENV["2222"]
    end
  end

  def production?
    Rails.env.production?
  end
end
