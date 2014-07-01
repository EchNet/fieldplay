class UserController < ApplicationController

  def register
    @registration_params = registration_params
    if @registration_params
      @user = UserHelper.register(@registration_params)
      if @user.save
        redirect_to '/'
      end
    end
  end

  def login
  end

  private
    def registration_params
      begin
        p = params.require(:user)
      rescue
        return false
      end
      p.permit(:username, :email, :password, :password_confirmation)
    end

end
