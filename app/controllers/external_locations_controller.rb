class ExternalLocationsController < ApplicationController
  before_action :set_external_location, only: [:show, :edit, :update, :destroy]
  authorize_resource

  # GET /external_locations
  # GET /external_locations.json
  def index
    @external_locations = ExternalLocation.all
  end

  # GET /external_locations/1
  # GET /external_locations/1.json
  def show
  end

  # GET /external_locations/new
  def new
    @external_location = ExternalLocation.new
  end

  # GET /external_locations/1/edit
  def edit
  end

  # POST /external_locations
  # POST /external_locations.json
  def create
    @external_location = ExternalLocation.new(external_location_params)
    @external_location.company_id = current_user.company_id

    respond_to do |format|
      if @external_location.save
        format.html { redirect_to @external_location, notice: 'External location was successfully created.' }
        format.json { render :show, status: :created, location: @external_location }
      else
        format.html { render :new }
        format.json { render json: @external_location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /external_locations/1
  # PATCH/PUT /external_locations/1.json
  def update
    respond_to do |format|
      if @external_location.update(external_location_params)
        format.html { redirect_to @external_location, notice: 'External location was successfully updated.' }
        format.json { render :show, status: :ok, location: @external_location }
      else
        format.html { render :edit }
        format.json { render json: @external_location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /external_locations/1
  # DELETE /external_locations/1.json
  def destroy
    @external_location.destroy
    respond_to do |format|
      format.html { redirect_to external_locations_url, notice: 'External location was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_external_location
      @external_location = ExternalLocation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def external_location_params
      params.require(:external_location).permit(:name, :address, :description)
    end
end
