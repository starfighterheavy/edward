class ApplicationController < ActionController::Base
  include Rapido::Controller
  include Rapido::AppController

  protect_from_forgery with: :exception
  before_action :authenticate_user!
  authority :current_user_account

  private

  def current_user_account
    current_user.account
  end
end
