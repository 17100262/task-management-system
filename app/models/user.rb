class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,:recoverable, :rememberable, :trackable, :validatable
        # ,:registerable
        # , :lockable
        # ,:omniauthable, omniauth_providers: %i[facebook linkedin google_oauth2 twitter]
        # , :confirmable
  enum role: [:employee,:manager,:admin,:super_admin]
  
  has_many :user_locations , dependent: :destroy
  has_many :locations, through: :user_locations
  belongs_to :company, optional: true
  # has_many :user_trainings, dependent: :destroy
  has_and_belongs_to_many :trainings
  has_many :shift_users, dependent: :destroy
  has_many :shifts, through: :shift_users
  
  
  # def self.from_omniauth(auth)
  #   where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
  #     user.email = auth.info.email
  #     user.password = Devise.friendly_token[0,20]
  #     user.linkedin_link = auth.info.urls.public_profile if auth.provider=="linkedin"
  #     user.name = auth.info.name   # assuming the user model has a name
  #     # user.image = auth.info.image # assuming the user model has an image
  #     # If you are using confirmable and the provider(s) you use validate emails, 
  #     # uncomment the line below to skip the confirmation emails.
  #     user.skip_confirmation!
  #  end
  # end
end
