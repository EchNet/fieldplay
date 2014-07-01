class WelcomeController < ApplicationController

  def index
    @current_user = find_current_user
  end

  private
    def find_current_user
      session[:current_user_id] && User.find_by(id: session[:current_user_id])
    end
end
