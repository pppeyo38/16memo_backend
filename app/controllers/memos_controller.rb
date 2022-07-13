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
    # puts "-------------------------"
    # puts memo_params

    @tag = Tag.find_by(name: memo_params.tag_name)
    @color_file = ColorFile.find_by(name: memo_params.color_file_name)

    puts @tag
    puts @color_file

    # # TODO: transaction をつける
    # unless @tag
    #   @tag = Tag.create!(name: memo_params.tag_name)
    # end
    # unless @color_file
    #   @color_file = ColorFile.create!(name: memo_params.color_file_name)
    # end

    # @memo = Memo.create!(
    #   # TODO: ログイン中のユーザーIDを指定する
    #   user_id: 1,
    #   tag_id: @tag.id,
    #   color_file_id: @color_file.id,
    #   color_code: memo_params.color_code,
    #   comment: memo_params.comment,
    #   url: memo_params.url,
    # )




    # if @memo.save
    #   render json: @memo, status: :created, location: @memo
    # else
    #   render json: @memo.errors, status: :unprocessable_entity
    # end

    # render json: @memo
    render json: []
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
      params.require(:memo).permit(:user_id, :tag_name, :color_file_name, :color_code, :comment, :url)
    end
end
