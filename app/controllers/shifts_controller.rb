class ShiftsController < ApplicationController
  before_action :set_shift, only: [:show, :edit, :update, :destroy,:confirm_shift]
  authorize_resource

  # GET /shifts
  # GET /shifts.json
  def index
    @shifts = Shift.all
  end
  
  def my_shifts
    @shifts = current_user.shift_users.includes(:shift)
  end
  
  def confirm_shift
    @shift_user = ShiftUser.find(params[:id])
    @shift_user.update(confirmed_by_manager: true)
    user = @shift_user.user
    message = "Hi #{user.first_name} the shift accepted by you has been confirmed by manager #{@shift.manager.first_name}"
                
    TwilioTextMessenger.new(message,@shift_user.user.mobile_number).call
    redirect_to @shift,notice: "Shift Confirmed Successfully"
  end
  
  def accept_shift
    @shift_user = ShiftUser.find(params[:id])
    @shift_user.update(accepted: true)
    redirect_to @shift_user.shift,notice: "Shift Accepted Successfully"
  end

  # GET /shifts/1
  # GET /shifts/1.json
  def show
  end

  # GET /shifts/new
  def new
    @shift = Shift.new
    @shift.start_time = params[:start_time] if params[:start_time]
    @shift.end_time = params[:end_time] if params[:end_time]
  end

  # GET /shifts/1/edit
  def edit
  end
  
  def unavailability_new
    @shift = Shift.new
  end
  
  def unavailability_show
    @shift = Shift.find(params[:id])
  end
  
  def unavailability_create
    @shift = Shift.new(shift_params)
    @shift.company_id = current_user.company.id

    respond_to do |format|
      if @shift.save
        format.html { redirect_to unavailability_show_path(@shift), notice: 'Unavailable Days were successfully added.' }
      else
        format.html { render :unavailability_new }
      end
    end
  end

  # POST /shifts
  # POST /shifts.json
  def create
    @shift = Shift.new(shift_params)
    @shift.manager_id = current_user.id
    @shift.company_id = current_user.company.id

    respond_to do |format|
      if @shift.save
        format.html { redirect_to @shift, notice: 'Shift was successfully created.' }
        format.json { render :show, status: :created, location: @shift }
      else
        format.html { render :new }
        format.json { render json: @shift.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shifts/1
  # PATCH/PUT /shifts/1.json
  def update
    respond_to do |format|
      if @shift.update(shift_params)
        format.html { redirect_to @shift, notice: 'Shift was successfully updated.' }
        format.json { render :show, status: :ok, location: @shift }
      else
        format.html { render :edit }
        format.json { render json: @shift.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shifts/1
  # DELETE /shifts/1.json
  def destroy
    @shift.destroy
    respond_to do |format|
      format.html { redirect_to shifts_url, notice: 'Shift was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shift
      @shift = Shift.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shift_params
      params.require(:shift).permit(:end_time,:start_time, :shift_status, :skills_required, :external_location_id,user_ids: [])
    end
end
