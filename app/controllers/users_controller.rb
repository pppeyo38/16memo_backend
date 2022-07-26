class UsersController < ApplicationController
  before_action :set_my_account, only: %i[ account edit_nickname ]

  # GET /users
  def index
    @users = User.all
    render json: @user
  end

  # GET /users/1
  def show
    render json: @user
  end

  def account
    render json: @my_account
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def edit_nickname
    puts @my_account.nickname
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private
    def set_my_account
      @my_account = current_user
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:firebase_id, :nickname, :created_id)
    end
end
