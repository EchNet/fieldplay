class UserController < ApplicationController

  def register
    user, notice = UserHelper.register(registration_params)
    if user
      session[:current_user_id] = user.id
    end
    if notice
      flash[:notice] = notice
    end
    redirect_to '/'
  end

  def login
    user, notice = UserHelper.login(login_params)
    if user
      session[:current_user_id] = user.id
    end
    if notice
      flash[:notice] = notice
    end
    redirect_to '/'
  end

  private

    # Work with Rails 4 strong parameters
    def registration_params
      begin
        p = params.require(:user)
      rescue
        return false
      end
      p.permit(:username, :email, :password, :password_confirmation)
    end

    # Work with Rails 4 strong parameters
    def login_params
      begin
        p = params.require(:login)
      rescue
        return false
      end
      p.permit(:username, :password)
    end
end
