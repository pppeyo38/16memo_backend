class MemoFilesController < ApplicationController
  before_action :set_memo_file, only: %i[ show update destroy ]

  # GET /memo_files
  def index
    @memo_files = MemoFile.all

    render json: @memo_files
  end

  # GET /memo_files/1
  def show
    render json: @memo_file
  end

  # POST /memo_files
  def create
    @memo_file = MemoFile.new(memo_file_params)

    if @memo_file.save
      render json: @memo_file, status: :created, location: @memo_file
    else
      render json: @memo_file.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /memo_files/1
  def update
    if @memo_file.update(memo_file_params)
      render json: @memo_file
    else
      render json: @memo_file.errors, status: :unprocessable_entity
    end
  end

  # DELETE /memo_files/1
  def destroy
    @memo_file.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_memo_file
      @memo_file = MemoFile.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def memo_file_params
      params.require(:memo_file).permit(:memo_id, :color_file_id)
    end
end
