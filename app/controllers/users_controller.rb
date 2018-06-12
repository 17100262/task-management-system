class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user, only: [:show, :edit, :update, :destroy, :schedule]
    authorize_resource
    # prepend_before_action :require_no_authentication, :only => [ :new, :create ]
    
    def edit
        @user = User.find(params[:id])
    end
    
    def schedule
        # @user = 
        # @shifts = current_user.shift_users.includes(:shift)
        @user  = User.find(params[:id])
        @shifts = @user.shifts
        respond_to do |wants|
            wants.html
            wants.json
        end
        
    end
    
    
    
    def show
    end
    
    def new
        @user = User.new
    
        respond_to do |wants|
            wants.html # new.html.erb
            wants.xml  { render :xml => @user }
        end
    end
    
    def create
        @user = User.new(user_params)
    
        respond_to do |wants|
            if @user.save
                
                BasicMailer.sign_up_email(@user,user_params[:password]).deliver_later
                message = "Hi #{@user.first_name} you have been added to Lambano People by #{current_user.first_name} #{current_user.admin? ? "from #{current_user.company.name}":"" }. Please check your email & follow instructions"
                
                TwilioTextMessenger.new(message,@user.mobile_number).call
                    
                flash[:notice] = 'User was successfully created.'
                if current_user.super_admin?
                    wants.html { redirect_to @user.company }
                else
                    wants.html { redirect_to dashboard_path}
                end
                
                
            else
                wants.html { render :action => "new" ,notice: @user.errors.full_messages }
                wants.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
            end
        end
    end
    def destroy
        @user = User.find(params[:id])
        @user.destroy
    
        respond_to do |wants|
            wants.html { redirect_to(companies_url) }
            wants.xml  { head :ok }
        end
    end
    
    def update
        @user = User.find(params[:id])
        
        if @user.update(user_params)
            @user.update!(password_changed: true)
            bypass_sign_in @user
            redirect_to edit_user_path, notice: "User profile updated successfully"
        else
            redirect_to edit_user_path, notice: @user.errors.full_messages.join
        end
    end
    
    private
    
    def set_user
        @user = User.find(params[:id])
    end
    def user_params
        params.require(:user).permit(:role,:company_id,:email,:password,:password_confirmation,:username,:first_name,:last_name,:landline_number,:employee_number,:mobile_number,:address,:avatar,skill_ids: [],training_users_attributes: [:id, :training_id, :date_of_completion,:duration,:training_expiry,:training_provider,:training_type, :_destroy])
    end
end
