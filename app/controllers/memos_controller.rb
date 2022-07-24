class MemosController < ApplicationController
  # wrap_parameters format: []
  before_action :set_memo, only: %i[ update destroy ]

  # GET /memos
  def index
    @get_memos = Memo.preload(:tag).all

    @memos = []
    @get_memos.each_with_index do | get_memo, index |
      @memos[index] = {
        id: get_memo.id,
        color_code: get_memo.color_code,
        comment: get_memo.comment,
        URL: get_memo.url,
        tag_name: get_memo.tag.name,
        created_at: get_memo.created_at
      }
    end

    render json: @memos
  end

  # GET /memos/1
  def show
    @get_memo = Memo.preload(:tag).find(params[:id])

    @memo = {
      id: @get_memo.id,
      color_code: @get_memo.color_code,
      comment: @get_memo.comment,
      URL: @get_memo.url,
      tag_name: @get_memo.tag.name,
      created_at: @get_memo.created_at
    }
    render json: @memo
  end

  # GET /memos/search
  def search
    @get_memos = Memo.joins(:tag).where('tags.name = ?', params[:q])

    @memos = @get_memos.map do | get_memo |
      {
        id: get_memo.id,
        color_code: get_memo.color_code,
        comment: get_memo.comment,
        URL: get_memo.url,
        tag_name: get_memo.tag.name,
        created_at: get_memo.created_at
      }
    end

    render json: @memos
  end

  # POST /memos
  def create
    tag_name = params[:tag_name]
    color_file_name = params[:color_file_name]

    if tag_name.blank? || color_file_name.blank?
      render json: { error: 'tag_name and color_file_name are required' }, status: :unprocessable_entity
      return
    end

    @tag = Tag.find_by(name: tag_name)
    @color_file = ColorFile.find_by(name: color_file_name, user_id: @current_user.id)

    ActiveRecord::Base.transaction do
      @tag ||= Tag.create!(name: tag_name)
      @color_file ||= ColorFile.create!(name: color_file_name, user_id: @current_user.id)

      @memo = Memo.create!(
        **memo_params,
        user_id: @current_user.id,
        tag_id: @tag.id,
        color_file_id: @color_file.id,
      )
    end
    render json: @memo, status: :created, location: @memo

  rescue => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  # PATCH/PUT /memos/1
  def update
    # 変更にタグ名が含まれていた場合
    if params[:tag_name]
      tag_name = params[:tag_name]

      # タグが既に存在する場合データを取得、なければ新規作成
      if Tag.exists?(name: tag_name)
        @tag = Tag.find_by(name: tag_name)
      else
        @tag = Tag.create(name: tag_name)
      end
    end

    if @memo.update(memo_params) || @memo.update(tag_id: @tag.id)
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
