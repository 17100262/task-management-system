class Shift < ApplicationRecord
  belongs_to :external_location
  has_many :shift_users, dependent: :destroy,:before_remove => :destroy_email
  has_many :users, through: :shift_users
  belongs_to :manager, class_name: "User"
  belongs_to :company
  enum shift_status: [:pending,:approved,:cancelled]
  after_update_commit :send_update_email
  
  def destroy_email
    self.shift_users.each do |shift|
      BasicMailer.shift_mail(shift,"destroy").deliver_later
    end
  end
  def send_update_email
    self.shift_users.each do |shift_user|
      BasicMailer.shift_mail(shift_user,"update")
    end
  end
  
  def status_notify
    
  end
  
end
