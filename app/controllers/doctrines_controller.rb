class DoctrinesController < ApplicationController
  before_action :set_doctrine, only: [:show, :edit, :update, :destroy]

  def index
    @doctrines = Doctrine.all
  end

  def show
  end

  def new
    @doctrine = Doctrine.new
  end

  def edit
  end

  def create
    @doctrine = Doctrine.new(doctrine_params)

    respond_to do |format|
      if @doctrine.save
        format.html { redirect_to @doctrine, notice: 'Doctrine was successfully created.' }
        format.json { render :show, status: :created, location: @doctrine }
      else
        format.html { render :new }
        format.json { render json: @doctrine.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @doctrine.update(doctrine_params)
        format.html { redirect_to @doctrine, notice: 'Doctrine was successfully updated.' }
        format.json { render :show, status: :ok, location: @doctrine }
      else
        format.html { render :edit }
        format.json { render json: @doctrine.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @doctrine.destroy
    respond_to do |format|
      format.html { redirect_to doctrines_url, notice: 'Doctrine was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_doctrine
      @doctrine = Doctrine.find(params[:id])
    end

    def doctrine_params
      params.fetch(:doctrine, {}).permit(:name)
    end
end
