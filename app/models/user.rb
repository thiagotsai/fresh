class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable, :confirmable,
  :omniauthable, omniauth_providers: [:facebook]
  validates :email, presence: true, uniqueness: true


  def self.find_for_facebook_oauth(auth)
    # Rails version 5
    #   user_params = auth.to_h.slice(:provider, :uid)
    #   user_params.merge! auth.info.slice(:email, :first_name, :last_name)
    #   user_params[:facebook_picture_url] = auth.info.image
    #   user_params[:token] = auth.credentials.token
    #   user_params[:token_expiry] = Time.at(auth.credentials.expires_at)

    #   user = User.where(provider: auth.provider, uid: auth.uid).first
    #   user ||= User.where(email: auth.info.email).first # User did a regular sign up in the past.
    #   if user
    #     user.update(user_params)
    #   else
    #     user = User.new(user_params)
    #     user.password = Devise.friendly_token[0,20]  # Fake password for validation
    #     user.save
    #   end

    #   return user
    # end

    # Rails 4.2.6 (wiki)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.first_name = auth.info.first_name   # assuming the user model has a name
      user.last_name = auth.info.last_name   # assuming the user model has a name
      user.facebook_picture_url = auth.info.image # assuming the user model has an image
      user.token = auth.credentials.token
      user.token_expiry = Time.at(auth.credentials.expires_at)
    end
  end
end
