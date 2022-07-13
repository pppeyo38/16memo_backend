class MemosController < ApplicationController
  # wrap_parameters format: []
  before_action :set_memo, only: %i[ show update destroy ]

  # GET /memos
  def index
    @memos = Memo.all

    render json: @memos
  end

  # GET /memos/1
  def show
    render json: @memo
  end

  # POST /memos
  def create
    # TODO: ログイン中のユーザーの user_id を取得する
    user_id = 1

    tag_name = params[:tag_name]
    color_file_name = params[:color_file_name]

    if tag_name.blank? || color_file_name.blank?
      render json: { error: 'tag_name and color_file_name are required' }, status: :unprocessable_entity
      return
    end

    @tag = Tag.find_by(name: tag_name)
    @color_file = ColorFile.find_by(name: color_file_name)

    ActiveRecord::Base.transaction do
      @tag ||= Tag.create!(name: tag_name)
      @color_file ||= ColorFile.create!(name: color_file_name, user_id: user_id)

      @memo = Memo.create!(
        **memo_params,
        user_id: user_id,
        tag_id: @tag.id,
        color_file_id: @color_file.id,
      )
    end

  rescue => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  # PATCH/PUT /memos/1
  def update
    if @memo.update(memo_params)
      render json: @memo
    else
      render json: @memo.errors, status: :unprocessable_entity
    end
  end

  # DELETE /memos/1
  def destroy
    @memo.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_memo
      @memo = Memo.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def memo_params
      params.require(:memo).permit(:user_id, :color_code, :comment, :url)
    end
end
