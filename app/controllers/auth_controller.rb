class AuthController < ApplicationController
  skip_before_action :authenticate_user!

  def signup
    ActiveRecord::Base.transaction do
      # User.create が失敗したときにトランザクションが機能しない
      @firebase_user = FirebaseAuth.create_user(email: params[:email], password: params[:password])
      @user = User.create!(
        **user_params,
        firebase_id: @firebase_user.local_id
      )
    end

    render json: {
      **@user.attributes,
      email: @firebase_user.email
    }, status: :created
  rescue ActiveRecord::RecordInvalid => e
    render json: { errors: e.message, text: "auth_controller.rb:19" }, status: :unprocessable_entity
  rescue Google::Apis::Error, StandardError => e
    render json: { error: e.message, text: "auth_controller.rb:21" }, status: :internal_server_error
  end

  def login
    render json: current_user
  end

  private

  def user_params
    params.permit(:nickname, :createdID)
  end
end