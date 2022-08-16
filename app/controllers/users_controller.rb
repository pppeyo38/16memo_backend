class UsersController < ApplicationController
  before_action :set_my_account, only: %i[ settings_account delete_account ]
  skip_before_action :authenticate_user!, only: %i[ destroy ]

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
    @get_firebase_user = FirebaseAuth.get_user(uid: current_user.firebase_id)

    @my_account = {
      id: current_user.id,
      nickname: current_user.nickname,
      createdID: current_user.createdID,
      email: @get_firebase_user.email
    }

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

  def settings_account
    if @my_account.update(user_params)
      render json: @my_account
    else
      render json: @my_account.errors, status: :unprocessable_entity
    end
  end

  def settings_authAccount
    @test = FirebaseAuth.update_user(uid: current_user.firebase_id, email: params[:email], password: params[:password])
    render json: @test
  end

  # DELETE /users/1
  def destroy
    User.find(params[:id]).destroy
  end

  def delete_account
    ApplicationRecord.transaction do
      FirebaseAuth.delete_user(uid: @my_account.firebase_id)
      @my_account.destroy
    end

  rescue ActiveRecord::RecordInvalid => e
    render json: { errors: e.message, text: "auth_controller.rb:19" }, status: :unprocessable_entity
  rescue Google::Apis::Error, StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  private
    def set_my_account
      @my_account = current_user
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:firebase_id, :nickname, :createdID)
    end
end
