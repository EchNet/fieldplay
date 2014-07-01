module UserHelper

  require 'digest/sha1'

  def self.register(registration_params)

    username = registration_params[:username]
    email = registration_params[:email]
    password = registration_params[:password]
    password_confirmation = registration_params[:password_confirmation]

    user = nil

    if !username
      notice = "user name is required"
    elif !password
      notice = "password is required"
    elif password != password_confirmation
      notice = "password confirmation must match"
    else
      salt = UserHelper.generate_salt(username)
      encrypted_password = UserHelper.encrypt(password, salt)
      user = User.new({
          :username => username,
          :email => email,
          :encrypted_password => encrypted_password,
          :salt => salt
        })
      if !user.save
        user = nil
        notice = "User creation failed"
      end
    end

    return user, notice
  end

  def self.login(login_params)

    username = login_params[:username]
    password = login_params[:password]

    user = nil

    if !username
      notice = "user name is required"
    elif !password
      notice = "password is required"
    else
      user = User.find_by(username: username)
      if user
        encrypted_password = UserHelper.encrypt(password, user.salt)
        if encrypted_password != user.encrypted_password
          user = nil
        end
      end
      if !user
        notice = "Login failed"
      end
    end

    return user, notice
  end

  private

    def self.generate_salt(username)
      Digest::SHA1.hexdigest("Start with #{username} and sprinkle in some #{Time.now}")
    end

    def self.encrypt(password, salt)
      return Digest::SHA1.hexdigest("Mix #{password} with a dash of #{salt}")
    end

end
