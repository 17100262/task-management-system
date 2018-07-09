class Shift < ApplicationRecord
  belongs_to :external_location, optional: true
  has_many :shift_users, dependent: :destroy
  # validates_associated :shift_users
  # ,:before_remove => :destroy_email
  validate :check_conflicting_shift
  # ,:on => :create
  
  has_many :users, through: :shift_users
  belongs_to :manager, class_name: "User",optional: true
  belongs_to :company
  enum shift_status: [:pending,:approved,:cancelled,:unavailable]
  after_update_commit :send_update_email
  
  attr_accessor :date_range
  
  after_update_commit :update_shift_sms
  after_create_commit :send_sms
  
  def send_sms
    SmsJob.perform_later(self,'create') if self.shift_status!="unavailable"
  end
  
  def update_shift_sms
    SmsJob.perform_later(self,'update') if self.shift_status!="unavailable"
  end
  
  def check_conflicting_shift
    # errors.add(:base,"#{self.shift_users}")
    # a = false
    self.shift_users.each do |shift_user|
      shift_user.user.shifts.where.not(id: self.id).each do |shift|
        
        if (shift.start_time..shift.end_time).overlaps?(self.start_time..self.end_time)
          errors[:base] << "This Shift Overlaps with #{shift_user.user.fullname}'s other shift"
          a = false
          return a
        end
      end
    end
  end
  
  
  # def destroy_email
  #   self.shift_users.each do |shift|
  #     BasicMailer.shift_mail(shift,"destroy").deliver_later
  #   end
  # end
  def send_update_email
    self.shift_users.each do |shift_user|
      BasicMailer.shift_mail(shift_user,"update").deliver_later
      message = "Shift has been updated."
      TwilioTextMessenger.new(message,shift_user.user.mobile_number).call
    end
  end
  
  def duration
    d = self.start_time
    # t = self.shift_time
    start = DateTime.new(d.year, d.month, d.day, d.hour, d.min, d.sec, d.zone).to_time
    # d = self.end_date
    t = self.end_time
    end_ = DateTime.new(t.year, t.month, t.day, t.hour, t.min, t.sec, t.zone).to_time
    return (end_ - start)
    # total_minutes =  (end_ - start)/1.minutes
    # in_hours = (total_minutes / 60).to_i
    # rem_min = total_minutes % 60
    # return [in_hours,rem_min]
    # /1.hours
  end
  
  def all_day_event?
    self.start == self.start.midnight && self.end == self.end.midnight ? true : false
  end
  
  def external_location_name
    self.external_location.name
  end
  
  def status_notify
    
  end
  
end
