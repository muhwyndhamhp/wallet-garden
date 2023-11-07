# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  before_action :authenticate_user, unless: :login_or_register_action?

  private

  def authenticate_user
    authenticate_or_request_with_http_token do |token, _options|
      @current_user = User.find_by(auth_token: token)
    end
  end

  attr_reader :current_user

  def login_or_register_action?
    controller_name == 'sessions' && action_name == 'create' ||
      controller_name == 'registrations' && action_name == 'create'
  end
end
