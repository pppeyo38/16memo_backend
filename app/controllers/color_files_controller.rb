class ColorFilesController < ApplicationController
  before_action :set_color_file, only: %i[ update destroy ]

  # GET /color_files
  def index
    # TODO: ログイン中のユーザーの user_id を取得する
    user_id = 3

    @color_files = ColorFile.eager_load(user: :memos).where(users: { id: user_id })

    @file = @color_files.map do | color_file |
      # ファイル内カラー4色
      @main_color = color_file.memos.first(4).map {|m| m.color_code}
      @color_num = color_file.memos.length

      {
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
    @get_memos = Memo.joins(:tag).where(color_file_id: params[:id])
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

    @color_file = ColorFile.find(params[:id])
    @memos_file = {
      id: @color_file.id,
      name: @color_file.name,
      memos: @memos
    }

    render json: @memos_file
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
