class ColorFilesController < ApplicationController
  before_action :set_color_file, only: %i[ show update destroy ]

  # GET /color_files
  def index
    @color_files = ColorFile.preload(:memos).all

    @file = []
    @color_files.each_with_index do | color_file, index |
      # ファイル内カラー4色
      @main_color = color_file.memos.first(4).map {|m| m.color_code}
      @color_num = color_file.memos.length

      @file[index] = {
        name: color_file.name,
        user_id: color_file.user_id,
        memo: {
          main_color: @main_color,
          color_num: @color_num
        },
        created_at: color_file.created_at
      }
    end

    render json: @file
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

      render json: @color_file
    end

    # Only allow a list of trusted parameters through.
    def color_file_params
      params.require(:color_file).permit(:name, :user_id)
    end
end
