class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user, only: [:show, :edit, :update, :destroy]
    authorize_resource
    # prepend_before_action :require_no_authentication, :only => [ :new, :create ]
    
    def edit
        @user = User.find(params[:id])
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
            if @user.save!
                BasicMailer.sign_up_email(@user,user_params[:password]).deliver_later
                flash[:notice] = 'User was successfully created.'
                wants.html { redirect_to(@user) }
                wants.xml  { render :xml => @user, :status => :created, :location => @user }
            else
                wants.html { render :action => "new" }
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
        params.require(:user).permit(:role,:company_id,:email,:password,:password_confirmation,:username,:first_name,:last_name,:landline_number,:employee_number,:mobile_number,:address, training_ids: [])
    end
end
