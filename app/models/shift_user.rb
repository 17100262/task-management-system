class ShiftUser < ApplicationRecord
  belongs_to :shift
  belongs_to :user
  
  
  after_create_commit :send_creation_email
  after_update :status_notify, :if => proc{ |obj| obj.accepted_changed? && obj.accepted == true }
  # around_destroy :destroy_email
  
  
  def status_notify
    BasicMailer.shift_mail(self,"accepted").deliver_later
  end
  
  
  def send_creation_email
    # self.shift_users.each do |shift_user|
      BasicMailer.shift_mail(self,"create").deliver_later
    # end
  end
  
end
