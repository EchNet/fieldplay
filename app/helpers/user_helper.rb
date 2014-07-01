module UserHelper

  require 'digest/sha1'

  def self.register(registration_params)

    username = registration_params[:username]
    email = registration_params[:email]
    password = registration_params[:password]
    password_confirmation = registration_params[:password_confirmation]

    if !username
      raise "user name is required"
    end

    if !password
      raise "password is required"
    end

    if password != password_confirmation
      raise "password confirmation must match"
    end

    salt = Digest::SHA1.hexdigest("Add #{username} and a sprinkle of #{Time.now}")
    encrypted_password = Digest::SHA1.hexdigest("Start with #{salt} and mix in #{password}")

    User.new(:username => username, :email => email, :encrypted_password => encrypted_password, :salt => salt)
  end

end
