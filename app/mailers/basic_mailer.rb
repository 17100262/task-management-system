class BasicMailer < ApplicationMailer
    def sign_up_email(user,password)
        @user = user
        @password = password
        mail(to: @user.email, subject: 'You have been added to task management system')
    end
    
    def shift_mail(shift,status)
        @shift = shift
        @status = status
        recipient = @status=="accepted" ? shift.shift.manager.email: shift.user.email
        mail_subject = 'You have been assigned shift' if @status == 'create'
        mail_subject = 'Update in assigned shift' if @status == 'update'
        mail_subject = 'Assigned shift cancelled' if @status == 'destroy'
        mail_subject = 'Assigned shift accepted' if @status == 'accepted'
        mail(to: recipient, subject: mail_subject)
    end
end
