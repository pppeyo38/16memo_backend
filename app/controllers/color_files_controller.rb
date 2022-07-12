class ColorFilesController < ApplicationController
  before_action :set_color_file, only: %i[ show update destroy ]

  # GET /color_files
  def index
    @color_files = ColorFile.all

    render json: @color_files
  end

  # GET /color_files/1
  def show
    render json: @color_file
  end

  # POST /color_files
  def create
    @color_file = ColorFile.new(color_file_params)

    if @color_file.save
      render json: @color_file, status: :created, location: @color_file
    else
      render json: @color_file.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /color_files/1
  def update
    if @color_file.update(color_file_params)
      render json: @color_file
    else
      render json: @color_file.errors, status: :unprocessable_entity
    end
  end

  # DELETE /color_files/1
  def destroy
    @color_file.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_color_file
      @color_file = ColorFile.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def color_file_params
      params.require(:color_file).permit(:name, :user_id)
    end
end
