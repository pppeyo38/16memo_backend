class AuthController < ApplicationController
  skip_before_action :authenticate_user!

  def signup
    ActiveRecord::Base.transaction do
      # User.create が失敗したときにトランザクションが機能しない
      @firebase_user = FirebaseAuth.create_user(email: params[:email], password: params[:password])

      while @unique_createID.blank? || User.find_by(createdID: @unique_createID).present? do
        @unique_createID = SecureRandom.alphanumeric(10)
      end
      puts "------------"
      puts @unique_createID
      puts "------------"
      @user = User.create!(
        nickname: params[:nickname],
        firebase_id: @firebase_user.local_id,
        createdID: @unique_createID
      )
    end
    render json: {
      id: @user.id,
      nickname: @user.nickname,
      createdID: @user.createdID
    }, status: :created
  rescue ActiveRecord::RecordInvalid => e
    render json: { errors: e.message, text: "auth_controller.rb:19" }, status: :unprocessable_entity
  rescue Google::Apis::Error, StandardError => e
    render json: { error: e.message, text: "auth_controller.rb:21" }, status: :internal_server_error
  end

  def login
    render json: { id: current_user.id, nickname: current_user.nickname, createdID: current_user.createdID }
  end

  private

  def user_params
    params.permit(:nickname, :createdID)
  end
end