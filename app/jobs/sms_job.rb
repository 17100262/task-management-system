class SmsJob < ApplicationJob
  queue_as :default
  # TwilioTextMessenger.new(message,shift_user.user.mobile_number).call

  def perform(shift,status)

    case status
    when "create"
      shift.shift_users.each do |shift_user|
        message = "Hi #{shift_user.user.first_name.present? ? shift_user.user.first_name: "User"}\n
          You have been assigned Shift on Task Management System by manager #{shift.manager.first_name}"
        recipient_number = '+923134082048'
        TwilioTextMessenger.new(message,shift_user.user.mobile_number).call
        
      end
    when "update"
      shift.shift_users.each do |shift_user|
        message = "Hi #{shift_user.user.first_name.present? ? shift_user.user.first_name: "User"}\n
          There is update in shift assigned to you by manager #{shift.manager.first_name} in Task Management System"
        recipient_number = '+923134082048'
        TwilioTextMessenger.new(message,recipient_number).call
        
      end
    
    else
      # puts "You just making it up!"
    end
    
  end
  
  # def call(recipient_number,message)
  #   client = Twilio::REST::Client.new
  #   client.messages.create({
  #     from: '+18175914674',
  #     to: recipient_number,
  #     body: message
  #   })
  # end
  
  # def shift_mail(shift,status)
  #     @shift = shift
  #     @status = status
  #     recipient = @status=="accepted" ? shift.shift.manager.email: shift.user.email
  #     mail_subject = 'You have been assigned shift' if @status == 'create'
  #     mail_subject = 'Update in assigned shift' if @status == 'update'
  #     mail_subject = 'Assigned shift cancelled' if @status == 'destroy'
  #     mail_subject = 'Assigned shift accepted' if @status == 'accepted'
  #     mail(to: recipient, subject: mail_subject)
  # end
  
  
  
end
