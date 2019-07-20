class StagingsController < ApplicationController
  before_action :set_staging, only: [:show, :edit, :update, :destroy]

  def index
    @stagings = Staging.all
  end

  def show
  end

  def new
    @staging = Staging.new
  end

  def edit
    Fitting.all.order(:doctrine_id).each do |fitting|
      staged_fitting = @staging.staged_fittings.find_or_initialize_by(fitting: fitting)
      staged_fitting.target_quantity ||= 0
    end
  end

  def create
    @staging = Staging.new(staging_params)

    respond_to do |format|
      if @staging.save
        format.html { redirect_to @staging, notice: 'Staging was successfully created.' }
        format.json { render :show, status: :created, location: @staging }
      else
        format.html { render :new }
        format.json { render json: @staging.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @staging.update(staging_params)
        format.html { redirect_to @staging, notice: 'Staging was successfully updated.' }
        format.json { render :show, status: :ok, location: @staging }
      else
        format.html { render :edit }
        format.json { render json: @staging.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @staging.destroy
    respond_to do |format|
      format.html { redirect_to stagings_url, notice: 'Staging was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_staging
      @staging = Staging.find(params[:id])
    end

    def staging_params
      params.fetch(:staging, {}).permit(:name, staged_fittings_attributes: [ :id, :fitting_id, :target_quantity ] )
    end
end
