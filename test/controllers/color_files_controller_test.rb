require "test_helper"

class ColorFilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @color_file = color_files(:one)
  end

  test "should get index" do
    get color_files_url, as: :json
    assert_response :success
  end

  test "should create color_file" do
    assert_difference("ColorFile.count") do
      post color_files_url, params: { color_file: { name: @color_file.name, user_id: @color_file.user_id } }, as: :json
    end

    assert_response :created
  end

  test "should show color_file" do
    get color_file_url(@color_file), as: :json
    assert_response :success
  end

  test "should update color_file" do
    patch color_file_url(@color_file), params: { color_file: { name: @color_file.name, user_id: @color_file.user_id } }, as: :json
    assert_response :success
  end

  test "should destroy color_file" do
    assert_difference("ColorFile.count", -1) do
      delete color_file_url(@color_file), as: :json
    end

    assert_response :no_content
  end
end
