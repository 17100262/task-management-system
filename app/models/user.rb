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
  has_many :training_users, dependent: :destroy
  has_many :trainings, through: :training_users
  has_many :shift_users, dependent: :destroy
  has_many :shifts, through: :shift_users
  has_many :skill_users, dependent: :destroy
  has_many :skills, through: :skill_users
  has_many :managed_shifts, foreign_key: "manager_id",class_name: 'Shift',dependent: :destroy
  
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  
  validate :company_employees, on: [:create,:new]
  accepts_nested_attributes_for :training_users, reject_if: :all_blank, allow_destroy: true

  
  def company_employees
    if (self.company and self.company.users.count >= self.company.tier)
      errors[:base] << 'Limit Reached. Cannot add more users against this company'
    end
  end
  
  def fullname
    [self.first_name, self.last_name].join(' ')
  end
  
  
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
