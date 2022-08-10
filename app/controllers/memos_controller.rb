class MemosController < ApplicationController
  # wrap_parameters format: []
  before_action :my_set_memo, only: %i[ update destroy ]

  # GET /memos
  def index
    @get_memos = Memo.preload(:tag).all

    @memos = []
    @get_memos.each_with_index do | get_memo, index |
      @memos[index] = {
        id: get_memo.id,
        colorCode: get_memo.colorCode,
        comment: get_memo.comment,
        url: get_memo.url,
        tagName: get_memo.tag.name,
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
      colorCode: @get_memo.colorCode,
      comment: @get_memo.comment,
      url: @get_memo.url,
      tagName: @get_memo.tag.name,
      created_at: @get_memo.created_at
    }
    render json: @memo
  end

  # GET /search
  def search
    get_tag_name = params[:q]

    if get_tag_name.blank?
      @get_memos = Memo.preload(:tag).all

      @memos = @get_memos.map do | get_memo |
        {
          id: get_memo.id,
          colorCode: get_memo.colorCode,
          comment: get_memo.comment,
          url: get_memo.url,
          tagName: get_memo.tag.name,
          created_at: get_memo.created_at
        }
      end
    else
      @get_memos = Memo.joins(:tag).where('tags.name = ?', params[:q])

      @memos = @get_memos.map do | get_memo |
        {
          id: get_memo.id,
          colorCode: get_memo.colorCode,
          comment: get_memo.comment,
          url: get_memo.url,
          tagName: get_memo.tag.name,
          created_at: get_memo.created_at
        }
      end
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
    ActiveRecord::Base.transaction do
      if params[:tag_name]
        @tag = Tag.find_or_create_by!(name: params[:tag_name])
      end

      if params[:file_name]
        @color_file = ColorFile.find_or_create_by!(name: params[:file_name], userId: @current_user.id)
      end

      tag_id = @tag ? @tag.id : @my_memo.tag_id
      color_file_id = @color_file ? @color_file.id : @my_memo.color_file_id

      @my_memo.update!(
        **memo_params,
        tag_id: tag_id,
        color_file_id: color_file_id,
      )
    end

    @updated_memo = {
      id: @my_memo.id,
      colorCode: @my_memo.colorCode,
      comment: @my_memo.comment,
      url: @my_memo.url,
      tagName: @my_memo.tag.name,
      created_at: @my_memo.created_at
    }

    render json: @updated_memo
  rescue => e
    render json: { error: "Not editable" }, status: :unprocessable_entity
  end

  # DELETE /memos/1
  def destroy
    @my_memo.destroy
  end

  private
    def my_set_memo
      @my_memo = @current_user.memos.find(params[:id])
    rescue => e
      render json: { error: "Memo does not exist" }, status: :not_found
    end

    # Only allow a list of trusted parameters through.
    def memo_params
      params.permit(:colorCode, :comment, :url)
    end
end
