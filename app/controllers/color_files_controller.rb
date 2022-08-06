class ColorFilesController < ApplicationController
  before_action :set_my_color_file, only: %i[ show update destroy ]

  # GET /color_files
  def index
    @my_color_files = ColorFile.eager_load(:memos).where(userId: @current_user.id)

    @my_files = @my_color_files.map do | my_color_file |
      # ファイル内カラー4色
      @main_color = my_color_file.memos.first(4).map {|m| m.colorCode}
      @color_num = my_color_file.memos.length

      {
        id: my_color_file.id,
        name: my_color_file.name,
        userId: my_color_file.userId,
        memo: {
          mainColor: @main_color,
          colorNum: @color_num
        },
        created_at: my_color_file.created_at
      }
    end

    render json: @my_files
  end

  # GET /files_name
  def files_name
    @get_my_files = ColorFile.where(userId: current_user.id)

    @get_files_name = @get_my_files.map do | get_my_file |
      {
        id: get_my_file.id,
        name: get_my_file.name
      }
    end

    render json: @get_files_name
  end

  # GET /color_files/1
  def show
    # リクエストで送られてきたidのcolor_file作成者がログインユーザーのものか検証
    if @my_color_file
      @get_memos = Memo.joins(:tag).where(color_file_id: params[:id])

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

      @color_file = ColorFile.find(params[:id])
      @memos_file = {
        id: @color_file.id,
        name: @color_file.name,
        memos: @memos
      }

      render json: @memos_file
    end
  end

  # POST /color_files
  def create
    @my_color_file = ColorFile.new(**color_file_params, userId: @current_user.id)

    if @my_color_file.save
      render json: @my_color_file, status: :created, location: @my_color_file
    else
      render json: @my_color_file.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /color_files/1
  def update
    if @my_color_file.update(color_file_params)
      render json: @my_color_file
    else
      render json: @my_color_file.errors, status: :unprocessable_entity
    end
  end

  # DELETE /color_files/1
  def destroy
    @my_color_file.destroy
  end

  private
    def set_my_color_file
      @my_color_file = @current_user.color_files.find(params[:id])
    rescue => e
      render json: { error: "File does not exist" }, status: :not_found
    end

    # Only allow a list of trusted parameters through.
    def color_file_params
      params.require(:color_file).permit(:name)
    end
end
