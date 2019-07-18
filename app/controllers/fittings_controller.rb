class FittingsController < ApplicationController
  before_action :set_fitting, only: [:show, :edit, :update, :destroy]

  def index
    @doctrines = Doctrine.includes(:fittings).all
    @miscellaneous_fittings = Fitting.where(doctrine_id: nil)
  end

  def show
  end

  def new
    @fitting = Fitting.new
    @doctrines = Doctrine.all
  end

  def edit
    @doctrines = Doctrine.all
  end

  def create
    @fitting = Fitting.new(fitting_params)

    FittingProcessor.populate_fitting_data(@fitting, @fitting.original_text)

    respond_to do |format|
      if @fitting.save
        format.html { redirect_to @fitting, notice: 'Fitting was successfully created.' }
        format.json { render :show, status: :created, location: @fitting }
      else
        format.html { render :new }
        format.json { render json: @fitting.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @fitting.update(fitting_params)
        FittingProcessor.populate_fitting_data(@fitting, @fitting.original_text)
        format.html { redirect_to @fitting, notice: 'Fitting was successfully updated.' }
        format.json { render :show, status: :ok, location: @fitting }
      else
        format.html { render :edit }
        format.json { render json: @fitting.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @fitting.destroy
    respond_to do |format|
      format.html { redirect_to fittings_url, notice: 'Fitting was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_fitting
      @fitting = Fitting.find(params[:id])
    end

    def fitting_params
      params.fetch(:fitting, {}).permit(:name, :original_text, :doctrine_id)
    end
end
